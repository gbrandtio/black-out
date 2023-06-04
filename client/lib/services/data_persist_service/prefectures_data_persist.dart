import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../models/prefecture_dto.dart';
import 'data_persist_service_impl.dart';

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
  Future<void> deleteObject(Object object, String key) async {}

  @override
  Future<void> persistList(List<Object> list, String key) async {}

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
}
