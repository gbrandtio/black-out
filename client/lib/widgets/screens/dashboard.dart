import 'package:black_out_groutages/services/outage_retrieval_service.dart';
import 'package:black_out_groutages/widgets/components/notification_list_item.dart';
import 'package:black_out_groutages/widgets/components/warning.dart';
import 'package:flutter/material.dart';

/// ----------------------------------------------------------------------------
/// dashboard.dart
/// ----------------------------------------------------------------------------
/// Displays a dashboard with various statistics about electricity outages.
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Flexible(child: widgetDashboardStatistics())],
    );
  }

  Widget widgetDashboardStatistics() {
    return const Center(child: Warning(label: "Coming soon"));
  }
}
