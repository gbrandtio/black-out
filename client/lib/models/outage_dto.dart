import 'dart:convert';
import 'package:string_extensions/string_extensions.dart';
import 'package:intl/intl.dart';

/// ----------------------------------------------------------------------------
/// outage_dto.dart
/// ----------------------------------------------------------------------------
/// Representational model of an outage as presented from DEDDHE.
/// Note: Any additions to the fields of this class must result to additions on the constructor and the factory
/// constructor.
class OutageDto {
  String prefecture = "";
  String fromDatetime = "";
  String toDatetime = "";
  String municipality = "";
  String areaDescription = "";
  String number = "";
  String reason = "";
  String image = ""; // The image is not returned populated from the API.
  List<OutageDto> outages = [];

  /// Constructor that *must* set all the fields of the Outage model.
  OutageDto(
      this.prefecture,
      this.fromDatetime,
      this.toDatetime,
      this.municipality,
      this.areaDescription,
      this.number,
      this.reason,
      this.image);

  /// Factory constructor that initializes a final variable from a json object.
  /// This is used to instantly create an Outage object from the respective REST response.
  factory OutageDto.fromJson(Map<String, dynamic> json) {
    return OutageDto(
        json['prefecture'] as String,
        json['from_datetime'] as String,
        json['to_datetime'] as String,
        json['municipality'] as String,
        json['area_description'] as String,
        json['number'] as String,
        json['reason'] as String,
        json['image'] as String);
  }

  /// Converts an Outage model to a json object based on the APIs specification.
  String toJson(OutageDto outage) {
    Map<String, dynamic> mapOutage = {
      'prefecture': outage.prefecture,
      'from_datetime': outage.fromDatetime,
      'to_datetime': outage.toDatetime,
      'municipality': outage.municipality,
      'area_description': outage.areaDescription,
      'number': outage.number,
      'reason': outage.reason,
      'image': outage.image
    };
    return jsonEncode(mapOutage);
  }

  static Map<String, dynamic> toMap(OutageDto outage) => {
        'prefecture': outage.prefecture,
        'from_datetime': outage.fromDatetime,
        'to_datetime': outage.toDatetime,
        'municipality': outage.municipality,
        'area_description': outage.areaDescription,
        'number': outage.number,
        'reason': outage.reason,
        'image': outage.image
      };

  /// Two objects of OutageDto are equal if all their properties match.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is OutageDto &&
        other.prefecture == prefecture &&
        other.fromDatetime == fromDatetime &&
        other.toDatetime == toDatetime &&
        other.municipality == municipality &&
        other.areaDescription == areaDescription &&
        other.number == number &&
        other.reason == reason &&
        other.image == image) {
      return true;
    }

    return false;
  }

  @override
  int get hashCode =>
      prefecture.hashCode +
      fromDatetime.hashCode +
      toDatetime.hashCode +
      municipality.hashCode +
      areaDescription.hashCode +
      number.hashCode +
      reason.hashCode +
      image.hashCode;

  /// Encodes a List of OutageDto objects into a String.
  ///
  /// @returns the encoded String object.
  static String encode(List<OutageDto> outagesList) => json.encode(outagesList
      .map<Map<String, dynamic>>((outage) => OutageDto.toMap(outage))
      .toList());

  /// Decodes an encoded String of List<OutageDto> objects into
  /// its equivalent List<OutageDto> data structure.
  ///
  /// @returns the decoded list of OutageDto objects.
  static List<OutageDto> decode(String strEncodedOutagesList) =>
      (json.decode(strEncodedOutagesList) as List<dynamic>)
          .map<OutageDto>((item) => OutageDto.fromJson(item))
          .toList();

  /// Provides a valid [DateTime] that can be returned based on the provided
  /// string from the outages API. The provided string needs to be on the
  /// format:
  /// DD/M/yyyy hh:mm:ss aa where aa corresponds to the 12-hour time literals.
  static DateTime convertOutageDtoDateToValidDateTime(String dateTime) {
    // If the String does not contain any Greek characters, return it as is.
    String onlyGreek = dateTime.replaceAll(" ", "");
    if (onlyGreek.isEmpty) {
      return DateTime.now();
    }
    // Translate all the Greek letters to the equivalent English ones.
    String dateTimeWithEnglishTimeLiterals = dateTime.replaceGreek!.trim();
    // Transform to the equivalent English time literals.
    dateTimeWithEnglishTimeLiterals =
        dateTimeWithEnglishTimeLiterals.replaceAll(".", "").toLowerCase();
    dateTimeWithEnglishTimeLiterals =
        dateTimeWithEnglishTimeLiterals.contains("pm")
            ? dateTimeWithEnglishTimeLiterals.replaceAll("pm", "AM")
            : dateTimeWithEnglishTimeLiterals.replaceAll("mm", "PM");

    DateFormat dateFormat = DateFormat("DD/M/yyyy hh:mm:ss a");
    dateFormat.parse(dateTimeWithEnglishTimeLiterals);
    return dateFormat.parse(dateTimeWithEnglishTimeLiterals);
  }

  /// Filters the [outages] list and keeps only the outages that match only
  /// today's or tomorrow's day.
  static List<OutageDto> filterOutagesList(List<OutageDto> outages) {
    for (int i = 0; i < outages.length; i++) {
      DateTime fromDateTime = OutageDto.convertOutageDtoDateToValidDateTime(
          outages[i].fromDatetime);
      DateTime toDateTime =
          OutageDto.convertOutageDtoDateToValidDateTime(outages[i].toDatetime);

      if (!(fromDateTime.day == DateTime.now().day ||
          toDateTime.day == DateTime.now().day)) {
        outages.removeAt(i);
      }
    }

    return outages;
  }
}
