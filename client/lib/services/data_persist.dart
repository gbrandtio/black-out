import 'dart:convert';
import 'package:flutter/cupertino.dart';

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
  static const String outagesOfDefaultPrefecture =
      "OUTAGES_OF_DEFAULT_PREFECTURE";
  static const String notificationOutages = "NOTIFICATION_OUTAGES";

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

  /// Retrieves persist data of type String.
  String? getString(String key) {
    String? data = preferences?.getString(key);
    return data;
  }

  /// Used to persist String data.
  Future<void> persist(String key, String data) async {
    await preferences?.setString(key, data);
  }

  /// Serializes a PrefectureDto string into a JSON object.
  Future<void> persistPrefecture(String key, PrefectureDto data) async {
    String prefectureDtoStr = jsonEncode(PrefectureDto.toJson(data));
    await preferences?.setString(key, prefectureDtoStr);
  }

  /// Decodes the encoded PrefectureDto into an object and
  /// returns the saved PrefectureDto object user preference.
  PrefectureDto getPrefecture(String key) {
    PrefectureDto prefectureDto = PrefectureDto("23", "ΘΕΣΣΑΛΟΝΙΚΗΣ");
    try {
      // retrieve the encoded JSON data of the prefecture.
      String? data = preferences?.getString(key);

      // decode the saved json data into a Map.
      Map jsonData = jsonDecode(data!);

      // decode the JSON Map into a PrefectureDto.
      prefectureDto = PrefectureDto.fromJson(jsonData);
    } catch (e) {
      debugPrint(
          "Failed to get prefecture from persisted storage: ${e.toString()}");
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
  Future<void> persistOutages(List<OutageDto> outages, String key) async {
    String encodedSavedOutages = OutageDto.encode(outages);
    await preferences?.setString(key, encodedSavedOutages);
  }

  /// Removes all the content of the passed [key] from persistent storage.
  Future<void> delete(String key) async {
    await preferences?.remove(key);
  }

  /// Removes the [outage] from the persistent storage.
  Future<void> deleteOutage(OutageDto outage, String key) async {
    List<OutageDto> alreadySavedOutages = List<OutageDto>.empty(growable: true);
    alreadySavedOutages = getSavedOutages(key);
    alreadySavedOutages.remove(outage);

    String encodedSavedOutages = OutageDto.encode(alreadySavedOutages);
    await preferences?.setString(savedOutagesPersistKey, encodedSavedOutages);
  }

  /// Decodes the outages that are saved as an encoded string.
  /// Returns the decoded saved outages as a list.
  List<OutageDto> getSavedOutages(String key) {
    List<OutageDto> savedOutages = List<OutageDto>.empty(growable: true);

    try {
      String? strSavedOutages = preferences?.getString(key);
      savedOutages = OutageDto.decode(strSavedOutages!);
    } catch (e) {
      debugPrint(
          "Failed to retrieve the saved outages from persistent storage: ${e.toString()}");
    }

    return savedOutages;
  }
}
