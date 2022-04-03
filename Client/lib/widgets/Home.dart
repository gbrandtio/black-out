import 'package:black_out_groutages/widgets/AppBar.dart';
import 'package:black_out_groutages/widgets/BottomBar.dart';
import 'package:black_out_groutages/widgets/OutageListItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/OutageDto.dart';
import '../services/Parser.dart';
import '../services/Rest.dart';

class Home extends StatefulWidget {
  const Home({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<OutageListItem> outageListItems =
      List<OutageListItem>.empty(growable: true);

  List<Outage> outages = [
    Outage("Thessaloniki", "03/04/2022", "04/04/2022", "Dimos Thermis",
        "Mesimeri", "100", "Construction")
  ];

  Future<List<OutageListItem>> _getOutages(BuildContext context) async {
    Response response = (await Rest.doPOST(
        "https://siteapps.deddie.gr/Outages2Public/?Length=4" +
            "&PrefectureID=23&MunicipalityID=",
        {
          "Accept-Language": "en-US,en;q=0.9,el;q=0.8",
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        {
          "X-Requested-With": "XMLHttpRequest"
        }));

    setState(() {
      outageListItems.clear();
      List<Outage> outages = List<Outage>.empty(growable: true);
      outages = Parser.extractOutages(response.body.toString());
      outageListItems = Parser.GetWidgetList(outages);
    });
    return outageListItems;
  }

  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
      outageListItems.clear();
    });
  }

  Widget outagesList(BuildContext context) {
    return Material(
        child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: outagesListTileBuilder()));
  }

  List<Widget> outagesListTileBuilder() {
    return <Widget>[...outageListItems];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getOutages(context),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              appBar: BaseAppBar(appBar: AppBar()),
              body: Container(child: outagesList(context)),
              bottomNavigationBar: BottomBar(
                  selectedIndex: selectedIndex, onClicked: onClicked));
        } else {
          return Scaffold(
              appBar: BaseAppBar(appBar: AppBar()),
              body: Container(child: outagesList(context)),
              bottomNavigationBar: BottomBar(
                  selectedIndex: selectedIndex, onClicked: onClicked));
        }
      },
    );
  }
}
