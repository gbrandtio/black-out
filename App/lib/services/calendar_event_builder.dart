import 'package:add_2_calendar/add_2_calendar.dart';

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
}
