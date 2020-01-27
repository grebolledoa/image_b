#import "OpenCVWrapper.h"
#import "Image_bPlugin.h"



@implementation Image_bPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"image_b"
            binaryMessenger:[registrar messenger]];
  Image_bPlugin* instance = [[Image_bPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    //result([@"Hola iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
      result([OpenCVWrapper getVersionString]);
  } else if ([@"isImageBlurry" isEqualToString:call.method]) {
      NSString * path = call.arguments[@"filePath"];
      result([OpenCVWrapper isImageBlurry: path]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
