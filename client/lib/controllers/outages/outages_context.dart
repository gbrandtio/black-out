import 'package:black_out_groutages/controllers/outages/outages_strategy_impl.dart';
import 'package:black_out_groutages/controllers/outages/persisted_outages_strategy.dart';
import 'package:black_out_groutages/controllers/outages/retrieve_outages_strategy.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';

import '../../widgets/components/outages/outage_list_item.dart';

/// ----------------------------------------------------------------------------
/// outages_context.dart
/// ----------------------------------------------------------------------------
/// Acts as a client for executing the desired strategies implemented by the
/// strategy pattern followed by this controller. This class has been implemented
/// in order to provide a transparent way of execution towards the rest of the
/// application.
class OutagesContext {
  late OutagesControllerStrategyImpl strategy;

  /// Sets the strategy to be executed.
  void setOutagesStrategy(OutagesControllerStrategyImpl newStrategy) {
    strategy = newStrategy;
  }

  /// Executes the business logic of the controller. This function will
  /// set the required strategies to be executed. Specifically:
  /// - Executes the [PersistedOutagesControllerStrategy] in order to retrieve
  /// any persisted outages.
  /// - If there aren't any persisted outages, moves on and retrieves the outages
  /// from the remote source.
  List<OutageListItem> execute(PrefectureDto selectedPrefecture) {
    setOutagesStrategy(PersistedOutagesControllerStrategy());
    strategy.update(selectedPrefecture);

    if (strategy.outagesList.isNotEmpty) {
      return strategy.outagesList;
    }

    setOutagesStrategy(RetrieveOutagesControllerStrategy());
    strategy.update(selectedPrefecture);

    return strategy.outagesList;
  }
}
