import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String label;

  const Loading({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png', fit: BoxFit.contain, height: 32),
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
