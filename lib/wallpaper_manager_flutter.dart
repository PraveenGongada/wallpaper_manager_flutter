import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class WallpaperManagerFlutter {
  // Defining Channel
  static const MethodChannel _channel = const MethodChannel('setwallpaper');

  // Function to check working of method channels
  static Future<String?> get platformVersion async {
    // String to store the version number
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    // return Version number
    return version;
  }

  static const int HOME_SCREEN = 1;
  // To Set wallpaper for HomeScreen.

  static const int LOCK_SCREEN = 2;
  // To Set wallpaper for Lock Screen.

  static const int BOTH_SCREENS = 3;
  // To Set wallpaper for Both Screens.

  // Function to set Wallpaper
  Future<void> setwallpaperfromFile(imagefile, location) async {
    Uint8List imagebyte;

    // Functon to convert image to bytes
    _readFileByte(imagefile.path).then(
      (bytesData) {
        imagebyte = bytesData;

        // Sending bytedata and location to Platform channel
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

  // Process of Converting image to bytes

  _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File imagefile = new File.fromUri(myUri);
    Uint8List? bytes;
    await imagefile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
    });

    // returns bytes.
    return bytes;
  }
}
