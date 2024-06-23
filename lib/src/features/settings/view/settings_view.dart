import 'package:chat_app/src/common_widgets/appbar/k_appbar.dart';
import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/common_widgets/space/k_sized.dart';
import 'package:chat_app/src/features/authentication/controller/auth_controller.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends BaseView {
  SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends BaseViewState<SettingsView> {
  @override
  Widget body() {
    ref.watch(authProvider).isUserAuthenticated == false
        ? Future.delayed(Duration.zero, () {
            AppRouters.goAuth();
          })
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kSizedBox(),
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL!,
          ),
        ),
        kSizedBox(),
        Text(
          FirebaseAuth.instance.currentUser!.displayName!,
          style: lgBold.copyWith(color: Colors.black),
        ),
        kSizedBox(),
        Text(
          FirebaseAuth.instance.currentUser!.email!,
          style: rgBold.copyWith(color: Colors.black),
        ),
        const Spacer(),
        GestureDetector(
            child: Text(
              'Logout',
              style: smBold.copyWith(color: Colors.black),
            ),
            onTap: () {
              ref.watch(authProvider).signOut();
            }),
        kSizedBox(),
      ],
    );
  }

  @override
  bool defaultPadding() => true;

  @override
  bool scrollable() => false;

  @override
  PreferredSizeWidget? appBar() {
    return kAppBar(title: 'Settings', leading: const KBackButton());
  }
}
