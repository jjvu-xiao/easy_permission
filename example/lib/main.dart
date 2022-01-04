
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_permission/easy_permission_api.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  runApp(MyApp());
}

Future<void> requestPermissions() async {
  if (Platform.isAndroid) {
    List<PermissionType> types = [];
    // 申请位置权限
    types.add(PermissionType.LOCATION);
    // 申请相机权限
    types.add(PermissionType.CAMERA);
    // 申请存储权限
    types.add(PermissionType.STORAGE);
    // 申请麦克风权限
    types.add(PermissionType.MICROPHONE);
    // 申请日历权限
    types.add(PermissionType.CALENDAR);
    await EasyPermission.requestPermissions(types);
  }
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
          child: Text('Running on: \n'),
        ),
      ),
    );
  }
}
