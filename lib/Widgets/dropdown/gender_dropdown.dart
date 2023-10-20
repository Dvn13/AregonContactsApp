import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/padding.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:contacts_app/Widgets/custom_container.dart';
import 'package:flutter/material.dart';

class GenderDropDown extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? value;
  final String hintText;
  const GenderDropDown(
      {Key? key, this.onChanged, required this.value, required this.hintText})
      : super(key: key);

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  final Map<String, int> genderMap = {
    ConstText.male: 1,
    ConstText.female: 2,
  };
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.value,
        underline: null,
        isExpanded: true,
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.all(ConstPadding.paddingSmall),
        items: genderMap.entries.map<DropdownMenuItem<String>>(
          (MapEntry<String, int> entry) {
            return DropdownMenuItem<String>(
              value: entry.value.toString(),
              child: Text(entry.key),
            );
          },
        ).toList(),
        hint: Text(
          widget.hintText,
          style: TextStyle(
            color: ConstColor.black,
          ),
        ),
        onChanged: widget.onChanged,
      ),
    ));
  }
}
