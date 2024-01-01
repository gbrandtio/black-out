import 'package:shared_preferences/shared_preferences.dart';

abstract class DataPersistServiceImpl {
  static SharedPreferences? preferences;

  /// Initializes the shared preferences object to be used in this class.
  Future<SharedPreferences?> initializePreferences() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences;
  }

  /// Retrieves Strings from persisted data.
  String? getString(String key) {
    String? data = preferences?.getString(key);
    return data;
  }

  /// Saves Strings into persisted data.
  Future<void> persist(String key, String data) async {
    await preferences?.setString(key, data);
  }

  /// Removes all the content of the passed [key] from persistent storage.
  Future<void> delete(String key) async {
    await preferences?.remove(key);
  }

  /// Used to persist a concrete object into local storage.
  Future<void> persistObject(Object object, String key);

  /// Used to persist a list of concrete objects into local storage.
  Future<void> persistList(List<Object> list, String key);

  /// Deletes a concrete object from the `persisted list` that has been
  /// saved in the local storage through `persistList`.
  Future<void> deleteObject(Object object, String key);

  /// Retrieves the value that is stored into local storage through `key`.
  Object retrieveValueOf(String key);
}
