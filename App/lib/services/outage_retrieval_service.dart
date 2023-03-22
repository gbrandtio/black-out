import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/rest.dart';
import 'package:http/http.dart';

import '../models/outage_dto.dart';
import '../widgets/components/outage_list_item.dart';
import 'outages_handler.dart';

class OutageRetrievalService {
  /// Performs a request to the official website where the Greek outages of all
  /// prefectures are reported.
  ///
  /// * Parses the response of the API.
  /// * Creates the [outages] list constructed of [OutageDto] objects.
  /// * Transforms the [outages] list into an [outageListItems] list.
  ///
  /// @returns A list of OutageListItems that will be shown on the list.
  /// @returns An empty list if the response could not be parsed or didn't contain any outages.
  Future<List<OutageListItem>> getOutages(
      bool doRetrieveOutagesFromPersistentStorage,
      PrefectureDto selectedPrefecture,
      List<OutageListItem> currentOutageList) async {
    Response response = (await Rest.doPOST(
        "https://siteapps.deddie.gr/Outages2Public/?Length=4&PrefectureID=" +
            selectedPrefecture.id +
            "&MunicipalityID=",
        Rest.outagesRequestHeaders,
        Rest.outagesRequestBody));

    currentOutageList.clear();
    List<OutageDto> outages = List<OutageDto>.empty(growable: true);
    outages =
        OutagesHandler.extract(response.body.toString(), selectedPrefecture);
    currentOutageList = OutagesHandler.getWidgetList(outages);

    return currentOutageList;
  }
}
