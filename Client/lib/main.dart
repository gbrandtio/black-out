import 'package:black_out_groutages/widgets/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Application Root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Outages',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto'
      ),
      home: Home(title: 'Black Out', key: const Key("Black Out")),
    );
  }
}