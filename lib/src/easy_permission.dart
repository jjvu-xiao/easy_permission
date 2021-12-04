import 'dart:async';

import 'permission_type.dart';
import 'permissions.dart';
import 'package:flutter/services.dart';

import 'permission_status.dart';

class EasyPermission {

  static const String CHANNEL_NAME = 'cn.jjvu.xiao/easy_permission';

  static const MethodChannel channel = const MethodChannel(CHANNEL_NAME);

  static Future<List<Permissions>> getPermissionsStatus(List<PermissionType> types) async {
    List<String> list = [];
    types.forEach((p) {
      list.add(p.name);
    });
    var status = await channel.invokeMethod("getPermissionsStatus", {"permissions": list});
    List<Permissions> permissionStatusList = [];
    for (int i = 0; i < status.length; i++) {
      PermissionStatus permissionStatus;
      switch (status[i]) {
        case 0:
          permissionStatus = PermissionStatus.ALLOW;
          break;
        case 1:
          permissionStatus = PermissionStatus.DENY;
          break;
        case 2:
          permissionStatus = PermissionStatus.NOT_DECIDED;
          break;
        case 3:
          permissionStatus = PermissionStatus.NOT_AGAIN;
          break;
        default:
          permissionStatus = PermissionStatus.NOT_DECIDED;
          break;
      }
      permissionStatusList.add(Permissions(status: permissionStatus, permissionType: types[i]));
    }
    return permissionStatusList;
  }

  static Future<PermissionStatus> getSinglePermissionStatus(PermissionType permissionName) async {
    var status = await channel.invokeMethod("getSinglePermissionStatus", {"permissionName": permissionName.name});
    switch (status) {
      case 0:
        return PermissionStatus.ALLOW;
      case 1:
        return PermissionStatus.DENY;
      case 2:
        return PermissionStatus.NOT_DECIDED;
      case 3:
        return PermissionStatus.NOT_AGAIN;
      case 4:
        return PermissionStatus.WHEN_IN_USE;
      case 5:
        return PermissionStatus.ALWAYS;
      default:
        return PermissionStatus.NOT_AGAIN;
    }
  }

  static Future<List<Permissions>> requestPermissions(List<PermissionType> permissionNameList) async {
    List<String> list = [];
    permissionNameList.forEach((p) {
      list.add(p.name);
    });
    var status = await channel.invokeMethod("requestPermissions", {"permissions": list});
    List<Permissions> permissionStatusList = [];
    for (int i = 0; i < status.length; i++) {
      PermissionStatus permissionStatus;
      switch (status[i]) {
        case 0:
          permissionStatus = PermissionStatus.ALLOW;
          break;
        case 1:
          permissionStatus = PermissionStatus.DENY;
          break;
        case 2:
          permissionStatus = PermissionStatus.NOT_DECIDED;
          break;
        case 3:
          permissionStatus = PermissionStatus.NOT_AGAIN;
          break;
        default:
          permissionStatus = PermissionStatus.NOT_DECIDED;
          break;
      }
      permissionStatusList.add(Permissions(permissionType: permissionNameList[i], status: permissionStatus));
    }
    return permissionStatusList;
  }

  static Future<PermissionStatus> requestSinglePermission(PermissionType permissionName) async {
    var status = await channel.invokeMethod("requestSinglePermission", {"permissionName": permissionName.name});
    switch (status) {
      case 0:
        return PermissionStatus.ALLOW;
      case 1:
        return PermissionStatus.DENY;
      case 2:
        return PermissionStatus.NOT_DECIDED;
      case 3:
        return PermissionStatus.NOT_AGAIN;
      case 4:
        return PermissionStatus.WHEN_IN_USE;
      case 5:
        return PermissionStatus.ALWAYS;
      default:
        return PermissionStatus.NOT_DECIDED;
    }
  }
  static Future<bool> openSettings() async {
    return await channel.invokeMethod("openSettings");
  }
}
