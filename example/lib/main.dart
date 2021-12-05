
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_permission/easy_permission_api.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await requestPermissions();
  runApp(MyApp());
}

Future<void> requestPermissions() async {
  List<PermissionType> types = [];
  types.add(PermissionType.LOCATION);
  types.add(PermissionType.CAMERA);
  types.add(PermissionType.STORAGE);
  types.add(PermissionType.MICROPHONE);
  types.add(PermissionType.CALENDAR);
  await EasyPermission.requestPermissions(types);
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Running on: \n'),
            onPressed: () {
              EasyPermission.openSettings();
            },
          ),
        ),
      ),
    );
  }
}
