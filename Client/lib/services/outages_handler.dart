import '../models/icon_prefecture_map.dart';
import '../models/prefecture_dto.dart';
import 'package:html/dom.dart' as dom;
import '../../widgets/outage_list_item.dart';
import 'package:html/parser.dart' show parse;
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

  /// Parses the HTML response of the outages and looks for the below:
  /// 1. Table with class "tblOutages".
  /// 2. If it finds the table, it loops through it's rows.
  /// 3. For every row, loops through it's columns and stores it's data.
  ///
  /// @returns a list of [OutageDto] objects.
  /// @returns an empty list if no outages found.
  static List<OutageDto> extract(String html, PrefectureDto prefecture){
    List<OutageDto> outages = List<OutageDto>.empty(growable: true);

    //#region HTML Parser
    try{
      dom.Document document = parse(html);
      // Find the table that contains the outages of the elected prefecture.
      dom.Element? tblOutages = document.getElementById("tblOutages");
      // Find the rows of the table.
      List<dom.Element> tblRows = tblOutages!.getElementsByTagName("tr");
      // Navigate through the columns of each row and store the data.
      for (int i=1; i<tblRows.length; i++){
        List<dom.Element> tblColumns = tblRows[i].getElementsByTagName("td");
        // Reset the object to avoid showing values from previously extracted outages (if a field not present).
        OutageDto tmpOutage = OutageDto("", "", "", "", "", "", "", "assets/greece.png");
        for (int j=0; j<tblColumns.length; j++){
          String currentValue = tblColumns[j].innerHtml.trim();
          if (j == 0) tmpOutage.fromDatetime = currentValue;
          if (j == 1) tmpOutage.toDatetime = currentValue;
          if (j == 2) tmpOutage.municipality = _normalizeStr(currentValue);
          if (j == 3) tmpOutage.areaDescription = currentValue;
          if (j == 4) tmpOutage.number = currentValue;
          if (j == 5) tmpOutage.reason = currentValue;
        }
        tmpOutage.prefecture = prefecture.name;
        // The default image of the outages must be specified.
        tmpOutage.image = IconPrefectureMap.iconMap[prefecture.id] ?? "assets/greece.png";
        outages.add(tmpOutage);
      }
    }
    catch (e){
      outages = [];
    }
    //#endregion

    return outages;
  }

  /// Remove any unwanted characters from the data.
  ///
  /// @returns a `normalized` string i.e., a string that does not contain unwanted characters.
  static OutageDto _normalize(OutageDto outage){
    OutageDto normalized = OutageDto("", "", "", "", "", "", "", "");
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
    data = data.replaceAllMapped("<br>", (match) => "");
    data = data.replaceAllMapped("</br>", (match) => "");
    return data;
  }
}
