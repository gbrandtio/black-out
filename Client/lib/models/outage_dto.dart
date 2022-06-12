import 'dart:convert';

/// Representational model of an outage as presented from DEDDHE.
/// Note: Any additions to the fields of this class must result to additions on the constructor and the factory
/// constructor.
class OutageDto{
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
  OutageDto(this.prefecture, this.fromDatetime, this.toDatetime, this.municipality,
      this.areaDescription, this.number, this.reason, this.image);

  /// Factory constructor that initializes a final variable from a json object.
  /// This is used to instantly create an Outage object from the respective REST response.
  factory OutageDto.fromJson(Map<String, dynamic> json){
    return OutageDto(json['prefecture'] as String, json['from_datetime'] as String,
        json['to_datetime'] as String, json['municipality'] as String, json['area_description'] as String,
        json['number'] as String, json['reason'] as String, json['image'] as String);
  }

  /// Converts an Outage model to a json object based on the APIs specification.
  String toJson(OutageDto outage){
    Map<String, dynamic> mapOutage = {
      'prefecture' : outage.prefecture,
      'from_datetime' : outage.fromDatetime,
      'to_datetime' : outage.toDatetime,
      'municipality' : outage.municipality,
      'area_description' : outage.areaDescription,
      'number' : outage.number,
      'reason' : outage.reason,
      'image' : outage.image
    };
    return jsonEncode(mapOutage);
  }
}