
enum PermissionStatus {
  ALLOW,
  DENY,
  NOT_DECIDED,
  NOT_AGAIN,
  WHEN_IN_USE,
  ALWAYS,
}

extension PermissionStatusExtension on PermissionStatus {
  String get name {
    switch (this) {
      case PermissionStatus.ALLOW:
        return 'ALLOW';
      case PermissionStatus.DENY:
        return 'DENY';
      case PermissionStatus.NOT_DECIDED:
        return 'NOT_DECIDED';
      case PermissionStatus.NOT_AGAIN:
        return 'NOT_AGAIN';
      case PermissionStatus.WHEN_IN_USE:
        return 'WHEN_IN_USE';
      case PermissionStatus.ALWAYS:
        return 'ALWAYS';
      default:
        return '';
    }
  }
}