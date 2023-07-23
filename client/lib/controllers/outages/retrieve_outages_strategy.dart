import 'package:black_out_groutages/controllers/outages/outages_strategy_impl.dart';
import 'package:black_out_groutages/models/outage_dto.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist_service/outages_data_persist.dart';
import 'package:black_out_groutages/services/outages_handler.dart';
import 'package:flutter/cupertino.dart';
import '../../services/data_persist_service/data_persist_service_keys.dart';
import '../../services/outage_retrieval_service.dart';
import '../../widgets/components/outages/outage_list_item.dart';

/// ----------------------------------------------------------------------------
/// retrieve_outages_strategy.dart
/// ----------------------------------------------------------------------------
/// Concrete implementation of the outages strategy for retrieving the outages
/// from the remote source.
class RetrieveOutagesControllerStrategy extends OutagesControllerStrategyImpl {
  @override
  Future<List<OutageListItem>> updateOutagesList(
      PrefectureDto selectedPrefecture) async {
    debugPrint("Retrieving outages from official source");

    OutageRetrievalService outageRetrievalService = OutageRetrievalService();
    outagesList = await outageRetrievalService.getOutagesFromOfficialSource(
        selectedPrefecture, outagesList);

    // Persist the default prefecture outages.
    if (selectedPrefecture.name == defaultPrefecture.name) {
      List<OutageDto> outages =
          OutagesHandler.getOutageDtoListFromOutageListItem(outagesList);
      debugPrint(
          "Persisting outages of default prefecture. Outages no: ${outages.length}");
      OutagesDataPersistService().persistList(
          outages, DataPersistServiceKeys.outagesOfDefaultPrefecture);
    }

    return outagesList;
  }
}
