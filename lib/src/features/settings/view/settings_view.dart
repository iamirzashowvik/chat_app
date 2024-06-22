import 'package:chat_app/src/common_widgets/appbar/k_appbar.dart';
import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/features/authentication/controller/auth_controller.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends BaseView {
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
      children: [
        ListTile(
            title: Text(
              'Logout',
              style: rgBold.copyWith(color: Colors.black),
            ),
            onTap: () {
              ref.watch(authProvider).signOut();
            })
      ],
    );
  }

  @override
  bool defaultPadding() => true;

  @override
  bool scrollable() => false;

  @override
  PreferredSizeWidget? appBar() {
    return kAppBar(title: 'Settings');
  }
}
