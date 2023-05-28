import 'package:black_out_groutages/controllers/outages/base_strategy.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/outages_handler.dart';
import 'package:black_out_groutages/widgets/components/outage_list_item.dart';
import 'package:flutter/cupertino.dart';

import '../../models/outage_dto.dart';
import '../../services/data_persist.dart';

class PersistedOutagesControllerStrategy extends BaseOutagesControllerStrategy {
  @override
  Future<List<OutageListItem>> updateOutagesList(
      PrefectureDto selectedPrefecture) async {
    List<OutageDto> persistedOutagesOfDefaultPrefecture = DataPersistService()
        .getSavedOutages(DataPersistService.outagesOfDefaultPrefecture);

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
