import 'package:chat_app/src/features/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/src/utils/models/user.dart';

class SendMessageWidget extends HookWidget {
  const SendMessageWidget({super.key, required this.user});
  final KUser user;

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    return Consumer(builder: (widget, ref, _) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Write a message...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              if (messageController.text.isNotEmpty) {
                ref
                    .read(chatProvider)
                    .sendMessage(messageController.text, user);
                messageController.clear();
              }
            },
          ),
        ],
      );
    });
  }
}
