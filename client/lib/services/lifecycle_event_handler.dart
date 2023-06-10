import 'package:flutter/cupertino.dart';

typedef FutureVoidCallback = Future<void> Function();

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler(
      {required this.resumeCallBack, required this.detachedCallBack});

  final FutureVoidCallback resumeCallBack;
  final FutureVoidCallback detachedCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await detachedCallBack();
        break;
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
  }
}
