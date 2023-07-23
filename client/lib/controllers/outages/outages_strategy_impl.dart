import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/components/outages/outage_list_item.dart';

/// ----------------------------------------------------------------------------
/// outages_strategy_impl.dart
/// ----------------------------------------------------------------------------
/// Contract for the outages strategy controllers.
abstract class OutagesControllerStrategyImpl {
  List<OutageListItem> outagesList = List<OutageListItem>.empty(growable: true);
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();

  /// Resets the persisted outages list (clears it) and
  /// updates it with the passed prefecture.
  Future<void> update(PrefectureDto selectedPrefecture) async {
    debugPrint("Updating outages of ${selectedPrefecture.name}");
    reset();
    await updateOutagesList(selectedPrefecture);
  }

  /// Clears the persisted outages list.
  void reset() {
    debugPrint("Resetting outages strategy data.");
    outagesList.clear();
  }

  Future<List<OutageListItem>> updateOutagesList(
      PrefectureDto selectedPrefecture);
}
