import 'package:flutter/material.dart';

import '../Helpers/constants/color.dart';

class CustomTextButton extends StatelessWidget {
  final String url;
  final String label;
  final bool active;
  final Function()? onPressed;
  const CustomTextButton(
      {super.key,
      required this.url,
      required this.label,
      required this.active,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: url != ""
            ? active
                ? null
                : onPressed
            : null,
        child: Text(
          label,
          style: TextStyle(color: active ? ConstColor.white : ConstColor.black),
        ));
  }
}
