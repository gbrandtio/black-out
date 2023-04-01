import 'package:black_out_groutages/services/data_persist.dart';
import 'package:flutter/material.dart';

/// ----------------------------------------------------------------------------
/// badge_button.dart
/// ----------------------------------------------------------------------------
/// Implements a button with the ability to show a notification badge.
class BadgeButton extends BottomNavigationBarItem {
  static bool isVisible = false;
  static bool notificationsSeen = false;
  static int numberOfNotifications = 0;

  BadgeButton({required super.icon, required super.label});

  BottomNavigationBarItem badgeButton(BuildContext context) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: <Widget>[
          const Icon(Icons.notifications),
          Visibility(
              visible: isVisible,
              child: Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    numberOfNotifications.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ],
      ),
      label: 'Notifications',
    );
  }
}
