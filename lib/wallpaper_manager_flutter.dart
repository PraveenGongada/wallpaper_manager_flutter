import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class WallpaperManagerFlutter {
  static const MethodChannel _channel = const MethodChannel('setwallpaper');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static const int HOME_SCREEN = 1;

  static const int LOCK_SCREEN = 2;

  static const int BOTH_SCREENS = 3;

  _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File imagefile = new File.fromUri(myUri);
    Uint8List? bytes;
    await imagefile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
    });
    return bytes;
  }

  Future<void> setwallpaperwithFile(imagefile, location) async {
    Uint8List imagebyte;
    _readFileByte(imagefile.path).then(
      (bytesData) {
        imagebyte = bytesData;
        _channel.invokeMethod(
          'setWallpaper',
          {
            'data': imagebyte,
            'location': location,
          },
        );
      },
    );
  }
}
