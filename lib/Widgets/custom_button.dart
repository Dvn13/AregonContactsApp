import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;
  final bool isLoading;
  final void Function()? onPressed;

  const CustomButton(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.height,
      this.onPressed,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: ConstColor.white,
      fontSize: fontSize,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: Size(double.infinity, height),
        backgroundColor: ConstColor.darkgreen,
      ),
      child: Container(
        alignment: Alignment.center,
        child: isLoading
            ? CircularProgressIndicator(
                color: ConstColor.white,
              )
            : buttonText(textStyle),
      ),
    );
  }

  Text buttonText(TextStyle textStyle) =>
      Text(text, style: textStyle, textAlign: TextAlign.center);
}
