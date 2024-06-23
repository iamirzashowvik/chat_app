import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/common_widgets/space/k_sized.dart';
import 'package:chat_app/src/constants/app_strings.dart';
import 'package:chat_app/src/constants/assets.dart';
import 'package:chat_app/src/features/authentication/controller/auth_controller.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends BaseView {
  SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseViewState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(
          AssetsPath.logo,
          height: 150,
          width: MediaQuery.of(context).size.width,
        ),
        Text(
          AppStrings.appName,
          style: lgBold.copyWith(color: Colors.black),
        ),
        kSizedBox(),
        Text(
          AppStrings.motivation,
          style: smBold.copyWith(color: Colors.black),
        ),
        const Spacer(),
      ],
    );
  }

  @override
  bool defaultPadding() => false;

  @override
  bool scrollable() => false;
}
