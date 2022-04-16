import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/OutageDto.dart';
import '../services/Parser.dart';
import '../services/Rest.dart';
import 'OutageListItem.dart';

/// This widget is used in order to populate the Outages list to be shown to the users.
/// By default, it shows the Outages of Thessaloniki, Greece and gives the ability to the user
/// to select the prefecture of his choice and see any planned outages.
class OutagesScreen extends StatefulWidget {
  const OutagesScreen({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _OutagesScreenState createState() => _OutagesScreenState();
}

class _OutagesScreenState extends State<OutagesScreen> {
  //#region Members
  /// A list of OutageListItem(s) that will be shown on the screen.
  List<OutageListItem> outageListItems =  List<OutageListItem>.empty(growable: true);
  //#endregion

  //#region Fetch Outages
  /// Performs a request to the official website where the Greek outages of all
  /// prefectures are reported.
  ///
  /// * Parses the response of the API.
  /// * Creates the [outages] list constructed of [Outage] objects.
  /// * Transforms the [outages] list into an [outageListItems] list.
  ///
  /// @returns A list of OutageListItems that will be shown on the list.
  /// @returns An empty list if the response could not be parsed or didn't contain any outages.
  Future<List<OutageListItem>> _getOutages(BuildContext context) async {
    Response response = (await Rest.doPOST(
        "https://siteapps.deddie.gr/Outages2Public/?Length=4" "&PrefectureID=23&MunicipalityID=",
        {
          "Accept-Language": "en-US,en;q=0.9,el;q=0.8",
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          "Access-Control-Allow-Origin":"*"
        },
        {
          "X-Requested-With": "XMLHttpRequest"
        }));

    setState(() {
      outageListItems.clear();
      List<Outage> outages = List<Outage>.empty(growable: true);
      outages = Parser.extractOutages(response.body.toString());
      outageListItems = Parser.getWidgetList(outages);
    });
    return outageListItems;
  }
  //#endregion

  //#region Outages List
  /// Populates the outages list that will be shown on the screen.
  Widget outagesList(BuildContext context) {
    return Material(
        child: ListView(
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

  /// Performes a request to the official API where all the Greek planned
  /// outages are reported.
  ///
  /// * If there aren't any outages for the selected prefecture, returns an empty List.
  /// * If the request has not been completed, returns a loading indicator.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getOutages(context),
      builder: (context, snapshot) {
        // if (snapshot.hasData &&
        //     snapshot.connectionState == ConnectionState.done) {
        //   return Scaffold(
        //       appBar: BaseAppBar(appBar: AppBar()),
        //       body: Container(child: outagesList(context)),
        //       bottomNavigationBar: BottomBar(
        //           selectedIndex: selectedIndex, onClicked: onClicked));
        // } else {
        return Scaffold(
            body: Container(child: outagesList(context)));
        //}
      },
    );
  }

}