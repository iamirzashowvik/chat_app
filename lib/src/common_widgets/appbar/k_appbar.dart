import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget kAppBar(
    {String title = '', List<Widget>? actions, Widget? leading}) {
  return AppBar(
    leading: leading,
    backgroundColor: Colors.teal,
    title: Text(
      title,
      style: rgBold.copyWith(fontSize: titleSize),
    ),
    actions: actions,
  );
}
