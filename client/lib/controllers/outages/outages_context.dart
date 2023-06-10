import 'package:black_out_groutages/controllers/outages/outages_strategy_impl.dart';
import 'package:black_out_groutages/controllers/outages/persisted_outages_strategy.dart';
import 'package:black_out_groutages/controllers/outages/retrieve_outages_strategy.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';

import '../../widgets/components/outage_list_item.dart';

/// ----------------------------------------------------------------------------
/// outages_context.dart
/// ----------------------------------------------------------------------------
/// Acts as a client for executing the desired strategies implemented by the
/// strategy pattern followed by this controller. This class has been implemented
/// in order to provide a transparent way of execution towards the rest of the
/// application.
class OutagesContext {
  late OutagesControllerStrategyImpl strategy;

  void setOutagesStrategy(OutagesControllerStrategyImpl newStrategy) {
    strategy = newStrategy;
  }

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
