import 'package:flutter/material.dart';

/// Implements the default AppBar that will be shared across the application.
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  /// Default constructor.
  const BaseAppBar({Key? key, required this.appBar}) : super(key: key);

  /// Builds the top AppBar of the application.
  ///
  /// * Sets the default Theme values.
  /// * Sets the default background color.
  /// * Sets the default icon theme.
  /// * Sets the default title.
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            const Text('Black Out', style: TextStyle(color: Colors.black)),
          ],
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return AboutDialog(
                          applicationName: "Black Out",
                          applicationIcon: Image.asset('assets/logo.png',
                              fit: BoxFit.contain, height: 32),
                          applicationVersion: "1.0.0",
                          applicationLegalese:
                              "Black Out is an open source application licensed under the MIT License."
                              "The main purpose of this application is to provide an easy way for the citizens of Greece to:"
                              "\n\n - View / Save / Share all the planned electricity outages reported by the government."
                              "\n - Set alarms for an upcoming electricity outage."
                              "\n - Receive notifications about upcoming electricity outage."
                              "\n\n Source code: https://github.com/gbrandtio/black-out"
                              "\n\n Known issues: https://github.com/gbrandtio/black-out/issues",
                        );
                      });
                },
                child: const Icon(
                  Icons.info_outline,
                  size: 26.0,
                  color: Colors.black,
                ),
              ))
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
