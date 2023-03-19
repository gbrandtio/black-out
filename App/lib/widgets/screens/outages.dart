import 'package:black_out_groutages/models/prefecture_dto.dart';

import '../prefectures_dropdown.dart';
import '../warning.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/outage_dto.dart';
import '../../services/outages_handler.dart';
import '../../services/rest.dart';
import '../outage_list_item.dart';

/// This widget is used in order to populate the Outages list to be shown to the users.
/// By default, it shows the Outages of Thessaloniki, Greece and gives the ability to the user
/// to select the prefecture of his choice and see any planned outages.
class OutagesScreen extends StatefulWidget {
  const OutagesScreen({required Key key, required this.title})
      : super(key: key);
  final String title;

  @override
  _OutagesScreenState createState() => _OutagesScreenState();
}

class _OutagesScreenState extends State<OutagesScreen> {
  //#region Members
  /// A list of OutageListItem(s) that will be shown on the screen.
  List<OutageListItem> outageListItems =
      List<OutageListItem>.empty(growable: true);

  /// Requests to be performed only once, when widget is loaded.
  late final Future? outagesFuture;

  /// PrefectureDto selected value of the dropdown.
  PrefectureDto selectedPrefecture = PrefectureDto.defaultPrefecture();
  //#endregion

  @override
  void initState() {
    super.initState();
    outagesFuture = _getOutages();
  }

  //#region Fetch Outages
  /// Performs a request to the official website where the Greek outages of all
  /// prefectures are reported.
  ///
  /// * Parses the response of the API.
  /// * Creates the [outages] list constructed of [OutageDto] objects.
  /// * Transforms the [outages] list into an [outageListItems] list.
  ///
  /// @returns A list of OutageListItems that will be shown on the list.
  /// @returns An empty list if the response could not be parsed or didn't contain any outages.
  Future<List<OutageListItem>> _getOutages() async {
    // perform a request to the configured API
    Response response = (await Rest.doPOST(
        "https://siteapps.deddie.gr/Outages2Public/?Length=4&PrefectureID=" +
            selectedPrefecture.id +
            "&MunicipalityID=",
        Rest.outagesRequestHeaders,
        Rest.outagesRequestBody));

    setState(() {
      outageListItems
          .clear(); // clear the list in order to avoid having duplicate items on reloading
      List<OutageDto> outages = List<OutageDto>.empty(growable: true);
      outages = OutagesHandler.extract(response.body.toString(),
          selectedPrefecture); // parse the HTML response and extract outages objects
      outageListItems = OutagesHandler.getWidgetList(
          outages); // convert the List<Outage> to List<OutageListItem> in order to be able to display the latter
    });
    return outageListItems;
  }
  //#endregion

  //#region Outages List
  /// Populates the outages list that will be shown on the screen.
  Widget outagesList(BuildContext context) {
    return Material(
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            children: outagesListTileBuilder()));
  }

  /// Populates the outages list to be shown with all the objects that are
  /// present in outageListItems list.
  ///
  /// @returns a list of OutageListItem widgets.
  List<Widget> outagesListTileBuilder() {
    return <Widget>[...outageListItems];
  }
  //#endregion

  /// Performs a request to the official API where all the Greek planned
  /// outages are reported.
  ///
  /// * If there aren't any outages for the selected prefecture, returns an empty List.
  /// * If the request has not been completed, returns a loading indicator.
  /// * if there are no data to be displayed, shows a warning screen informing the user.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getOutages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Column(children: [
              PrefecturesDropdown((value) {
                selectedPrefecture = value;
                return selectedPrefecture = value;
              }),
              Flexible(
                child: outagesList(context),
              )
            ]),
          );
        } else {
          return Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  child: Column(children: [
                    PrefecturesDropdown((value) {
                      selectedPrefecture = value;
                      return selectedPrefecture = value;
                    }),
                    const Warning(
                        label: "No outages for the selected prefecture")
                  ])));
        }
      },
    );
  }
}
