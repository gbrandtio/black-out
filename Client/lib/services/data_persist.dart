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

  /// Used to persist any known type of object.
  Future<void> persist(String key, String data) async {
    await preferences?.setString(key, data);
  }

  /// Retrieves persist data of type String.
  Future<String?> getString(String key) async{
    String? data = preferences?.getString(key);
    return data;
  }
}
