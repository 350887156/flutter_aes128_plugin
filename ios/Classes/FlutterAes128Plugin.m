#import "FlutterAes128Plugin.h"
#import "GTMBase64+Extension.h"

@implementation FlutterAes128Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_aes128_plugin"
            binaryMessenger:[registrar messenger]];
  FlutterAes128Plugin* instance = [[FlutterAes128Plugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"encrypt" isEqualToString:call.method]) {
      NSString *key = call.arguments[@"key"];
      NSString *target = call.arguments[@"target"];
      if ([target isKindOfClass:[NSString class]] && target.length && [key isKindOfClass:[NSString class]] && key.length) {
          result([GTMBase64 encryptWithText:target forKey:key]);
      }
  } else if ([@"decrypt" isEqualToString:call.method]) {
      NSString *key = call.arguments[@"key"];
      NSString *target = call.arguments[@"target"];
      if ([target isKindOfClass:[NSString class]] && target.length && [key isKindOfClass:[NSString class]] && key.length) {
          result([GTMBase64 decryptWithText:target forKey:key]);
      }
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
