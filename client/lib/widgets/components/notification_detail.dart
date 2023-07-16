import 'common/chip_widget.dart';
import 'package:flutter/material.dart';
import '../../models/outage_dto.dart';

/// ----------------------------------------------------------------------------
/// notification_detail.dart
/// ----------------------------------------------------------------------------
/// Populates the details for a specific notification.
class NotificationDetail extends StatelessWidget {
  final OutageDto outageDto;

  NotificationDetail({Key? key, required this.outageDto})
      : super(key: ObjectKey(outageDto));

  /// Builds the card that shows all the relevant outage information.
  Widget listItem(BuildContext context) {
    double threshold = 501;
    bool isScreenWide = MediaQuery.of(context).size.width >= threshold;

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          ListTile(
            leading:
                Image.asset(outageDto.image, fit: BoxFit.contain, height: 42),
            title: Text("Νομός " + outageDto.prefecture,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              "Δήμος " + outageDto.municipality,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold),
            ),
          ),

          // CHIP LABELS
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
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
                      color: const Color(0xFFB00020), label: outageDto.reason)
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              outageDto.areaDescription,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
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
