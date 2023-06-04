import 'package:black_out_groutages/controllers/prefectures/persisted_prefectures_strategy.dart';
import 'package:black_out_groutages/controllers/prefectures/prefectures_strategy_impl.dart';
import 'package:black_out_groutages/controllers/prefectures/retrieve_prefectures_strategy.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';

class PrefecturesContext {
  late PrefecturesControllerStrategyImpl strategy;

  void setPrefecturesStrategy(PrefecturesControllerStrategyImpl newStrategy) {
    strategy = newStrategy;
  }

  List<PrefectureDto> execute() {
    setPrefecturesStrategy(PersistedPrefecturesControllerStrategy());
    strategy.update();

    if (strategy.prefectures.isNotEmpty) {
      return strategy.prefectures;
    }

    setPrefecturesStrategy(RetrievePrefecturesControllerStrategy());
    strategy.update();

    return strategy.prefectures;
  }
}
