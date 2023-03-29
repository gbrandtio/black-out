import 'package:black_out_groutages/widgets/components/warning.dart';
import 'package:flutter/cupertino.dart';

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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Warning(label: "Coming Soon")],
      ),
    );
  }
}
