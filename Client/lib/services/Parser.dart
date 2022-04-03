import 'package:black_out_groutages/widgets/OutageListItem.dart';
import 'package:flutter/material.dart';

import '../models/OutageDto.dart';

class Parser {

  static List<OutageListItem> GetWidgetList(List<Outage> outages){
    List<OutageListItem> outageListItems = List<OutageListItem>.empty(growable: true);
    for (int i = 0; i < outages.length; i++) {
      outageListItems.add(OutageListItem(
        thumbnail: Container(
          decoration: const BoxDecoration(color: Colors.pink),
        ),
        title: 'Νομός Θεσσαλονίκης',
        subtitle: outages[i].municipality,
        description: outages[i].areaDescription,
        author: 'Dash',
        publishDate: 'Dec 28',
        readDuration: '5 mins',
      ));
    }
    return outageListItems;
  }

  static List<Outage> extractOutages(String html) {
    //#region Local Variables
    List<Outage> outages = List<Outage>.empty(growable: true);
    Outage tempOutage = new Outage("", "", "", "", "", "", "");
    bool foundTable = false;
    int ctrRows = 0;
    int ctrMappedValues = 0;
    //#endregion

    //#region HTML Parsing
    try {
      List<String> data = html.split('\n');
      for (int i = 0; i < data.length; i++) {
        if (data[i].contains("tblOutages")) {
          foundTable = true;
        }
        if (data[i].contains("tr") && foundTable) {
          ctrRows++;
        }
        if (ctrRows > 0 && data[i].contains("td")) {
          List<String> arrVal = data[i].split(">");
          ctrMappedValues++;

          if (ctrMappedValues == 1) tempOutage.fromDatetime = arrVal[1];
          if (ctrMappedValues == 2) tempOutage.toDatetime = arrVal[1];
          if (ctrMappedValues == 4) tempOutage.municipality = arrVal[0];
          if (ctrMappedValues == 5) tempOutage.areaDescription = arrVal[1];
          if (ctrMappedValues == 6) tempOutage.number = arrVal[1];
          if (ctrMappedValues == 7) tempOutage.reason = arrVal[1];

          if (ctrMappedValues == 7) {
            outages.add(tempOutage);
            tempOutage = Outage("", "", "", "", "", "", "");
            ctrMappedValues = 0;
            ctrRows = 0;
          }
        }
      }
    } catch (e) {
      outages = [];
    }
    //#endregion

    //#region Normalize
    for (int i = 0; i < outages.length; i++) {
      outages[i] = _normalize(outages[i]);
    }
    //#endregion
    print("outages length: " + outages.length.toString());
    return outages;
  }

  static Outage _normalize(Outage outage){
    Outage normalized = Outage("", "", "", "", "", "", "");
    normalized.municipality = _normalizeStr(outage.municipality);
    normalized.prefecture = _normalizeStr(outage.prefecture);
    normalized.areaDescription = _normalizeStr(outage.areaDescription);
    normalized.toDatetime = _normalizeStr(outage.toDatetime);
    normalized.fromDatetime = _normalizeStr(outage.fromDatetime);
    normalized.number = _normalizeStr(outage.number);
    normalized.reason = _normalizeStr(outage.reason);

    return normalized;
  }

  static String _normalizeStr(String data){
    return data.replaceAllMapped("</td", (match) => "");
  }
}
