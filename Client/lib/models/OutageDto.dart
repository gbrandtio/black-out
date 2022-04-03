import 'dart:convert';

/// Representational model of an outage as presented from DEDDHE.
/// Note: Any additions to the fields of this class must result to additions on the constructor and the factory
/// constructor.
class Outage{
  String prefecture = "";
  String fromDatetime = "";
  String toDatetime = "";
  String municipality = "";
  String areaDescription = "";
  String number = "";
  String reason = "";
  List<Outage> outages = [];

  ///Constructor that *must* set all the fields of the Outage model.
  Outage(String prefecture, String fromDatetime, String toDatetime, String municipality,
      String areaDescription, String number, String reason){
    this.prefecture = prefecture;
    this.fromDatetime = fromDatetime;
    this.toDatetime = toDatetime;
    this.municipality = municipality;
    this.areaDescription = areaDescription;
    this.number = number;
    this.reason = reason;
  }

  ///Factory constructor that initializes a final variable from a json object.
  ///This is used to instantly create an Outage object from the respective REST response.
  factory Outage.fromJson(Map<String, dynamic> json){
    return Outage(json['prefecture'] as String, json['from_datetime'] as String,
        json['to_datetime'] as String, json['municipality'] as String, json['area_description'] as String,
        json['number'] as String, json['reason'] as String);
  }

  ///Converts an Outage model to a json object based on the APIs specification.
  String toJson(Outage outage){
    Map<String, dynamic> mapOutage = {
      'prefecture' : outage.prefecture,
      'from_datetime' : outage.fromDatetime,
      'to_datetime' : outage.toDatetime,
      'municipality' : outage.municipality,
      'area_description' : outage.areaDescription,
      'number' : outage.number,
      'reason' : outage.reason
    };
    return jsonEncode(mapOutage);
  }
}