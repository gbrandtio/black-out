import 'package:black_out_groutages/services/outage_retrieval_service.dart';
import 'package:black_out_groutages/widgets/components/notifications/notification_list_item.dart';
import 'package:black_out_groutages/widgets/components/common/warning.dart';
import 'package:flutter/material.dart';

/// ----------------------------------------------------------------------------
/// notifications.dart
/// ----------------------------------------------------------------------------
/// Displays the current notifications to the user.
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Flexible(child: widgetOutagesList())],
    );
  }

  Widget widgetOutagesList() {
    List<NotificationListItem> notificationListItems =
        OutageRetrievalService().getNotificationListItems();

    if (notificationListItems.isNotEmpty) {
      return notificationsList(context, notificationListItems);
    } else {
      return const Center(child: Warning(label: "No active notifications"));
    }
  }

  /// Populates the outages list that will be shown on the screen.
  Widget notificationsList(
      BuildContext context, List<NotificationListItem> notificationListItems) {
    return Material(
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[...notificationListItems]));
  }
}
