import 'package:black_out_groutages/services/data_persist.dart';
import 'package:black_out_groutages/widgets/components/badge_button.dart';

import '../models/outage_dto.dart';
import 'navigation/app_bar.dart';
import 'navigation/bottom_bar.dart';
import 'package:flutter/material.dart';

/// Shadow Widget that is responsible for holding the current screen to be displayed,
/// implements the functionality of selecting different screens from Bottom Bar and
/// displays the Top / Bottom bar widgets.
class Base extends StatefulWidget {
  const Base({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  /// Indicates the widget position of [screens] array to be selected.
  int selectedIndex = 0;

  /// Called every time an item is selected from the [BottomBar].
  ///
  /// * If the [BottomBar.screens] array is larger than the [BottomBar] icons, the extra screens cannot be selected.
  /// * The [BottomBar.screens] array must not be smaller than the number of icons shown in the [BottomBar].
  void onClicked(int index) {
    setState(() {
      if (selectedIndex < BottomBar.screens.length) {
        selectedIndex = index;
        if (selectedIndex == 1) {
          BadgeButton.notificationsSeen = true;
          changeNotificationsBadgeVisibility(calculateBadgeButtonVisibility());
        }
      } else {
        selectedIndex = 0;
      }
    });
  }

  bool calculateBadgeButtonVisibility() {
    List<OutageDto> outages = DataPersistService()
        .getSavedOutages(DataPersistService.notificationsOutagesList);
    outages = OutageDto.filterOutagesList(outages);

    bool badgeButtonVisibility = outages.isNotEmpty;
    BadgeButton.numberOfNotifications = outages.length;

    return BadgeButton.notificationsSeen ? false : badgeButtonVisibility;
  }

  void changeNotificationsBadgeVisibility(bool newVisibility) {
    setState(() {
      BadgeButton.isVisible = newVisibility;
    });
  }

  /// Holds the AppBar and BottomBar of the whole application.
  /// On the body shows the widget that is on [selectedIndex] position
  /// of the [screens].
  @override
  Widget build(BuildContext context) {
    changeNotificationsBadgeVisibility(calculateBadgeButtonVisibility());
    return Scaffold(
        appBar: BaseAppBar(appBar: AppBar()),
        body: Container(child: BottomBar.screens[selectedIndex]),
        bottomNavigationBar:
            BottomBar(selectedIndex: selectedIndex, onClicked: onClicked));
  }
}
