import 'dart:convert';
import 'package:quiver/core.dart';

/// Representational model of a prefecture as presented from DEDDHE.
/// Note: Any additions to the fields of this class must result to additions
/// on the constructor and the factory construtor.
class PrefectureDto{
  String id = ""; // Every prefecture is given a unique id from the DEDDHE API. This id is used for the requests.
  String name = ""; // The name of each prefecture.

  /// Constructor that *must* set all the fields of the Prefecture model.
  PrefectureDto(this.id, this.name);

  /// Factory constructor that initializes a final variable from a json object.
  /// This is used to instantly create PrefectureDto object from the respective REST response.
  factory PrefectureDto.fromJson(Map<String, dynamic> json){
    return PrefectureDto(json["id"], json["name"]);
  }

  /// Converts a PrefectureDto model to a json object based on the APIs specification.
  String toJson(PrefectureDto prefecture){
    Map<String, dynamic> mapPrefecture = {
      'id' : prefecture.id,
      'name' : prefecture.name,
    };
    return jsonEncode(mapPrefecture);
  }

  @override
  bool operator ==(Object other){
    PrefectureDto o = other as PrefectureDto;
    if(o.id == id) return true;
    return false;
  }

  @override
  int get hashCode => hash2(id.hashCode, name.hashCode);
}