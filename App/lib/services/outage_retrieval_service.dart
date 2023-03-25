import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist.dart';
import 'package:black_out_groutages/services/rest.dart';
import 'package:http/http.dart';

import '../models/outage_dto.dart';
import '../widgets/components/outage_list_item.dart';
import '../widgets/components/saved_outage_list_item.dart';
import 'outages_handler.dart';

class OutageRetrievalService {
  /// Retrieves a list of [OutageListItem] objects that were previously
  /// saved in the persistent storage.
  List<SavedOutageListItem> getOutagesFromPersistentStorage() {
    List<OutageDto> savedOutageDto = DataPersistService().getSavedOutages();
    return OutagesHandler.getSavedOutageListItemsWidgetList(savedOutageDto);
  }

  /// Performs a request to the official website where the Greek outages of all
  /// prefectures are reported.
  ///
  /// * Parses the response of the API.
  /// * Creates the [outages] list constructed of [OutageDto] objects.
  /// * Transforms the [outages] list into an [outageListItems] list.
  ///
  /// @returns A list of OutageListItems that will be shown on the list.
  /// @returns An empty list if the response could not be parsed or didn't contain any outages.
  Future<List<OutageListItem>> getOutagesFromOfficialSource(
      PrefectureDto selectedPrefecture,
      List<OutageListItem> currentOutageList) async {
    // Retrieve outages from DEDDHE.
    Response response = (await Rest.doPOST(
        "https://siteapps.deddie.gr/Outages2Public/?Length=4&PrefectureID=" +
            selectedPrefecture.id +
            "&MunicipalityID=",
        Rest.outagesRequestHeaders,
        Rest.outagesRequestBody));

    // Convert the retrieved outages to a list of [OutageDto] objects.
    List<OutageDto> outages = List<OutageDto>.empty(growable: true);
    outages =
        OutagesHandler.extract(response.body.toString(), selectedPrefecture);

    return OutagesHandler.getOutageListItemsWidgetList(outages);
    ;
  }
}
