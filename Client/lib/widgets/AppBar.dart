import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const BaseAppBar({Key? key, required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: const Text('Black Out', style: TextStyle(
            color: Colors.black
        )),
        backgroundColor: Colors.white
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}