import 'package:easy_permission/src/permission_status.dart';
import 'package:easy_permission/src/permission_type.dart';

class Permissions {
  late PermissionType permissionType;
  late PermissionStatus status;
  Permissions({required this.permissionType, required this.status});
}