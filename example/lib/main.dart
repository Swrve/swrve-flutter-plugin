import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:swrve_plugin/swrve_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _pluginVersion = 'Unknown';
  SwrvePlugin _swrve = new SwrvePlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String pluginVersion = "0.1.0";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _swrve.userUpdate({"plugin_version": pluginVersion});
    } on PlatformException {
      pluginVersion = 'Failed to set plugin version.';
    }
    _swrve.event("signup.open");

    Future.delayed(Duration(seconds:3), ()=> _swrve.event("details", payload: {"delay": "3.0"}));
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _pluginVersion = pluginVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_pluginVersion\n'),
        ),
      ),
    );
  }
}
