import 'package:black_out_groutages/models/prefecture_dto.dart';

abstract class PrefecturesControllerStrategyImpl {
  List<PrefectureDto> prefectures = List<PrefectureDto>.empty(growable: true);
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();

  void update() {
    reset();
    updatePrefectures();
  }

  void reset() {
    prefectures.clear();
  }

  Future<List<PrefectureDto>> updatePrefectures();
}
