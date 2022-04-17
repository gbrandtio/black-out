import 'package:black_out_groutages/widgets/Base.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true; // Smoother touch event in expense of some added latency.
  runApp(const OutagesApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Enabling full screen mode.
}

/// Root point of the application.
class OutagesApp extends StatelessWidget {
  const OutagesApp({Key? key}) : super(key: key);

  /// Application Root.
  ///
  /// * Sets all the default Theme values.
  /// * Sets the default font to use across the application.
  /// * Sets the default colors and titles to use in case no other colors defined.
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
      home: const Base(title: 'Black Out', key: Key("Black Out")),
    );
  }
}