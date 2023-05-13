import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist.dart';
import 'package:black_out_groutages/services/outage_retrieval_service.dart';
import 'package:black_out_groutages/services/outages_handler.dart';
import 'package:black_out_groutages/widgets/components/loading.dart';
import 'package:black_out_groutages/widgets/components/warning.dart';
import '../../models/outage_dto.dart';
import '../components/prefectures_dropdown.dart';
import 'package:flutter/material.dart';
import '../components/outage_list_item.dart';

/// ----------------------------------------------------------------------------
/// outages.dart
/// ----------------------------------------------------------------------------
/// This widget is used in order to populate the Outages list to be shown to the users.
/// By default, it will show the outages of the default prefecture.
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
  List<OutageListItem> defaultOutageListItems =
      List<OutageListItem>.empty(growable: true);

  PrefectureDto selectedPrefecture = PrefectureDto.defaultPrefecture();
  OutageRetrievalService outageRetrievalService = OutageRetrievalService();

  /// Trigger a new data download for the new prefecture. [setState()] will
  /// trigger a rebuild of the widget, which will lead on displaying the
  /// data retrieved for the selected prefecture.
  void onPrefectureSelected() {
    setState(() {
      debugPrint("onPrefectureSelected "
          "Prefecture: ${selectedPrefecture.name}");
      if (selectedPrefecture.name == PrefectureDto.defaultPrefecture().name) {
        outageListItems.clear();
        // Retrieve the persisted outages of the default prefecture
        List<OutageDto> persistedOutagesOfDefaultPrefecture =
            DataPersistService()
                .getSavedOutages(DataPersistService.outagesOfDefaultPrefecture);

        // For performance improvement, do not retrieve the outages of the default
        // prefecture every time - use the ones from the persisted storage.
        if (persistedOutagesOfDefaultPrefecture.isEmpty) {
          debugPrint("Retrieving outages of default prefecture..");

          outageRetrievalService
              .getOutagesFromOfficialSource(selectedPrefecture, outageListItems)
              .then((value) {
            outageListItems = value;
          });
        } else {
          debugPrint("Outages of default prefecture already fetched.");

          outageListItems = OutagesHandler.getOutageListItemsWidgetList(
              persistedOutagesOfDefaultPrefecture);
        }
      } else {
        debugPrint("Retrieving new outage list items...");

        outageListItems.clear();
        outageRetrievalService
            .getOutagesFromOfficialSource(selectedPrefecture, outageListItems)
            .then((value) => outageListItems = value);
      }
    });
  }

  /// Performs a request to the official API where all the Greek planned
  /// outages are reported.
  ///
  /// * If there aren't any outages for the selected prefecture, returns an empty List.
  /// * If the request has not been completed, returns a loading indicator.
  /// * If there are no data to be displayed, shows a warning screen informing the user.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: outageRetrievalService.getOutagesFromOfficialSource(
          selectedPrefecture, outageListItems),
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[widgetPrefectures(), widgetOutagesData(snapshot)],
        );
      },
    );
  }

  /// Populates the prefectures dropdown widget.
  Widget widgetPrefectures() {
    return PrefecturesDropdown((value) {
      onPrefectureSelected();
      return selectedPrefecture = value;
    });
  }

  /// Determines which widget to display on the screen based on the
  /// [snapshot.data] and [snapshot.connectionState].
  /// - In case [ConnectionState.done] and a list contains valid data, return the [outagesList].
  /// - In case of an empty list of outages, returns the [widgetNoOutagesData].
  /// - In case data are still loading, returns the [widgetLoadingOutages].
  /// - In any other case, it returns the [widgetNoOutagesData].
  Widget widgetOutagesData(AsyncSnapshot<Object?> snapshot) {
    bool shouldDisplayOutagesData = snapshot.data is List<OutageListItem> &&
        snapshot.connectionState == ConnectionState.done;
    if (shouldDisplayOutagesData) {
      outageListItems = snapshot.data as List<OutageListItem>;
      switch (outageListItems.isNotEmpty) {
        case true:
          return Flexible(child: outagesList(context));
        default:
          return widgetNoOutagesData();
      }
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return widgetLoadingOutages();
    }

    return widgetLoadingOutages();
  }

  /// Populates the outages list that will be shown on the screen.
  Widget outagesList(BuildContext context) {
    return Material(
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[...outageListItems]));
  }

  Widget widgetLoadingOutages() {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Loading(label: 'Loading data...')]);
  }

  Widget widgetNoOutagesData() {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Warning(label: 'No outages for the selected prefecture')
        ]);
  }
}
