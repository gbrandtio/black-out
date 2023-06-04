import 'package:black_out_groutages/services/data_persist_service/data_persist_service_impl.dart';
import 'package:flutter/cupertino.dart';
import '../../models/outage_dto.dart';
import 'data_persist_service_keys.dart';

/// ----------------------------------------------------------------------------
/// outages_data_persist.dart
/// ----------------------------------------------------------------------------
/// A service to offer common functionality for persisting outages into the
/// local storage.
class OutagesDataPersistService extends DataPersistServiceImpl {
  @override
  Future<void> persistObject(Object object, String key) async {
    OutageDto outageDto = object as OutageDto;
    List<OutageDto> alreadySavedOutages = List<OutageDto>.empty(growable: true);
    alreadySavedOutages = retrieveValueOf(key);
    alreadySavedOutages.add(outageDto);

    String encodedSavedOutages = OutageDto.encode(alreadySavedOutages);
    await DataPersistServiceImpl.preferences?.setString(
        DataPersistServiceKeys.savedOutagesPersistKey, encodedSavedOutages);
  }

  @override
  Future<void> persistList(List<Object> list, String key) async {
    List<OutageDto> outages = list as List<OutageDto>;
    String encodedSavedOutages = OutageDto.encode(outages);
    await DataPersistServiceImpl.preferences
        ?.setString(key, encodedSavedOutages);
  }

  @override
  Future<void> deleteObject(Object object, String key) async {
    OutageDto outageDto = object as OutageDto;
    List<OutageDto> alreadySavedOutages = List<OutageDto>.empty(growable: true);
    alreadySavedOutages = retrieveValueOf(key);
    alreadySavedOutages.remove(outageDto);

    String encodedSavedOutages = OutageDto.encode(alreadySavedOutages);
    await DataPersistServiceImpl.preferences?.setString(
        DataPersistServiceKeys.savedOutagesPersistKey, encodedSavedOutages);
  }

  @override
  List<OutageDto> retrieveValueOf(String key) {
    List<OutageDto> savedOutages = List<OutageDto>.empty(growable: true);

    try {
      String? strSavedOutages =
          DataPersistServiceImpl.preferences?.getString(key);
      savedOutages = OutageDto.decode(strSavedOutages!);
    } catch (e) {
      debugPrint(
          "Failed to retrieve the saved outages from persistent storage: ${e.toString()}");
    }

    return savedOutages;
  }
}
