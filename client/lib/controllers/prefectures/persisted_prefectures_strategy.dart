import 'package:black_out_groutages/controllers/prefectures/prefectures_strategy_impl.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist_service/prefectures_data_persist.dart';
import 'package:flutter/cupertino.dart';
import '../../services/data_persist_service/data_persist_service_keys.dart';

/// ----------------------------------------------------------------------------
/// persisted_prefectures_strategy.dart
/// ----------------------------------------------------------------------------
/// Concrete implementation of a strategy intending to retrieve the prefectures
/// present on the persisted storage.
class PersistedPrefecturesControllerStrategy
    extends PrefecturesControllerStrategyImpl {
  @override
  Future<List<PrefectureDto>> retrievePersistedPrefectures() async {
    List<PrefectureDto> persistedPrefectures = PrefecturesDataPersistService()
        .retrievePrefectures(DataPersistServiceKeys.outagesOfDefaultPrefecture);

    debugPrint(
        "Retrieving prefectures from persistent storage: ${prefectures.length}");
    prefectures = PrefecturesDataPersistService()
        .retrievePrefectures(DataPersistServiceKeys.savedPrefectures);

    return persistedPrefectures;
  }
}
