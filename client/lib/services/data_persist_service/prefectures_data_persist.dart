import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../models/prefecture_dto.dart';
import 'data_persist_service_impl.dart';
import 'data_persist_service_keys.dart';

class PrefecturesDataPersistService extends DataPersistServiceImpl {
  @override
  Future<void> persistObject(Object object, String key) async {
    PrefectureDto prefectureDto = object as PrefectureDto;
    String encodedPrefectureDto =
        jsonEncode(PrefectureDto.toJson(prefectureDto));

    await DataPersistServiceImpl.preferences
        ?.setString(key, encodedPrefectureDto);
  }

  @override
  Future<void> persistList(List<Object> list, String key) async {
    List<PrefectureDto> prefectures = list as List<PrefectureDto>;
    String encodedSavedOutages = PrefectureDto.encode(prefectures);
    await DataPersistServiceImpl.preferences
        ?.setString(key, encodedSavedOutages);
  }

  @override
  Future<void> deleteObject(Object object, String key) async {
    PrefectureDto prefectureDto = object as PrefectureDto;
    List<PrefectureDto> alreadySavedOutages =
        List<PrefectureDto>.empty(growable: true);
    alreadySavedOutages = retrievePrefectures(key);
    alreadySavedOutages.remove(prefectureDto);

    String encodedSavedOutages = PrefectureDto.encode(alreadySavedOutages);
    await DataPersistServiceImpl.preferences?.setString(
        DataPersistServiceKeys.savedOutagesPersistKey, encodedSavedOutages);
  }

  @override
  PrefectureDto retrieveValueOf(String key) {
    PrefectureDto prefectureDto = PrefectureDto("23", "ΘΕΣΣΑΛΟΝΙΚΗΣ");
    try {
      // retrieve the encoded JSON data of the prefecture.
      String? data = DataPersistServiceImpl.preferences?.getString(key);

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

  List<PrefectureDto> retrievePrefectures(String key) {
    List<PrefectureDto> savedPrefectures =
        List<PrefectureDto>.empty(growable: true);

    try {
      String? strSavedOutages =
          DataPersistServiceImpl.preferences?.getString(key);
      debugPrint("saved prefectures: $strSavedOutages");
      savedPrefectures = PrefectureDto.decode(strSavedOutages!);
    } catch (e) {
      debugPrint(
          "Failed to retrieve the saved prefectures from persistent storage: ${e.toString()}");
    }

    return savedPrefectures;
  }
}
