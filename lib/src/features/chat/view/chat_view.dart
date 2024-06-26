import 'package:chat_app/src/common_widgets/appbar/k_appbar.dart';
import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/common_widgets/space/k_sized.dart';
import 'package:chat_app/src/constants/app_strings.dart';
import 'package:chat_app/src/constants/assets.dart';
import 'package:chat_app/src/features/authentication/controller/auth_controller.dart';
import 'package:chat_app/src/features/chat/controller/chat_controller.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends BaseView {
  ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseViewState<ChatView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.medium4, () {
      ref.watch(chatProvider).getAllUsers();
      ref.watch(chatProvider).getFriends();
      ref.watch(authProvider).getMyId();
    });
  }

  @override
  Widget body() {
    var users = ref.watch(chatProvider).allUsers;
    var threads = ref.watch(chatProvider).threads;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kSizedBox(),
        Text(
          "People you can chat with",
          style: rgBold.copyWith(color: Colors.black),
        ),
        kSizedBox(),
        SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    AppRouters.goToThread(users[index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: rgPadding),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(users[index].photoUrl),
                        ),
                        Text(users[index].username.split(' ')[0])
                      ],
                    ),
                  ),
                );
              }),
        ),
        Text("Your Chats", style: rgBold.copyWith(color: Colors.black)),
        kSizedBox(),
        ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: rgPadding),
                child: GestureDetector(
                  onTap: () {
                    AppRouters.goToThread(threads[index].user);
                  },
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white54),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(threads[index].user.photoUrl),
                        ),
                        SizedBox(
                          width: rgPadding,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isMe(threads[index].user.uid)
                                  ? "Saved Messages (YOU)"
                                  : threads[index].user.username,
                              style: rgBold.copyWith(
                                  color: Colors.black, fontSize: titleSize),
                            ),
                            Text(
                              threads[index].message,
                              style: rgBold.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: threads.length),
      ],
    );
  }

  @override
  PreferredSizeWidget? appBar() {
    return kAppBar(
        title: AppStrings.appName,
        actions: [
          IconButton(
            onPressed: () {
              AppRouters.goSettings();
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
        leading: Image.asset(
          AssetsPath.logo,
          height: 30,
          width: 30,
        ));
  }

  @override
  bool defaultPadding() => true;

  @override
  bool scrollable() => false;
}
