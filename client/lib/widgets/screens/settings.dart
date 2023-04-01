import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist.dart';
import 'package:black_out_groutages/widgets/dialogs/saved_outages_dialog.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import '../dialogs/select_prefecture.dart';

/// ----------------------------------------------------------------------------
/// settings.dart
/// ----------------------------------------------------------------------------
/// Responsible for providing to the user the ability to change the default app settings.
/// Changes on settings are maintained on shared preferences, accessible from the rest of the application.
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DataPersistService dataPersistService = DataPersistService();
  bool areNotificationsEnabled = false;
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();

  /// Loads the already existing preferences of the user, otherwise sets the default values.
  Future<bool> _loadPreferences() async {
    setState(() {
      String? notificationsEnabled = dataPersistService
          .getString(DataPersistService.enableNotificationsPreference);
      areNotificationsEnabled = notificationsEnabled?.toLowerCase() == 'true';
    });

    return areNotificationsEnabled;
  }

  /// Widget that holds all the application settings that a user can set.
  Widget settings() {
    return SettingsList(
      sections: ([
        /// COMMON SETTINGS
        SettingsSection(
          title: const Text('Common'),
          tiles: <SettingsTile>[
            /// Notification Settings.
            SettingsTile.switchTile(
              initialValue: areNotificationsEnabled,
              onToggle: (value) {
                setState(() {
                  areNotificationsEnabled = value;
                  // Persist the preference of notifications.
                  dataPersistService.persist(
                      DataPersistService.enableNotificationsPreference,
                      areNotificationsEnabled.toString());
                });
              },
              leading: const Icon(Icons.notifications),
              title: const Text('Enable Notifications'),
            ),
          ],
        ),

        /// OUTAGE PREFERENCES
        SettingsSection(title: const Text("Outages"), tiles: <SettingsTile>[
          /// Default Prefecture Settings.
          SettingsTile.navigation(
            leading: const Icon(Icons.language),
            title: const Text('Default Prefecture'),
            value: Text(defaultPrefecture.name),
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SelectPrefectureDialog(
                        onDefaultPrefectureChanged: (value) {
                      // Persist the selected default prefecture preference.
                      dataPersistService.persistPrefecture(
                          DataPersistService.defaultPrefecturePreference,
                          value);

                      setState(() {
                        defaultPrefecture = value;
                      });
                    });
                  });
            },
          ),
          SettingsTile.navigation(
            leading: const Icon(Icons.save),
            title: const Text('Saved Outages'),
            value: Text(dataPersistService
                .getSavedOutages(DataPersistService.savedOutagesPersistKey)
                .length
                .toString()),
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const SavedOutagesDialog();
                  });
            },
          ),
        ]),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return settings();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
