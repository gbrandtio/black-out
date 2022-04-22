import 'package:flutter/cupertino.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return const Text("Coming Soon", textAlign: TextAlign.center);
  }
}
