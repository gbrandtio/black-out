import 'package:black_out_groutages/controllers/outages/outages_strategy_impl.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/outages_handler.dart';
import 'package:black_out_groutages/widgets/components/outages/outage_list_item.dart';
import 'package:flutter/cupertino.dart';

import '../../models/outage_dto.dart';
import '../../services/data_persist_service/outages_data_persist.dart';
import '../../services/data_persist_service/data_persist_service_keys.dart';

/// ----------------------------------------------------------------------------
/// persisted_outages_strategy.dart
/// ----------------------------------------------------------------------------
/// Concrete implementation of the outages strategy to persist the outages
/// retrieved from the remote source.
class PersistedOutagesControllerStrategy extends OutagesControllerStrategyImpl {
  @override
  Future<List<OutageListItem>> updateOutagesList(
      PrefectureDto selectedPrefecture) async {
    await OutagesDataPersistService().initializePreferences();
    List<OutageDto> persistedOutagesOfDefaultPrefecture =
        OutagesDataPersistService()
            .retrieveValueOf(DataPersistServiceKeys.outagesOfDefaultPrefecture);

    debugPrint("Default prefecture: ${PrefectureDto.defaultPrefecture().name}");
    debugPrint(
        "Persisted outages length: ${persistedOutagesOfDefaultPrefecture.length}");

    if (selectedPrefecture.name == PrefectureDto.defaultPrefecture().name &&
        persistedOutagesOfDefaultPrefecture.isNotEmpty) {
      debugPrint("Retrieving outages from persistent storage");
      outagesList = OutagesHandler.getOutageListItemsWidgetList(
          persistedOutagesOfDefaultPrefecture);
    }

    return outagesList;
  }
}
