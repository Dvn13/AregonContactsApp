import 'package:flutter/material.dart';

class CustomBottomSheet {
  void showBottomSheet(BuildContext context, List<BottomSheetOption> options) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetOptions(
          options: options,
        );
      },
    );
  }
}

class BottomSheetOption {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  BottomSheetOption({
    required this.icon,
    required this.text,
    required this.onTap,
  });
}

class BottomSheetOptions extends StatelessWidget {
  final List<BottomSheetOption> options;

  const BottomSheetOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: options.map((option) {
        return ListTile(
          leading: Icon(option.icon),
          title: Text(option.text),
          onTap: () {
            option.onTap(); 
            Navigator.pop(context);
          },
        );
      }).toList(),
    );
  }
}
