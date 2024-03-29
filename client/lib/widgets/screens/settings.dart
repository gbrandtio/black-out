import 'package:black_out_groutages/models/prefecture_dto.dart';
import 'package:black_out_groutages/services/data_persist_service/outages_data_persist.dart';
import 'package:black_out_groutages/widgets/dialogs/saved_outages_dialog.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../services/data_persist_service/data_persist_service_keys.dart';
import '../../services/data_persist_service/prefectures_data_persist.dart';
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
  PrefecturesDataPersistService prefecturesDataPersistService =
      PrefecturesDataPersistService();
  OutagesDataPersistService outagesDataPersistService =
      OutagesDataPersistService();
  bool areNotificationsEnabled = false;
  PrefectureDto defaultPrefecture = PrefectureDto.defaultPrefecture();

  /// Loads the already existing preferences of the user, otherwise sets the default values.
  Future<bool> _loadPreferences() async {
    setState(() {
      String? notificationsEnabled = prefecturesDataPersistService
          .getString(DataPersistServiceKeys.enableNotificationsPreference);
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
                  prefecturesDataPersistService.persist(
                      DataPersistServiceKeys.enableNotificationsPreference,
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
            value: Text("ΝΟΜΟΣ ${defaultPrefecture.name}"),
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SelectPrefectureDialog(
                        onDefaultPrefectureChanged: (value) {
                      // Persist the selected default prefecture preference.
                      prefecturesDataPersistService.persistObject(value,
                          DataPersistServiceKeys.defaultPrefecturePreference);
                      // Delete the persisted outages since there is a new default prefecture.
                      outagesDataPersistService.delete(
                          DataPersistServiceKeys.outagesOfDefaultPrefecture);

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
            value: Text(outagesDataPersistService
                .retrieveValueOf(DataPersistServiceKeys.savedOutagesPersistKey)
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
