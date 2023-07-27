import 'package:black_out_groutages/controllers/prefectures/persisted_prefectures_strategy.dart';
import 'package:black_out_groutages/controllers/prefectures/prefectures_strategy_impl.dart';
import 'package:black_out_groutages/controllers/prefectures/retrieve_prefectures_strategy.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:flutter/cupertino.dart';

/// ----------------------------------------------------------------------------
/// prefectures_context.dart
/// ----------------------------------------------------------------------------
/// Acts as a client for executing the desired strategies implemented by the
/// strategy pattern followed by this controller. This class has been implemented
/// in order to provide a transparent way of execution towards the rest of the
/// application.
class PrefecturesContext {
  late PrefecturesControllerStrategyImpl strategy;

  void setPrefecturesStrategy(PrefecturesControllerStrategyImpl newStrategy) {
    strategy = newStrategy;
  }

  Future<List<PrefectureDto>> execute() async {
    setPrefecturesStrategy(PersistedPrefecturesControllerStrategy());
    await strategy.update();

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
