import 'package:chat_app/src/common_widgets/error/error_screen.dart';
import 'package:chat_app/src/utils/services/connectivity.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin _BaseView {
  Widget build(BuildContext context) {
    buildMethod();

    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Consumer(builder: (context, ref, _) {
          return ref.watch(networkStatusProvider).when(
              data: (network) {
                return network == NetworkStatus.OFFLINE
                    ? const KErrorWidget()
                    : scrollable()
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding() ? rgPadding : 0),
                              child: body(),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding() ? rgPadding : 0),
                            child: body(),
                          );
              },
              loading: () => const CircularProgressIndicator.adaptive(),
              error: (e, stackTrace) => const KErrorWidget());
        }),
      ),
    );
  }

  bool scrollable() => true;

  bool defaultPadding() => true;

  PreferredSizeWidget? appBar() => null;

  Widget body() => Container();

  void buildMethod() => () {};
}

class BaseView extends ConsumerStatefulWidget {
  BaseView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BaseViewState();
}

class BaseViewState<Screen extends BaseView> extends ConsumerState<Screen>
    with _BaseView {}
