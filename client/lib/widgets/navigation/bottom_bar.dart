import 'package:black_out_groutages/widgets/components/badge_button.dart';

import '../screens/notifications.dart';
import 'package:flutter/material.dart';

import '../screens/outages.dart';
import '../screens/settings.dart';

/// ----------------------------------------------------------------------------
/// bottom_bar.dart
/// ----------------------------------------------------------------------------
/// Implements the bottom navigation bar.
class BottomBar extends StatelessWidget {
  /// Represents the position of the bottom navigation bar item that was selected.
  final int selectedIndex;

  /// Reports that the selectedIndex value has changed.
  final ValueChanged<int> onClicked;

  /// Constructor accepting the [selectedIndex] and the [onClicked] callback.
  /// This is in order to be aware that the [selectedIndex] value has changed (a new item was selected).
  const BottomBar(
      {Key? key, required this.selectedIndex, required this.onClicked})
      : super(key: key);

  /// Contains all the screens and their respective positions.
  /// The widget on each position must be mapped to the respective item of [BottomBar].
  static List screens = [
    const OutagesScreen(
      key: Key("Black Out"),
      title: "Black Out",
    ),
    const Notifications(),
    const Settings()
  ];

  /// Builds the BottomNavigationBar widget to be used across the whole application.
  ///
  /// * The [items] array needs to have the same items as defined in the [screens] array.
  /// * The [items] and [screens] must be mapped 1-1.
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Outages',
        ),
        BadgeButton(
                icon: const Icon(Icons.notifications), label: 'Notifications')
            .badgeButton(context),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        )
      ],
      currentIndex: selectedIndex,
      onTap: onClicked,
      selectedItemColor: const Color(0XFFB00020),
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
    );
  }
}
