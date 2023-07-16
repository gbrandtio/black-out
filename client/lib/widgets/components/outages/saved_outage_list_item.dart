import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:black_out_groutages/services/calendar_event_builder.dart';
import 'package:black_out_groutages/services/data_persist_service/outages_data_persist.dart';

import '../../../services/data_persist_service/data_persist_service_keys.dart';
import '../common/chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../../models/outage_dto.dart';

/// ----------------------------------------------------------------------------
/// saved_outage_list_item.dart
/// ----------------------------------------------------------------------------
/// Representation of the saved outages list items that are shown to the user.
class SavedOutageListItem extends StatelessWidget {
  final OutageDto outage;

  const SavedOutageListItem({Key? key, required this.outage}) : super(key: key);

  /// Builds the card that shows all the relevant outage information.
  Widget listItem(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shadowColor: Colors.black,
        child: Dismissible(
          background: Container(
            color: const Color(0xFFB00020),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              ListTile(
                leading:
                    Image.asset(outage.image, fit: BoxFit.contain, height: 42),
                title: Text("Νομός " + outage.prefecture,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                subtitle: Text(
                  "Δήμος " + outage.municipality,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ),

              // CHIP LABELS
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    direction: Axis.vertical,
                    children: [
                      ChipWidget(
                          color: const Color.fromRGBO(230, 170, 5, 1),
                          label:
                              outage.fromDatetime + " - " + outage.toDatetime),
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
                alignment: MainAxisAlignment.start,
                children: [
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
                                          ocurrences: 1),
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
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
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
          onDismissed: (direction) {
            OutagesDataPersistService().deleteObject(
                outage, DataPersistServiceKeys.savedOutagesPersistKey);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Deleted")));
            Navigator.of(context).pop();
          },
          key: Key(outage.number),
        ));
  }

  /// Builds the card widget that will be shown to the user with the outage specific data.
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: listItem(context));
  }
}
