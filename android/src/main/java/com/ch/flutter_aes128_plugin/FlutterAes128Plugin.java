package com.ch.flutter_aes128_plugin;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.ch.flutter_aes128_plugin.AESCryptor;
/** FlutterAes128Plugin */
public class FlutterAes128Plugin implements FlutterPlugin, MethodCallHandler {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_aes128_plugin");
    channel.setMethodCallHandler(new FlutterAes128Plugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_aes128_plugin");
    channel.setMethodCallHandler(new FlutterAes128Plugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    if ("encrypt".equals(call.method)) {
      String key = call.argument("key");
      String target = call.argument("target");
      String decrypt = AESCryptor.encrypt(target,key);
      result.success(decrypt);

    } else if ("decrypt".equals(call.method)) {
      String key = call.argument("key");
      String target = call.argument("target");
      String decrypt = AESCryptor.decrypt(target,key);
      result.success(decrypt);
    } else {
      result.notImplemented();
    }
  }



  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
