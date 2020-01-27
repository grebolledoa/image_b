package com.example.image_b;

import org.bytedeco.javacpp.Loader;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** Image_bPlugin */
public class Image_bPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    Loader.load(org.bytedeco.javacpp.opencv_java.class);
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "image_b");
    channel.setMethodCallHandler(new Image_bPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "isImageBlurry":
        result.success(ImageBlur.isImageBlurry((String)call.argument("imagePath")));
        break;
      default:
        result.notImplemented();
    }
  }
}
