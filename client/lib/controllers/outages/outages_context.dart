import 'package:black_out_groutages/controllers/outages/base_strategy.dart';
import 'package:black_out_groutages/controllers/outages/persisted_outages_strategy.dart';
import 'package:black_out_groutages/controllers/outages/retrieve_outages_strategy.dart';
import 'package:black_out_groutages/models/prefecture_dto.dart';

import '../../widgets/components/outage_list_item.dart';

class OutagesContext {
  late BaseOutagesControllerStrategy strategy;

  void setOutagesStrategy(BaseOutagesControllerStrategy newStrategy) {
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