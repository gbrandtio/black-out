import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:black_out_groutages/models/outage_dto.dart';

/// ----------------------------------------------------------------------------
/// calendar_event_builder.dart
/// ----------------------------------------------------------------------------
/// Class responsible for offering calendar specific functionality.
class CalendarEventBuilder {
  /// Builds a calendar event
  Event buildEvent(
      {Recurrence? recurrence,
      required String eventTitle,
      required String eventDescription,
      required String eventLocation,
      required DateTime eventStartDate,
      required DateTime eventEndDate}) {
    return Event(
      title: eventTitle,
      description: eventDescription,
      location: eventLocation,
      startDate: eventStartDate,
      endDate: eventEndDate,
      allDay: false,
      recurrence: recurrence,
    );
  }

  String constructEventTitle(OutageDto outage) {
    return "Διακοπή Ρεύματος: Δήμος ${outage.municipality}";
  }

  String constructEventDescription(OutageDto outage) {
    return "Διακοπή ρεύματος στον Νομό " +
        outage.prefecture +
        " - Δήμο " +
        outage.municipality +
        " από " +
        outage.fromDatetime +
        " εώς " +
        outage.toDatetime +
        ".\nΠεριοχή:\n" +
        outage.areaDescription +
        "\n\nΠερισσότερες πληροφορίες: https://play.google.com/store/apps/details?id=com.outages.groutages";
  }
}
