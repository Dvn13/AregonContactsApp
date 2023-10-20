import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:flutter/material.dart';


class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  const CustomIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}

class CustomTextIconButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomTextIconButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          Icons.image,
          color: ConstColor.darkgreen,
        ),
        label: Text(
          text,
          style: TextStyle(color: ConstColor.darkgreen),
        ));
  }
}
