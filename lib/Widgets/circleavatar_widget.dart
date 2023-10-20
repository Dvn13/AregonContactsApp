import 'dart:io';

import 'package:contacts_app/Helpers/constants/application.dart';
import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? name;
  final String imgUrl;
  final double radius;
  final bool isNetwork;
  const CustomCircleAvatar(
      {super.key,
      required this.imgUrl,
      required this.radius,
      required this.isNetwork,
      this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ConstColor.darkgreen,
      radius: radius,
      backgroundImage: isNetwork
          ? NetworkImage(imgUrl != ""
              ? ApplicationConstats.CONTACTS_IMAGE_BASE_URL + imgUrl
              : ApplicationConstats.DEFAULT_IMAGE_URL + (name ?? ""))
          : Image.file(File(imgUrl)).image,
    );
  }
}
