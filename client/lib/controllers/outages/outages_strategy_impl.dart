import 'package:black_out_groutages/models/prefecture_dto.dart';
import '../../widgets/components/outage_list_item.dart';

/// ----------------------------------------------------------------------------
/// outages_strategy_impl.dart
/// ----------------------------------------------------------------------------
/// Contract for the outages strategy controllers.
abstract class OutagesControllerStrategyImpl {
  List<OutageListItem> outagesList = List<OutageListItem>.empty(growable: true);
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();

  void update(PrefectureDto selectedPrefecture) {
    reset();
    updateOutagesList(selectedPrefecture);
  }

  void reset() {
    outagesList.clear();
  }

  Future<List<OutageListItem>> updateOutagesList(
      PrefectureDto selectedPrefecture);
}
