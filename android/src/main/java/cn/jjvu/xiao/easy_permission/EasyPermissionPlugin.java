package cn.jjvu.xiao.easy_permission;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.Settings;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/** EasyPermissionPlugin */
public class EasyPermissionPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.RequestPermissionsResultListener {

  private MethodChannel channel;
  
  private Activity activity;
  
  private Result result;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "cn.jjvu.xiao/easy_permission");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    List<String> permissions;
    switch (call.method) {
      case "getPermissionsStatus":
        permissions = call.argument("permissions");
        result.success(get(permissions));
        break;
      case "requestPermissions":
        permissions = call.argument("permissions");
        this.result = result;
        requests(permissions);
        break;
      case "openSettings":
        openSettings();
        result.success(true);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private List<Integer> get(List<String> permissions) {
    List<Integer> intList = new ArrayList<>();
    for (String permission : permissions) {
      permission = getManifestPermission(permission);
      if (ContextCompat.checkSelfPermission(this.activity, permission) == PackageManager.PERMISSION_DENIED) {
        if (!ActivityCompat.shouldShowRequestPermissionRationale(activity, permission)) {
          intList.add(3);
        } else {
          intList.add(1);
        }
      } else {
        intList.add(0);
      }
    }
    return intList;
  }

  private void requests(List<String> permissionList) {
    String[] permissions = new String[permissionList.size()];
    for (int i = 0; i < permissionList.size(); i++) {
      permissions[i] = getManifestPermission(permissionList.get(i));
    }
    ActivityCompat.requestPermissions(activity, permissions, 0);
  }

  private void openSettings() {
    Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + activity.getPackageName()));
    intent.addCategory(Intent.CATEGORY_DEFAULT);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    activity.startActivity(intent);
  }

  private String getManifestPermission(String permission) {
    String result;
    switch (permission) {
      case "CALENDAR":
        result = Manifest.permission.READ_CALENDAR;
        break;
      case "CAMERA":
        result = Manifest.permission.CAMERA;
        break;
      case "CONTACTS":
        result = Manifest.permission.READ_CONTACTS;
        break;
      case "LOCATION":
        result = Manifest.permission.ACCESS_FINE_LOCATION;
        break;
      case "MICROPHONE":
        result = Manifest.permission.RECORD_AUDIO;
        break;
      case "PHONE":
        result = Manifest.permission.CALL_PHONE;
        break;
      case "SENSORS":
        result = Manifest.permission.BODY_SENSORS;
        break;
      case "SMS":
        result = Manifest.permission.READ_SMS;
        break;
      case "STORAGE":
        result = Manifest.permission.WRITE_EXTERNAL_STORAGE;
        break;
      case "STATE":
        result = Manifest.permission.READ_PHONE_STATE;
        break;
      default:
        result = "ERROR";
        break;
    }
    return result;
  }

  @Override
  public boolean onRequestPermissionsResult(int requestCode, String[] strings, int[] ints) {
    if (requestCode == 0 && ints.length > 0) {
      List<Integer> intList = new ArrayList<>();
      for (int i = 0; i < ints.length; i++) {
        if (ints[i] == PackageManager.PERMISSION_DENIED) {
          if (!ActivityCompat.shouldShowRequestPermissionRationale(this.activity, strings[i])) {
            intList.add(3);
          }
          else {
            intList.add(1);
          }
        }
        else {
          intList.add(0);
        }
      }
      result.success(intList);
    }
    return true;
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    binding.addRequestPermissionsResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {
  }
}
