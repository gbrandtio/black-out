import 'package:black_out_groutages/controllers/prefectures/persisted_prefectures_strategy.dart';
import 'package:black_out_groutages/controllers/prefectures/prefectures_strategy_impl.dart';
import 'package:black_out_groutages/controllers/prefectures/retrieve_prefectures_strategy.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:flutter/cupertino.dart';

class PrefecturesContext {
  late PrefecturesControllerStrategyImpl strategy;

  void setPrefecturesStrategy(PrefecturesControllerStrategyImpl newStrategy) {
    strategy = newStrategy;
  }

  Future<List<PrefectureDto>> execute() async {
    setPrefecturesStrategy(PersistedPrefecturesControllerStrategy());
    strategy.update();

    if (strategy.prefectures.isNotEmpty) {
      debugPrint(
          "Returning persisted prefectures: ${strategy.prefectures.length}");
      return strategy.prefectures;
    }

    setPrefecturesStrategy(RetrievePrefecturesControllerStrategy());
    await strategy.update();

    return strategy.prefectures;
  }
}
