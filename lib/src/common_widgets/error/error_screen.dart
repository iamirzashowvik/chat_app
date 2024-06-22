import 'package:chat_app/src/common_widgets/base/base_view.dart';
import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends BaseView {
  @override
  BaseViewState<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends BaseViewState<ErrorScreen> {
  @override
  bool defaultPadding() => false;

  @override
  bool scrollable() => false;

  @override
  Widget body() {
    return const KErrorWidget();
  }
}

class KErrorWidget extends StatelessWidget {
  const KErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            "OOPS",
            style: lgBold.copyWith(color: Colors.black),
          ),
          SizedBox(height: rgPadding),
          Text(
            "Check your internet connection",
            style: rgBold.copyWith(color: Colors.black),
          ),
          SizedBox(height: rgPadding),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  """We can't seem to connect to the internet. Please check your connection and try again.""",
              style: rgBook.copyWith(color: Colors.black),
              children: [],
            ),
          ),
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Retry",
              style: rgBold.copyWith(color: Colors.black),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
