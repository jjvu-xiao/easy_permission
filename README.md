[English](README_ENG.md) 
# easy_permission

Flutter 权限插件

## 描述

可以快捷简单地用于 Flutter 权限申请，告别繁琐的轻量级权限申请。如果能搭配 permission_handler使用，事半功倍。

## 效果如下
![效果图](https://github.com/jjva-xiao/easy_permission/blob/main/doc/img/screen.jpeg)

## 代码使用

```dart
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
```

## 对应的权限

```dart
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
```

## 注意事项

### Android
Android的权限分为 静态权限与动态权限，该插件只能用于动态权限，需要在 AndroidManifest.xml文件中先进行静态权限申请

```xml
  <uses-permission android:name="android.permission.INTERNET" />
    <!--允许程序设置内置sd卡的读写权限-->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <!--允许程序获取网络状态-->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <!--允许程序访问WiFi网络信息-->
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <!--允许程序读写手机状态和身份-->
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <!--允许程序访问CellID或WiFi热点来获取粗略的位置-->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <!--允许程序打开相机-->
    <uses-permission android:name="android.permission.CAMERA" />
    <!--允许程序打开本地相册-->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <!--用于访问GPS定位-->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <!--这个权限用于获取wifi的获取权限，wifi信息会用来进行网络定位-->
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE"/>
    <!--用于申请调用A-GPS模块-->
    <uses-permission android:name="android.permission.ACCESS_LOCATION_EXTRA_COMMANDS"/>
```

### iOS

在iOS目录下Runner目录下的 info.plist文中加入以下配置,权限申请必须说明"因为 xxx功能所以需要xxx权限"，不能写 "需要拍照所以申请拍照权限"这种描述，会被 Appstore 因为“元数据问题”而拒绝上架 

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    ......
	<key>NSAppleMusicUsageDescription</key>
	<string>需要您提供多媒体访问权限</string>
	<key>NSCalendarsUsageDescription</key>
	<string>需要您提供日历信息，上传时间</string>
	<key>NSCameraUsageDescription</key>
	<string>需要您提供相机权限，才能拍照记录信息</string>
	<key>NSContactsUsageDescription</key>
	<string>需要您提供联系人，才能跟同事沟通</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>需要您提供定位信息，才能使用定位记录您的正确工作轨迹</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>需要您提供后台定位信息，才能使用巡检记录您的正确工作轨迹</string>
	<key>NSLocationUsageDescription</key>
	<string>需要您提供定位信息，才能使用巡检记录您的正确工作轨迹</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>需要您提供定位信息，才能使用巡检记录您的正确工作轨迹</string>
	<key>NSMotionUsageDescription</key>
	<string>需要您提供轨迹,才能使用巡检功能</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>需要您提供相册访问权限，才能选择相册上传图片</string>
	<key>NSSpeechRecognitionUsageDescription</key>
	<string>需要您提供语音监听，才能使用功能</string>
</dict>
```

## 使用场景
推荐在main方法中 用该插件先动态申请 一些必要的 权限，比如网络、定位等。


## 注意事项
该插件申请权限 前 请先使用 Platform.isAndroid来判断，iOS权限没有动态申请，只需要 在 info.plist 静态声明即可