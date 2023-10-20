import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  static Future<Future<bool?>> showAlertDialog(
      BuildContext context,
      String title,
      String content,
      final void Function()? isYes,
      final void Function()? isNo) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: isYes,
              child: Text(
                ConstText.yes,
                style: TextStyle(color: ConstColor.red),
              ),
            ),
            TextButton(
              onPressed: isNo,
              child: Text(
                ConstText.no,
                style: TextStyle(color: ConstColor.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
