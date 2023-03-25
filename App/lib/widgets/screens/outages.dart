import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/outage_retrieval_service.dart';
import 'package:black_out_groutages/widgets/components/loading.dart';
import 'package:black_out_groutages/widgets/components/warning.dart';
import '../components/prefectures_dropdown.dart';
import 'package:flutter/material.dart';
import '../components/outage_list_item.dart';

/// This widget is used in order to populate the Outages list to be shown to the users.
/// By default, it shows the Outages of Thessaloniki, Greece and gives the ability to the user
/// to select the prefecture of his choice and see any planned outages.
class OutagesScreen extends StatefulWidget {
  final String title;

  const OutagesScreen({
    required Key key,
    required this.title,
  }) : super(key: key);

  @override
  _OutagesScreenState createState() => _OutagesScreenState();
}

class _OutagesScreenState extends State<OutagesScreen> {
  List<OutageListItem> outageListItems =
      List<OutageListItem>.empty(growable: true);
  PrefectureDto selectedPrefecture = PrefectureDto.defaultPrefecture();
  OutageRetrievalService outageRetrievalService = new OutageRetrievalService();

  /// Trigger a new data download for the new prefecture. [setState()] will
  /// trigger a rebuild of the widget, which will lead on displaying the
  /// data retrieved for the selected prefecture.
  void onPrefectureSelected() {
    setState(() {
      outageListItems.clear();
      outageRetrievalService
          .getOutagesFromOfficialSource(selectedPrefecture, outageListItems)
          .then((value) => outageListItems = value);
    });
  }

  /// Populates the outages list that will be shown on the screen.
  Widget outagesList(BuildContext context) {
    return Material(
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[...outageListItems]));
  }

  /// Performs a request to the official API where all the Greek planned
  /// outages are reported.
  ///
  /// * If there aren't any outages for the selected prefecture, returns an empty List.
  /// * If the request has not been completed, returns a loading indicator.
  /// * if there are no data to be displayed, shows a warning screen informing the user.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: outageRetrievalService.getOutagesFromOfficialSource(
          selectedPrefecture, outageListItems),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is List<OutageListItem>) {
            outageListItems = snapshot.data as List<OutageListItem>;
          }
          return widgetOutagesList();
        } else if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          return widgetLoadingOutages();
        } else {
          return widgetNoOutagesData();
        }
      },
    );
  }

  Widget widgetOutagesList() {
    return Scaffold(
      body: Column(children: [
        PrefecturesDropdown((value) {
          onPrefectureSelected();
          return selectedPrefecture = value;
        }),
        Flexible(
          child: outagesList(context),
        )
      ]),
    );
  }

  Widget widgetLoadingOutages() {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Loading(label: 'Loading data...')]));
  }

  Widget widgetNoOutagesData() {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Warning(label: 'No outages for the selected prefecture')
        ]));
  }
}
