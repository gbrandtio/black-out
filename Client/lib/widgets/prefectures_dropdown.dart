import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PrefecturesDropdown extends StatefulWidget {
  const PrefecturesDropdown({Key? key}) : super(key: key);

  @override
  State<PrefecturesDropdown> createState() => _PrefecturesDropdownState();
}

class _PrefecturesDropdownState extends State<PrefecturesDropdown> {
  String defaultPrefecture = "Athens";
  List<String> prefectures = <String>["Athens", "Thessaloniki", "Dhodekanisa"];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: defaultPrefecture,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: const Color(0xFFB00020),
      ),
      onChanged: (String? newValue) {
        setState(() {
          defaultPrefecture = newValue!;
        });
      },
      items: prefectures
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}