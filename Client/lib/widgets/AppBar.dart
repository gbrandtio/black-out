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
        title: const Text('Black Out', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
