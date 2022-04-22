import 'package:flutter/material.dart';

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
