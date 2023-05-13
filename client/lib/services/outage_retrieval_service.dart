import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist.dart';
import 'package:black_out_groutages/services/rest.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../models/outage_dto.dart';
import '../widgets/components/notification_list_item.dart';
import '../widgets/components/outage_list_item.dart';
import '../widgets/components/saved_outage_list_item.dart';
import 'outages_handler.dart';
import 'prefectures_handler.dart';

/// ----------------------------------------------------------------------------
/// outage_retrieval_service.dart
/// ----------------------------------------------------------------------------
/// A service class to facilitate the retrieval of outages through various channels.
class OutageRetrievalService {
  /// Source to retrieve the outages.
  final urlOfOfficialSource =
      "https://black-out-api.vercel.app/api/outagesOfPrefecture/";

  /// Performs a sample request to the official source in order to fetch
  /// the current list of valid prefectures.
  Future<List<PrefectureDto>> getPrefecturesFromOfficialSource() async {
    debugPrint("fetching prefectures...");

    Response response = await Rest.doGET(urlOfOfficialSource + "1", {});
    return PrefecturesHandler.extract(response.body);
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
    Response response = (await Rest.doGET(
        urlOfOfficialSource + selectedPrefecture.id, <String, String>{}));

    // Convert the retrieved outages to a list of [OutageDto] objects.
    List<OutageDto> outages = List<OutageDto>.empty(growable: true);
    outages =
        OutagesHandler.extract(response.body.toString(), selectedPrefecture);

    return OutagesHandler.getOutageListItemsWidgetList(outages);
  }

  /// Retrieves a list of [OutageListItem] objects that were previously
  /// saved in the persistent storage.
  List<SavedOutageListItem> getOutagesFromPersistentStorage() {
    List<OutageDto> savedOutageDto = DataPersistService()
        .getSavedOutages(DataPersistService.savedOutagesPersistKey);
    return OutagesHandler.getSavedOutageListItemsWidgetList(savedOutageDto);
  }

  /// Retrieves a list of [NotificationListItem] objects that were previously
  /// saved in the persistent storage. The returned items will be filtered based
  /// on [OutageDto.filterOutagesList].
  List<NotificationListItem> getNotificationListItems() {
    List<OutageDto> outages = DataPersistService()
        .getSavedOutages(DataPersistService.outagesOfDefaultPrefecture);
    outages = OutageDto.filterOutagesList(outages);

    return OutagesHandler.getNotificationListItemsWidgetList(outages);
  }
}
