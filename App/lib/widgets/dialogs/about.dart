import 'package:flutter/material.dart';

/// ----------------------------------------------------------------------------
/// about.dart
/// ----------------------------------------------------------------------------
/// A re-usable dialog to display information about the application
class AboutDialog extends StatelessWidget {
  final String title;
  final String content;

  const AboutDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      content: Text(
        content,
      ),
    );
  }
}
