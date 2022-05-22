import 'dart:ffi';

import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

/// Responsible for providing to the user the ability to change the default app settings.
/// Changes on settings are maintained on shared preferences, accessible from the rest of the application.
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DataPersistService dataPersistService = DataPersistService();
  bool notificationsEnabled = true;
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();

  /// Loads the already existing preferences of the user, otherwise sets the default values.
  Future<String?> _loadPreferences() async{
    String? notifsEnabled = "true";
    await dataPersistService.getString(DataPersistService.enableNotificationsPreference).then((value){
      setState(() {
        String? notifsEnabled = value;
        notificationsEnabled = notifsEnabled == 'true';
      });
    });
    return notifsEnabled;
  }

  /// Widget that holds all the application settings that a user can set.
  Widget settings(){
    return SettingsList(
      sections: ([
        /// Section for common settings preferences.
        SettingsSection(
          title: const Text('Common'),
          tiles: <SettingsTile>[
            /// Notification Settings.
            SettingsTile.switchTile(
              onToggle: (value) {
                setState(() {
                  notificationsEnabled = value;
                  dataPersistService.persist(DataPersistService.enableNotificationsPreference, notificationsEnabled.toString());
                });
              },
              initialValue: notificationsEnabled,
              leading: const Icon(Icons.notifications),
              title: const Text('Enable Notifications'),
            ),
          ],
        ),
        /// Section for Outages related preferences
        SettingsSection(
          title: const Text("Outages"),
            tiles: <SettingsTile>[
              /// Default Prefecture Settings.
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Default Prefecture'),
                value: Text(defaultPrefecture.name),
              ),
        ]),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadPreferences(),
        // ignore: curly_braces_in_flow_control_structures
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return settings();
          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }
}
