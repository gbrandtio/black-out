import 'package:black_out_groutages/widgets/AppBar.dart';
import 'package:black_out_groutages/widgets/BottomBar.dart';
import 'package:black_out_groutages/widgets/OutagesScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/OutageDto.dart';
import '../services/Parser.dart';
import '../services/Rest.dart';

/// Shadow Widget that is responsible for holding the current screen to be displayed,
/// implements the functionality of selecting different screens from Bottom Bar and
/// displayes the Top / Bottom bar widgets.
class Base extends StatefulWidget {
  const Base({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  /// Indicates the widget position of [screens] array to be selected.
  int selectedIndex = 0;

  /// Contains all the screens and their respective positions.
  /// The widget on each position must be mapped to the respective item of [BottomBar].
  List screens = [const OutagesScreen(key: Key("Black Out"), title: "Black Out"), Colors.red, Colors.black54];

  /// Called every time an item is selected from the [BottomBar].
  ///
  /// * If the [screens] array is larger than the [BottomBar] icons, the extra screens cannot be selected.
  /// * The [screens] array must not be smaller than the number of icons shown in the [BottomBar].
  void onClicked(int index) {
    setState(() {
      if (selectedIndex < screens.length) {
        selectedIndex = index;
      }
      else {
        selectedIndex = 0;
      }
    });
  }

  /// Holds the AppBar and BottomBar of the whole application.
  /// On the body shows the widget that is on [selectedIndex] position
  /// of the [screens].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(appBar: AppBar()),
        body: Container(child: screens[selectedIndex]),
        bottomNavigationBar:
            BottomBar(selectedIndex: selectedIndex, onClicked: onClicked));
  }
}
