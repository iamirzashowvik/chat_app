import 'package:chat_app/src/common_widgets/appbar/k_appbar.dart';
import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/features/authentication/controller/auth_controller.dart';
import 'package:chat_app/src/features/chat/view/text_field.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/models/user.dart';
import 'package:chat_app/src/utils/services/cloud_db.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThreadView extends BaseView {
  final KUser? user;
  ThreadView({super.key, this.user});
  @override
  ConsumerState<ThreadView> createState() => _ThreadViewState();
}

class _ThreadViewState extends BaseViewState<ThreadView> {
  @override
  Widget body() {
    var myId = ref.watch(authProvider).myId;
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: CloudDB().getMessages(widget.user!, myId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text("No messages"));
                  }

                  final messages = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;

                    return Row(
                      children: [
                        isMe(data['senderUid'])
                            ? const Spacer()
                            : const SizedBox(),
                        isMe(data['senderUid'])
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(widget.user!.photoUrl),
                              ),
                        SizedBox(
                          width: rgPadding,
                        ),
                        Container(
                          padding: EdgeInsets.all(rgPadding),
                          margin: EdgeInsets.only(bottom: rgPadding),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(rgPadding)),
                          child: Text(
                            data['message'],
                            style: rgBook.copyWith(color: Colors.black),
                          ),
                        )
                      ],
                    );
                  }).toList();

                  return ListView(
                    children: messages,
                    reverse: true,
                  );
                },
              ),
            ],
          ),
        ),
        SendMessageWidget(user: widget.user!),
      ],
    );
  }

  @override
  bool defaultPadding() => true;

  @override
  bool scrollable() => false;

  @override
  PreferredSizeWidget? appBar() {
    return kAppBar(
      leading: IconButton(
          onPressed: () {
            AppRouters.goHome();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
      title: widget.user!.username,
    );
  }
}
