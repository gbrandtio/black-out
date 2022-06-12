import 'package:black_out_groutages/services/data_persist.dart';
import 'package:quiver/core.dart';

/// Representational model of a prefecture as presented from DEDDHE.
/// Note: Any additions to the fields of this class must result to additions
/// on the constructor and the factory construtor.
class PrefectureDto {
  String id =
      ""; // Every prefecture is given a unique id from the DEDDHE API. This id is used for the requests.
  String name = ""; // The name of each prefecture.

  /// Constructor that *must* set all the fields of the Prefecture model.
  PrefectureDto(this.id, this.name);

  /// Factory constructor that initializes a final variable from a json object.
  /// This is used to instantly create PrefectureDto object from the respective REST response.
  factory PrefectureDto.fromJson(Map<dynamic, dynamic> json) {
    return PrefectureDto(json["id"], json["name"]);
  }

  /// Factory to return a default prefecture in order to avoid hardcoding default values.
  /// The default prefecture is retrieved from the saved user preferences, but if it doesn't
  /// exist the default falls back to Attica.
  factory PrefectureDto.defaultPrefecture() {
    PrefectureDto savedPrefecturePreference = PrefectureDto("10", "ΑΤΤΙΚΗΣ");
    try {
      savedPrefecturePreference = DataPersistService()
          .getPrefecture(DataPersistService.defaultPrefecturePreference);
    } catch (e) {
      // There isn't any saved prefecture preference. Continue with the default app prefecture.
    }
    return savedPrefecturePreference;
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
    PrefectureDto o = other as PrefectureDto;
    if (o.id == id) return true;
    return false;
  }

  /// Every object has a hash. Overriding since we overrode == operator as well.
  @override
  int get hashCode => hash2(id.hashCode, name.hashCode);
}
