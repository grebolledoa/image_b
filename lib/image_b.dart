import 'dart:async';

import 'package:flutter/services.dart';

class Image_b {
  static const MethodChannel _channel =
      const MethodChannel('image_b');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> isImageBlurry(String path) async {
    final int resultado = await _channel.invokeMethod("isImageBlurry", {"filePath": path});
    if(resultado == 1){
      return true; 
    }else if(resultado == -1){
      throw("No se ha encontrado la imagen");
    } else {
      return false;
    }
  }
}
