import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/constants/app_strings.dart';
import 'package:chat_app/src/features/authentication/controller/auth_controller.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends BaseView {
  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseViewState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      bool isAuthenticated = ref.watch(authProvider).checkAuth();
      if (isAuthenticated) {
        AppRouters.goHome();
      } else {
        AppRouters.goAuth();
      }
    });
  }

  @override
  Widget body() {
    return Column(
      children: [
        Spacer(),
        Center(
          child: Text(
            AppStrings.appName,
            style: lgBold.copyWith(color: Colors.black),
          ),
        ),
        Spacer(),
      ],
    );
  }

  @override
  bool defaultPadding() => false;

  @override
  bool scrollable() => false;
}
