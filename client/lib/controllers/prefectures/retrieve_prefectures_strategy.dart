import 'package:black_out_groutages/controllers/prefectures/prefectures_strategy_impl.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist_service/data_persist_service_keys.dart';
import 'package:black_out_groutages/services/data_persist_service/prefectures_data_persist.dart';
import 'package:flutter/cupertino.dart';
import '../../services/outage_retrieval_service.dart';

class RetrievePrefecturesControllerStrategy
    extends PrefecturesControllerStrategyImpl {
  @override
  Future<List<PrefectureDto>> updatePrefectures() async {
    debugPrint("Retrieving prefectures from official source");

    OutageRetrievalService outageRetrievalService = OutageRetrievalService();
    prefectures =
        await outageRetrievalService.getPrefecturesFromOfficialSource();

    debugPrint("Persisting prefectures: ${prefectures.length}");
    PrefecturesDataPersistService prefecturesDataPersistService =
        PrefecturesDataPersistService();
    prefecturesDataPersistService.persistList(
        prefectures, DataPersistServiceKeys.savedPrefectures);

    return prefectures;
  }
}
