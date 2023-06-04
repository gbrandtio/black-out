import 'package:black_out_groutages/controllers/prefectures/prefectures_strategy_impl.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist_service/prefectures_data_persist.dart';
import 'package:flutter/cupertino.dart';
import '../../services/data_persist_service/data_persist_service_keys.dart';

class PersistedPrefecturesControllerStrategy
    extends PrefecturesControllerStrategyImpl {
  @override
  Future<List<PrefectureDto>> updatePrefectures() async {
    List<PrefectureDto> persistedPrefectures = PrefecturesDataPersistService()
        .retrievePrefectures(DataPersistServiceKeys.outagesOfDefaultPrefecture);

    if (prefectures.isEmpty) {
      debugPrint(
          "Retrieving prefectures from persistent storage: ${prefectures.length}");
      prefectures = PrefecturesDataPersistService()
          .retrievePrefectures(DataPersistServiceKeys.savedPrefectures);
    }

    return persistedPrefectures;
  }
}
