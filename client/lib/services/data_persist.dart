import 'dart:convert';
import '../models/outage_dto.dart';
import '../models/prefecture_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ----------------------------------------------------------------------------
/// data_persist.dart
/// ----------------------------------------------------------------------------
/// A service to offer common functionality for persisting outages and
/// prefectures into the local storage.
class DataPersistService {
  static const String enableNotificationsPreference = "ENABLE_NOTIFICATIONS";
  static const String defaultPrefecturePreference = "DEFAULT_PREFECTURE";
  static const String savedOutagesPersistKey = "SAVED_OUTAGES_LIST";
  static const String notificationsOutagesList = "NOTIFICATIONS_OUTAGES_LIST";

  static final DataPersistService _dataPersistServiceInstance =
      DataPersistService._internal();
  static SharedPreferences? preferences;

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
    PrefectureDto prefectureDto = PrefectureDto("23","ΘΕΣΣΑΛΟΝΙΚΗΣ");
    try {
      String? data = preferences
          ?.getString(key); // retrieve the encoded JSON data of the prefecture.
      Map jsonData = jsonDecode(data!); // decode the saved json data into a Map.
      prefectureDto = PrefectureDto.fromJson(
          jsonData); // decode the JSON Map into a PrefectureDto.
    }
    catch (e) {
      //
    }

    return prefectureDto;
  }

  /// * Retrieves the encoded saved outages and decodes them into a List.
  /// * Adds the outageDto parameter to the list.
  /// * Encodes the new list and saves it to the persisted data.
  Future<void> persistOutageListItem(OutageDto outageDto, String key) async {
    List<OutageDto> alreadySavedOutages = List<OutageDto>.empty(growable: true);
    alreadySavedOutages = getSavedOutages(key);
    alreadySavedOutages.add(outageDto);

    String encodedSavedOutages = OutageDto.encode(alreadySavedOutages);
    await preferences?.setString(savedOutagesPersistKey, encodedSavedOutages);
  }

  /// Persists a list of [OutageDto] objects.
  Future<void> persistOutages(List<OutageDto> outages) async {
    String encodedSavedOutages = OutageDto.encode(outages);
    await preferences?.setString(notificationsOutagesList, encodedSavedOutages);
  }

  /// Removes the [outage] from the persistent storage.
  Future<void> deleteOutage(OutageDto outage, String key) async {
    List<OutageDto> alreadySavedOutages = List<OutageDto>.empty(growable: true);
    alreadySavedOutages = getSavedOutages(key);
    alreadySavedOutages.remove(outage);

    String encodedSavedOutages = OutageDto.encode(alreadySavedOutages);
    await preferences?.setString(savedOutagesPersistKey, encodedSavedOutages);
  }

  /// Removes all the content of the passed [key] from persistent storage.
  Future<void> delete(String key) async {
    await preferences?.setString(key, "");
  }

  /// Decodes the outages that are saved as an encoded string.
  ///
  /// @returns the decoded saved outages as a list.
  List<OutageDto> getSavedOutages(String key) {
    List<OutageDto> savedOutages = List<OutageDto>.empty(growable: true);

    try {
      String? strSavedOutages = preferences?.getString(key);
      savedOutages = OutageDto.decode(strSavedOutages!);
    } catch (e) {
      // Swallow the exception
    }

    return savedOutages;
  }
}
