
// 权限类型
enum PermissionType {
  INTERNET,
  CALENDAR,
  CAMERA,
  CONTACTS,
  MICROPHONE,
  LOCATION,
  WHEN_IN_USE,
  PHONE,
  SENSORS,
  SMS,
  STORAGE,
  STATE,
}
extension PermissionTypeExtension on PermissionType {
  String get name {
    switch (this) {
      case PermissionType.INTERNET:
        return 'INTERNET';
      case PermissionType.CALENDAR:
        return 'CALENDAR';
      case PermissionType.CAMERA:
        return 'CAMERA';
      case PermissionType.CONTACTS:
        return 'CONTACTS';
      case PermissionType.MICROPHONE:
        return 'MICROPHONE';
      case PermissionType.LOCATION:
        return 'LOCATION';
      case PermissionType.WHEN_IN_USE:
        return 'WHEN_IN_USE';
      case PermissionType.PHONE:
        return 'PHONE';
      case PermissionType.SENSORS:
        return 'SENSORS';
      case PermissionType.SMS:
        return 'SMS';
      case PermissionType.STORAGE:
        return 'STORAGE';
      case PermissionType.STATE:
        return 'STATE';
      default:
        return '';
    }
  }
}