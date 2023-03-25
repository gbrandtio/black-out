import 'dart:convert';
import '../models/outage_dto.dart';
import '../models/prefecture_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPersistService {
  //#region Shared Preferences Keys
  static const String enableNotificationsPreference = "ENABLE_NOTIFICATIONS";
  static const String defaultPrefecturePreference = "DEFAULT_PREFECTURE";
  static const String savedOutagesPersistKey = "SAVED_OUTAGES_LIST";
  //#endregion

  //#region Data Members
  static final DataPersistService _dataPersistServiceInstance =
      DataPersistService._internal();
  static SharedPreferences? preferences;
  //#endregion

  /// Internal constructor for singleton pattern.
  DataPersistService._internal() {
    initializePreferences();
  }

  /// Factory to satisfy the singleton.
  factory DataPersistService() {
    return _dataPersistServiceInstance;
  }

  /// Initializes the shared preferences object to be used in this class.
  Future<SharedPreferences?> initializePreferences() async {
    preferences = await SharedPreferences.getInstance();
    print("initialized preferences");
    return preferences;
  }

  /// Used to persist String data.
  Future<void> persist(String key, String data) async {
    await preferences?.setString(key, data);
  }

  /// Retrieves persist data of type String.
  String? getString(String key) {
    String? data = preferences?.getString(key);
    return data;
  }

  /// Serializes a PrefectureDto string into a JSON object.
  Future<void> persistPrefecture(String key, PrefectureDto data) async {
    String prefectureDtoStr = jsonEncode(PrefectureDto.toJson(data));
    await preferences?.setString(key, prefectureDtoStr);
  }

  /// Decodes the encoded PrefectureDto into an object.
  ///
  /// @returns the saved PrefectureDto object user preference.
  PrefectureDto getPrefecture(String key) {
    String? data = preferences
        ?.getString(key); // retrieve the encoded JSON data of the prefecture.
    Map jsonData = jsonDecode(data!); // decode the saved json data into a Map.
    PrefectureDto prefectureDto = PrefectureDto.fromJson(
        jsonData); // decode the JSON Map into a PrefectureDto.
    return prefectureDto;
  }

  /// * Retrieves the encoded saved outages and decodes them into a List.
  /// * Adds the outageDto parameter to the list.
  /// * Encodes the new list and saves it to the persisted data.
  Future<void> persistOutageListItem(OutageDto outageDto) async {
    List<OutageDto> alreadySavedOutages = List<OutageDto>.empty(growable: true);
    alreadySavedOutages = getSavedOutages();
    alreadySavedOutages.add(outageDto);

    String encodedSavedOutages = OutageDto.encode(alreadySavedOutages);
    await preferences?.setString(savedOutagesPersistKey, encodedSavedOutages);
  }

  /// Removes the [outage] from the persistent storage.
  Future<void> deleteOutage(OutageDto outage) async {
    List<OutageDto> alreadySavedOutages = List<OutageDto>.empty(growable: true);
    alreadySavedOutages = getSavedOutages();
    alreadySavedOutages.remove(outage);

    String encodedSavedOutages = OutageDto.encode(alreadySavedOutages);
    await preferences?.setString(savedOutagesPersistKey, encodedSavedOutages);
  }

  /// Decodes the outages that are saved as an encoded string.
  ///
  /// @returns the decoded saved outages as a list.
  List<OutageDto> getSavedOutages() {
    List<OutageDto> savedOutages = List<OutageDto>.empty(growable: true);

    try {
      String? strSavedOutages = preferences?.getString(savedOutagesPersistKey);
      savedOutages = OutageDto.decode(strSavedOutages!);
    } catch (e) {
      // Swallow the exception
    }

    return savedOutages;
  }
}
