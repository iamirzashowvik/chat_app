import 'dart:developer';
import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/common_widgets/button/k_button.dart';
import 'package:chat_app/src/common_widgets/space/k_sized.dart';
import 'package:chat_app/src/constants/app_strings.dart';
import 'package:chat_app/src/constants/assets.dart';
import 'package:chat_app/src/features/authentication/controller/auth_controller.dart';
import 'package:chat_app/src/routing/router.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthView extends BaseView {
  AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends BaseViewState<AuthView> {
  @override
  Widget body() {
    ref.watch(authProvider).isUserAuthenticated
        ? Future.delayed(Duration.zero, () {
            log("User is authenticated");
            AppRouters.goHome();
          })
        : null;

    return Column(
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
        const Spacer(),
        ref.watch(authProvider).isLoading
            ? const Center(child: CircularProgressIndicator())
            : kButton(
                function: () {
                  ref.watch(authProvider).signInWithGoogle();
                },
                text: 'Login with Google'),
        kSizedBox(),
      ],
    );
  }

  @override
  bool defaultPadding() => true;

  @override
  bool scrollable() => false;
}
