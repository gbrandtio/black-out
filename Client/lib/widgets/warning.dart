import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  final String label;

  const Warning({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.warning, color: Color(0XFFB00020)),
        Text(
          label,
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 15),
        )
      ],
    );
  }
}
