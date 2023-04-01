import '../widgets/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OutagesApp());
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky); // Enabling full screen mode.
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
      title: 'Black Out',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.white),
      home: const Base(title: 'Black Out', key: Key("Black Out")),
    );
  }
}
