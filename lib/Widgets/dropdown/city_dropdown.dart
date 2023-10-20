import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/padding.dart';
import 'package:contacts_app/Pages/contacts/model/city_model.dart';
import 'package:contacts_app/Pages/contacts/model/town_model.dart';
import 'package:contacts_app/Widgets/custom_container.dart';
import 'package:flutter/material.dart';

class CityDropDown extends StatefulWidget {
  final List<Iller> cities;
  final List<Ilceler> town;
  final void Function(String?)? onChanged;
  final String? value;
  final String hintText;
  const CityDropDown(
      {Key? key,
      required this.cities,
      this.onChanged,
      required this.value,
      required this.hintText,
      required this.town})
      : super(key: key);

  @override
  State<CityDropDown> createState() => _CityDropDownState();
}

class _CityDropDownState extends State<CityDropDown> {
  late List<DropdownMenuItem<String>> menuItem;

  @override
  Widget build(BuildContext context) {
    if (widget.cities.isNotEmpty) {
      menuItem = widget.cities.map((Iller city) {
        return DropdownMenuItem<String>(
          value: city.cityId.toString(),
          child: Text(city.cityName ?? ""),
        );
      }).toList();
    } else if (widget.town.isNotEmpty) {
      menuItem = widget.town.map((Ilceler town) {
        return DropdownMenuItem<String>(
          value: town.townId.toString(),
          child: Text(town.townName ?? ""),
        );
      }).toList();
    } else {
      menuItem = [];
    }

    return CustomContainer(
        child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.value,
        underline: null,
        isExpanded: true,
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.all(ConstPadding.paddingSmall),
        items: menuItem,
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
