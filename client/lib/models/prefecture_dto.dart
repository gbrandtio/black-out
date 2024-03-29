import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:quiver/core.dart';
import '../services/data_persist_service/data_persist_service_keys.dart';
import '../services/data_persist_service/prefectures_data_persist.dart';

/// ----------------------------------------------------------------------------
/// prefecture_dto.dart
/// ----------------------------------------------------------------------------
/// Representational model of a prefecture as presented from DEDDHE.
/// Note: Any additions to the fields of this class must result to additions
/// on the constructor and the factory constructor.
class PrefectureDto {
  /// Every prefecture is given a unique id from the DEDDHE API. This id is used for the requests.
  String id = "";

  /// The name of each prefecture.
  String name = "";

  /// Constructor that *must* set all the fields of the Prefecture model.
  PrefectureDto(this.id, this.name);

  /// Factory to return a default prefecture in order to avoid hardcoding default values.
  /// The default prefecture is retrieved from the saved user preferences, but if it doesn't
  /// exist the default falls back to Attica.
  factory PrefectureDto.defaultPrefecture() {
    PrefectureDto savedPrefecturePreference =
        PrefectureDto("23", "ΘΕΣΣΑΛΟΝΙΚΗΣ");
    try {
      savedPrefecturePreference = PrefecturesDataPersistService()
          .retrieveValueOf(DataPersistServiceKeys.defaultPrefecturePreference);
    } catch (e) {
      // There isn't any saved prefecture preference. Continue with the default app prefecture.
      debugPrint("Failed to get default prefecture preference: $e");
    }
    return savedPrefecturePreference;
  }

  /// Encodes a List of OutageDto objects into a String.
  ///
  /// @returns the encoded String object.
  static String encode(List<PrefectureDto> prefectures) =>
      json.encode(prefectures
          .map<Map<String, dynamic>>((outage) => PrefectureDto.toMap(outage))
          .toList());

  /// Decodes an encoded String of List<PrefectureDto> objects into
  /// its equivalent List<PrefectureDto> data structure.
  ///
  /// @returns the decoded list of OutageDto objects.
  static List<PrefectureDto> decode(String encodedPrefecturesList) =>
      (json.decode(encodedPrefecturesList) as List<dynamic>)
          .map<PrefectureDto>((item) => PrefectureDto.fromJson(item))
          .toList();

  static Map<String, dynamic> toMap(PrefectureDto prefecture) => {
        'id': prefecture.id,
        'name': prefecture.name,
      };

  /// Factory constructor that initializes a final variable from a json object.
  /// This is used to instantly create PrefectureDto object from the respective REST response.
  factory PrefectureDto.fromJson(Map<dynamic, dynamic> json) {
    return PrefectureDto(json["id"], json["name"]);
  }

  /// Converts a PrefectureDto model to a json object based on the APIs specification.
  static Map<String, dynamic> toJson(PrefectureDto prefecture) {
    Map<String, dynamic> mapPrefecture = {
      'id': prefecture.id,
      'name': prefecture.name,
    };
    return mapPrefecture;
  }

  /// Two objects of PrefectureDto are equal only if their ids match.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is PrefectureDto && other.id == id) return true;
    return false;
  }

  /// Every object has a hash. Overriding since we overrode == operator as well.
  @override
  int get hashCode => hash2(id.hashCode, name.hashCode);
}
