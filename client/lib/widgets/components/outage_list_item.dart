import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:black_out_groutages/services/calendar_event_builder.dart';
import 'package:black_out_groutages/services/data_persist.dart';

import 'chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/outage_dto.dart';

/// ----------------------------------------------------------------------------
/// outage_list_item.dart
/// ----------------------------------------------------------------------------
/// Representation of a single outage item to be displayed as part of a list.
class OutageListItem extends StatelessWidget {
  final OutageDto outage;

  const OutageListItem({Key? key, required this.outage}) : super(key: key);

  /// Builds the card that shows all the relevant outage information.
  Widget listItem(BuildContext context) {
    double threshold = 0;
    bool isScreenWide = MediaQuery.of(context).size.width >= threshold;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shadowColor: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          ListTile(
            leading: Image.asset(outage.image, fit: BoxFit.contain, height: 42),
            title: Text("Νομός " + outage.prefecture,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text(
              "Δήμος " + outage.municipality,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
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
                      label: outage.fromDatetime + " - " + outage.toDatetime),
                  ChipWidget(
                      color: const Color(0xFFB00020), label: outage.reason)
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              outage.areaDescription,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),

          // BOTTOM BUTTONS ROW
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6200EE),
                    fixedSize: const Size.fromWidth(100),
                    padding: const EdgeInsets.all(10)),
                icon: const Icon(Icons.code),
                label: const Text('Save'),
                onPressed: () {
                  List<OutageDto> savedOutages =
                      DataPersistService().getSavedOutages();
                  // Persist the selected outage in local storage
                  switch (savedOutages
                      .where((element) => element == outage)
                      .isNotEmpty) {
                    case true:
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Already Saved")));
                      break;
                    default:
                      DataPersistService().persistOutageListItem(outage);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Outage Saved")));
                      break;
                  }
                },
              ),
              Row(
                children: <Widget>[
                  Center(
                    child: Ink(
                      height: 45,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        color: Colors.black,
                        onPressed: () {
                          Add2Calendar.addEvent2Cal(CalendarEventBuilder()
                              .buildEvent(
                                  recurrence: Recurrence(
                                    frequency: Frequency.daily,
                                    ocurrences: 1,
                                  ),
                                  eventTitle: CalendarEventBuilder()
                                      .constructEventTitle(outage),
                                  eventDescription: CalendarEventBuilder()
                                      .constructEventDescription(outage),
                                  eventLocation: outage.municipality,
                                  eventStartDate: OutageDto
                                      .convertOutageDtoDateToValidDateTime(
                                          outage.fromDatetime),
                                  eventEndDate: OutageDto
                                      .convertOutageDtoDateToValidDateTime(
                                          outage.toDatetime)));
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Ink(
                      height: 45,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.share),
                        color: Colors.black,
                        onPressed: () {
                          final RenderBox box =
                              context.findRenderObject() as RenderBox;
                          Share.share(
                              CalendarEventBuilder()
                                  .constructEventDescription(outage),
                              subject: CalendarEventBuilder()
                                  .constructEventTitle(outage),
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
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