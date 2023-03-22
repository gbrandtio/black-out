import 'dart:convert';
import 'package:string_extensions/string_extensions.dart';
import 'package:intl/intl.dart';

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
    String dateTimeWithEnglishTimeLiterals =
        replaceGreekTwelveHourLiteralsToEnglish(dateTime);
    print(dateTimeWithEnglishTimeLiterals);

    DateFormat dateFormat = DateFormat("DD/M/yyyy hh:mm:ss aa");
    dateFormat.parse(dateTimeWithEnglishTimeLiterals);
    return dateFormat.parse(dateTimeWithEnglishTimeLiterals);
  }

  /// Replaces the Greek 12-hour time literals with the English 12-hour time literals
  static String replaceGreekTwelveHourLiteralsToEnglish(
      String twelveHourDateTimeWithGreekLiterals) {
    // Split the incoming string because the greek characters can't be translated
    // when in-between of english characters or numbers.
    List<String> unformattedDateTimeParts =
        twelveHourDateTimeWithGreekLiterals.split(' ');
    String englishTwelveHourConverted =
        "${unformattedDateTimeParts[0].trim()} ${unformattedDateTimeParts[1].trim()}";

    // Translate the Greek time literals to the equivalent English time literals.
    String onlyGreekCharacters = twelveHourDateTimeWithGreekLiterals.onlyGreek!;
    String greekCharactersToEnglish = onlyGreekCharacters.replaceGreek!.trim();
    greekCharactersToEnglish =
        greekCharactersToEnglish.replaceAll(".", "").toLowerCase();

    String englishTranslatedTimeLiterals =
        greekCharactersToEnglish.contains("pm")
            ? greekCharactersToEnglish.replaceAll("pm", "AM")
            : greekCharactersToEnglish.replaceAll("am", "PM");

    return "$englishTwelveHourConverted ${englishTranslatedTimeLiterals.trim().toUpperCase()}";
  }
}
