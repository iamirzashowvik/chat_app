import 'package:chat_app/src/utils/styles.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget kAppBar({String title = '', List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.teal,
    title: Text(
      title,
      style: rgBold.copyWith(fontSize: titleSize),
    ),
    actions: actions,
  );
}
