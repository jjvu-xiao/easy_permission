#import "EasyPermissionPlugin.h"
#if __has_include(<easy_permission/easy_permission-Swift.h>)
#import <easy_permission/easy_permission-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "easy_permission-Swift.h"
#endif

@implementation EasyPermissionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEasyPermissionPlugin registerWithRegistrar:registrar];
}
@end
