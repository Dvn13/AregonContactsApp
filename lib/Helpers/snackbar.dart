import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/padding.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSnackbar(BuildContext context, String message, int state) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(state==1?Icons.check : Icons.error, color:ConstColor.white,),
          Padding(
            padding: const EdgeInsets.only(left:ConstPadding.paddingMedium),
            child: Text(message),
          ),
        ],
      ),
      backgroundColor: state == 1 ? ConstColor.darkgreen : ConstColor.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
