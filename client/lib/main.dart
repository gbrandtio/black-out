import 'package:black_out_groutages/services/data_persist_service/outages_data_persist.dart';
import 'package:black_out_groutages/services/data_persist_service/data_persist_service_keys.dart';
import '../widgets/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OutagesApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

/// Root point of the application.
class OutagesApp extends StatelessWidget {
  const OutagesApp({Key? key}) : super(key: key);

  /// Application Root.
  ///
  /// * Sets all the default Theme values.
  /// * Sets the default font to use across the application.
  /// * Sets the default colors and titles to use in case no other colors defined.
  @override
  Widget build(BuildContext context) {
    initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Black Out',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.white),
      home: const Base(title: 'Black Out', key: Key("Black Out")),
    );
  }

  /// Initializes the preferences and removes the default outages & notifications
  /// from persistent storage.
  Future<void> initialize() async {
    await OutagesDataPersistService().initializePreferences();
    debugPrint("Deleting default prefecture outages persistent storage");
    OutagesDataPersistService()
        .delete(DataPersistServiceKeys.outagesOfDefaultPrefecture);
    OutagesDataPersistService()
        .delete(DataPersistServiceKeys.notificationOutages);
  }
}
