import 'package:flutter/material.dart';

import '../../../../constant/constants.dart';
import '../../../../local.db/db.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../settings/domain/settings.model.dart';
import '../../domain/message.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(this.message, {super.key, this.previous, this.next});

  final MessageModel? previous;
  final MessageModel message;
  final MessageModel? next;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        mainAxisAlignment: mainEnd,
        children: [
          if (previous == null ||
              previous!.created.toLocal().day != message.created.toLocal().day)
            Text(
              appSettings.getDateFormat.format(message.created.toLocal()),
            ),
          Row(
            mainAxisAlignment: message.isMeSender ? mainEnd : mainStart,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: context.width * 0.75),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: message.isMeSender
                      ? context.theme.primaryColor
                      : Colors.grey[800],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                    bottomLeft: message.isMeSender
                        ? const Radius.circular(20.0)
                        : const Radius.circular(0.0),
                    bottomRight: message.isMeSender
                        ? const Radius.circular(0.0)
                        : const Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      message.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: message.isMeSender
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              appSettings.getTimeFormat.format(message.created.toLocal()),
              style: context.text.labelSmall!.copyWith(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
