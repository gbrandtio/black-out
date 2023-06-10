import 'package:black_out_groutages/models/prefecture_dto.dart';

/// ----------------------------------------------------------------------------
/// prefectures_strategy_impl.dart
/// ----------------------------------------------------------------------------
/// Contract for the prefectures strategy controllers.
abstract class PrefecturesControllerStrategyImpl {
  List<PrefectureDto> prefectures = List<PrefectureDto>.empty(growable: true);
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();

  Future<void> update() async {
    reset();
    await retrievePersistedPrefectures();
  }

  void reset() {
    prefectures.clear();
  }

  Future<List<PrefectureDto>> retrievePersistedPrefectures();
}
