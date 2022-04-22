import '../../widgets/outage_list_item.dart';
import 'package:flutter/material.dart';

import '../models/outage_dto.dart';

/// Includes all the related functions to:
/// * Parse HTML and extract outages if any.
/// * Transform unstructured data into outage objects.
/// * Transform OutageDto objects into equivalent widgets.
class OutagesHandler {

  /// Given a list of [OutageDto] objects, transforms each object to it's[OutageListItem] equivalent.
  ///
  /// @returns a list of [OutageListItem] objects.
  static List<OutageListItem> getWidgetList(List<OutageDto> outages){
    List<OutageListItem> outageListItems = List<OutageListItem>.empty(growable: true);
    for (int i = 0; i < outages.length; i++) {
      outageListItems.add(OutageListItem(
        outage: outages[i],
      ));
    }
    return outageListItems;
  }

  /// Given an HTML string of a certain structure extracts from it all the outages that can
  /// be found.
  ///
  /// @returns a list of [OutageDto] items.
  /// @returns an empty list if no data could be extracted.
  static List<OutageDto> extractOutages(String html) {
    //#region Local Variables
    List<OutageDto> outages = List<OutageDto>.empty(growable: true);
    OutageDto tempOutage = OutageDto("", "", "", "", "", "", "");
    bool foundTable = false;
    int ctrRows = 0;
    int ctrMappedValues = 0;
    String prefecture = "";
    //#endregion

    //#region HTML Parsing
    try {
      List<String> data = html.split('\n');
      for (int i = 0; i < data.length; i++) {
        // Find the selected prefecture. Application does not send request for specific
        // municipalities (only for prefectures), thus, onl the prefectures table will have
        // a selected option.
        if (data[i].contains("option") && data[i].contains("selected")){
          prefecture = data[i].split('>')[1];
        }
        // The table that contains the outages of the selected prefecture.
        if (data[i].contains("tblOutages")) {
          foundTable = true;
        }
        // Every row of te table contains information about the outage.
        if (data[i].contains("tr") && foundTable) {
          ctrRows++;
        }
        // Columns of the table contain the specific information, mapped below.
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
            tempOutage.prefecture = prefecture;
            outages.add(tempOutage);
            tempOutage = OutageDto("", "", "", "", "", "", "");
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
    return outages;
  }

  /// Remove any unwanted characters from the data.
  ///
  /// @returns a `normalized` string i.e., a string that does not contain unwanted characters.
  static OutageDto _normalize(OutageDto outage){
    OutageDto normalized = OutageDto("", "", "", "", "", "", "");
    normalized.municipality = _normalizeStr(outage.municipality);
    normalized.prefecture = _normalizeStr(outage.prefecture);
    normalized.areaDescription = _normalizeStr(outage.areaDescription);
    normalized.toDatetime = _normalizeStr(outage.toDatetime);
    normalized.fromDatetime = _normalizeStr(outage.fromDatetime);
    normalized.number = _normalizeStr(outage.number);
    normalized.reason = _normalizeStr(outage.reason);

    return normalized;
  }

  /// Remove all the known unwanted characters from the passed string.
  static String _normalizeStr(String data){
    data = data.trim();
    data = data.replaceAllMapped("</option", (match) => "");
    data = data.replaceAllMapped("</td", (match) => "");
    return data;
  }
}