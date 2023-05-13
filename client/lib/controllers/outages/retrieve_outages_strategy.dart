import 'package:black_out_groutages/controllers/outages/base_strategy.dart';
import 'package:black_out_groutages/models/outage_dto.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist.dart';
import 'package:black_out_groutages/services/outages_handler.dart';
import 'package:flutter/cupertino.dart';
import '../../services/outage_retrieval_service.dart';
import '../../widgets/components/outage_list_item.dart';

class RetrieveOutagesControllerStrategy extends BaseOutagesControllerStrategy {
  @override
  Future<List<OutageListItem>> updateOutagesList(
      PrefectureDto selectedPrefecture) async {
    debugPrint("Retrieving outages from official source");

    OutageRetrievalService outageRetrievalService = OutageRetrievalService();
    outagesList = await outageRetrievalService.getOutagesFromOfficialSource(
        selectedPrefecture, outagesList);

    // Persist the default prefecture outages.
    if (selectedPrefecture.name == defaultPrefecture.name) {
      debugPrint("Persisting outages of default prefecture");
      List<OutageDto> outages =
          OutagesHandler.getOutageDtoListFromOutageListItem(outagesList);
      DataPersistService().persistOutages(
          outages, DataPersistService.outagesOfDefaultPrefecture);
    }

    return outagesList;
  }
}
