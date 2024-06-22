import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';

Widget kButton(
    {String text = 'Button',
    required Function function,
    Color bgColor = Colors.teal}) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(rgPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(rgPadding * 2),
      ),
      child: Text(
        text,
        style: rgBold,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
