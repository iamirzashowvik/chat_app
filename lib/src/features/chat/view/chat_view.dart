import 'package:chat_app/src/common_widgets/appbar/k_appbar.dart';
import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/constants/app_strings.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends BaseView {
  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseViewState<ChatView> {
  @override
  Widget body() {
    return Column(
      children: [],
    );
  }

  @override
  PreferredSizeWidget? appBar() {
    return kAppBar(title: AppStrings.appName, actions: [
      IconButton(
        onPressed: () {
          AppRouters.goSettings();
        },
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
      )
    ]);
  }

  @override
  bool defaultPadding() => true;

  @override
  bool scrollable() => false;
}
