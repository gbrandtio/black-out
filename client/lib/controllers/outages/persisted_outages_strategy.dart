import 'package:black_out_groutages/controllers/outages/outages_strategy_impl.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/outages_handler.dart';
import 'package:black_out_groutages/widgets/components/outage_list_item.dart';
import 'package:flutter/cupertino.dart';

import '../../models/outage_dto.dart';
import '../../services/data_persist_service/outages_data_persist.dart';
import '../../services/data_persist_service/data_persist_service_keys.dart';

class PersistedOutagesControllerStrategy extends BaseOutagesControllerStrategy {
  @override
  Future<List<OutageListItem>> updateOutagesList(
      PrefectureDto selectedPrefecture) async {
    List<OutageDto> persistedOutagesOfDefaultPrefecture =
        OutagesDataPersistService()
            .retrieveValueOf(DataPersistServiceKeys.outagesOfDefaultPrefecture);

    debugPrint("Selected prefecture: ${selectedPrefecture.name}");
    debugPrint("Default prefecture: ${defaultPrefecture.name}");

    if (selectedPrefecture.name == PrefectureDto.defaultPrefecture().name &&
        persistedOutagesOfDefaultPrefecture.isNotEmpty) {
      debugPrint("Retrieving outages from persistent storage");
      outagesList = OutagesHandler.getOutageListItemsWidgetList(
          persistedOutagesOfDefaultPrefecture);
    }

    return outagesList;
  }
}
