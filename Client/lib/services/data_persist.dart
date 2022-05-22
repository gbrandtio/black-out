import 'dart:convert';
import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPersistService {
  //#region Shared Preferences Keys
  static const String enableNotificationsPreference = "ENABLE_NOTIFICATIONS";
  static const String defaultPrefecturePreference = "DEFAULT_PREFECTURE";
  //#endregion

  //#region Data Members
  static final DataPersistService _dataPersistServiceInstance = DataPersistService._internal();
  static SharedPreferences? preferences;
  //#endregion

  /// Internal constructor for singleton pattern.
  DataPersistService._internal(){
    initializePreferences();
  }

  /// Factory to satisfy the singleton.
  factory DataPersistService(){
    return _dataPersistServiceInstance;
  }

  /// Initializes the shared preferences object to be used in this class.
  Future<SharedPreferences?> initializePreferences() async{
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  /// Used to persist String data.
  Future<void> persist(String key, String data) async {
    await preferences?.setString(key, data);
  }

  /// Serializes a PrefectureDto string into a JSON object.
  Future<void> persistPrefecture(String key, PrefectureDto data) async{
    String prefectureDtoStr = jsonEncode(PrefectureDto.toJson(data));
    await preferences?.setString(key, prefectureDtoStr);
  }

  /// Retrieves persist data of type String.
  String? getString(String key){
    String? data = preferences?.getString(key);
    return data;
  }

  /// Returns the saved PrefectureDto object user preference.
  PrefectureDto getPrefecture(String key){
    String? data = preferences?.getString(key); // retrieve the encoded JSON data of the prefecture.
    Map jsonData = jsonDecode(data!); // decode the saved json data into a Map.
    PrefectureDto prefectureDto = PrefectureDto.fromJson(jsonData); // decode the JSON Map into a PrefectureDto.
    return prefectureDto;
  }
}
