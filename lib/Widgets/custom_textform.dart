import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/padding.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final IconData? icon;
  final TextEditingController? control;
  final void Function(String)? onChanged;
  final bool isPassword;
  final TextInputType? keyboardType;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.text,
    this.control,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.readOnly = false,
  });

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta adresi boş olamaz.';
    }
    if (!EmailValidator.validate(value)) {
      return 'Geçerli bir e-posta adresi giriniz.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: ConstColor.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            field(),
            const SizedBox(width: 5),
            icon != null ? fieldIcon() : Container(),
          ],
        ));
  }

  Padding fieldIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: ConstPadding.paddingSmall),
      child: Icon(
        icon,
        color: ConstColor.darkgreen,
      ),
    );
  }

  Expanded field() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: TextFormField(
          autofocus: false,
          autocorrect: false,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: control,
          obscureText: isPassword,
          readOnly: readOnly,
          validator: ((value) {
            if (keyboardType == TextInputType.emailAddress) {
              return _validateEmail(value);
            }
            if (keyboardType == TextInputType.text) {
              return value != '' ? null : '$text ${ConstText.notNull}';
            }
            return null;
          }),
          onChanged: onChanged,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(color: ConstColor.grey)),
        ),
      ),
    );
  }
}
