import 'chip_widget.dart';
import 'package:flutter/material.dart';
import '../../models/outage_dto.dart';

/// ----------------------------------------------------------------------------
/// notification_list_item.dart
/// ----------------------------------------------------------------------------
/// Representation of a single notification item to be displayed as part of a list.
class NotificationListItem extends StatelessWidget {
  final OutageDto outageDto;

  const NotificationListItem({Key? key, required this.outageDto})
      : super(key: key);

  /// Builds the card that shows all the relevant outage information.
  Widget listItem(BuildContext context) {
    double threshold = 501;
    bool isScreenWide = MediaQuery.of(context).size.width >= threshold;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shadowColor: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: const EdgeInsets.only(right: 12.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: const Icon(Icons.autorenew, color: Colors.black),
              ),
              title: const Text("ΔΙΑΚΟΠΗ ΡΕΥΜΑΤΟΣ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Νομός ${outageDto.prefecture} Δήμος ${outageDto.municipality}",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  ),
                  // CHIP LABELS
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                    children: [
                      ChipWidget(
                          color: const Color.fromRGBO(230, 170, 5, 1),
                          label: outageDto.fromDatetime +
                              " - " +
                              outageDto.toDatetime),
                      ChipWidget(
                          color: const Color(0xFFB00020),
                          label: outageDto.reason)
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.keyboard_arrow_right,
                  color: Colors.black, size: 30.0))
        ],
      ),
    );
  }

  /// Builds the card widget that will be shown to the user with the outage specific data.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: listItem(context));
  }
}
