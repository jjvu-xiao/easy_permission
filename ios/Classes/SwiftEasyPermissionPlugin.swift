import Flutter
import UIKit

public class SwiftEasyPermissionPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "cn.jjvu.xiao/easy_permission", binaryMessenger: registrar.messenger())
        let instance = SwiftEasyPermissionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "openSettings":
//            self.openSettings()
//            if let url = URL(string: UIApplication.openSettingsURLString) {
            if let url = URL(string: "App-Prefs:root=General&path=About") {
             if (UIApplication.shared.canOpenURL(url)) {
                 if #available(iOS 10.0, *) {
                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                 }
                 result(nil)
             }
            }
            break
        default:
            result("not implementation")
        }
    }
  
    public func openSettings() {
        
        
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
           UIApplication.shared.openURL(url)
        }
        
        //        if let url = URL(strg: UIApplication.openSettingsURLString){
//         if (UIApplication.shared.canOpenURL(url)){
//          UIApplication.shared.openURL(url)
//         }
//        }
//        UIApplication.openSettingsURLString
//        UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
//        UIApplication.sharedApplication().openURL(NSURL(string: "prefs:root=LOCATION_SERVICES")!)
           
    }
    
    public func requests(permissionList: [String]) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings {
                settings in
                //是否允许通知
                switch settings.authorizationStatus {
                case .authorized:
                    //允许
                    break
                case .notDetermined:
                    //未确定
                    break
                case .denied:
                    //不允许
                    self.alert_noNetwrok("你的通知权限未打开,请到设置中打开通知权限","提示")
                    break
                }
                
                //声音
                switch settings.soundSetting{
                case .enabled:
                    //开启
                    break
                case .disabled:
                    //关闭
                    break
                case .notSupported:
                    //不支持
                    //self.alert_noNetwrok("请开启您的声音","提示")
                    break
                }
                
                //应用图标标记
                switch settings.badgeSetting{
                case .enabled:
                    //开启
                    break
                case .disabled:
                    //关闭
                    break
                case .notSupported:
                    //不支持
                    //self.alert_noNetwrok("请允许图标标记","提示")
                    break
                }
                
                //在锁定屏幕上显示
                switch settings.lockScreenSetting{
                case .enabled:
                    //开启
                    break
                case .disabled:
                    //关闭
                    break
                case .notSupported:
                    //不支持
                    //self.alert_noNetwrok("请允许应用在锁屏时显示信息","提示")
                    break
                }
                
                //在历史记录中显示
                switch settings.notificationCenterSetting{
                case .enabled:
                    //开启
                    break
                case .disabled:
                    //关闭
                    break
                case .notSupported:
                    //不支持
                    break
                }
                
                //横幅显示
                switch settings.alertSetting{
                case .enabled:
                    //开启
                    break
                case .disabled:
                    //关闭
                    break
                case .notSupported:
                    //不支持
                    break
                }
                
                //显示预览
                if #available(iOS 11.0, *) {
                    switch settings.showPreviewsSetting{
                    case .always:
                        //始终（默认
                        break
                    case .whenAuthenticated:
                        //解锁时
                        break
                    case .never:
                        //从不
                        break
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        } else {
            // Fallback on earlier versions
        }

               //定位权限检测,申请
               if CLLocationManager.authorizationStatus() != .denied{
                   print("拥有定位权限")
               }else{
                   self.alert_noNetwrok("请开启您的定位权限", "提示")
               }

    }
  
}
