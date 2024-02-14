import 'package:flutter/material.dart';
import 'package:my_chat_app/constants/constants.dart';
import 'package:my_chat_app/widgets/Drop_Down.dart';

import '../widgets/text_widget.dart';

class Services {
  static Future <void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    backgroundColor: scaffoldBackgroundColor,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
          Flexible(
              child: TextWidget(
            label: "Chosen Model:",
            fontSize: 16,
          )
          ),
            SizedBox(
              width: 16,
            ),
            Flexible(
                flex: 2,
                child: ModelDropDownWidget()),
        ],
        ),
      );
    });
  }
}