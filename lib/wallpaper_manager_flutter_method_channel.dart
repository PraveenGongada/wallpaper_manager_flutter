import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'wallpaper_manager_flutter_platform_interface.dart';

/// An implementation of [WallpaperManagerFlutterPlatform] that uses method channels.
class MethodChannelWallpaperManagerFlutter
    extends WallpaperManagerFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wallpaper_manager_flutter');

  /// Sets the wallpaper from an image file at a specified location.
  ///
  /// This method converts the given image file to bytes and sends it via a platform channel to set it as the wallpaper.
  ///
  /// [imageFile] is the image file that will be converted to bytes and used as the wallpaper.
  /// [location] specifies the location where the wallpaper should be set. It can be:
  /// - home screen
  /// - lock screen
  /// - both screens
  @override
  Future<bool> setWallpaper(File imageFile, int location) async {
    try {
      if (!await imageFile.exists()) {
        throw Exception("Image file does not exist: ${imageFile.path}");
      }

      // Read image bytes in an isolate to prevent blocking the UI thread
      Uint8List imageBytes = await _readFileBytesInIsolate(imageFile.path);

      // Send byte data and location to platform channel to set wallpaper
      return await methodChannel.invokeMethod('setWallpaper', {
        'imageBytes': imageBytes,
        'location': location,
      });
    } catch (e) {
      // Catch any errors during the process and return a failure
      if (e is FileSystemException) {
        throw Exception("Failed to read the image file: ${e.message}");
      } else if (e is PlatformException) {
        throw Exception("Failed to set wallpaper: ${e.message}");
      } else {
        throw Exception("An unexpected error occurred: $e");
      }
    }
  }

  /// Reads the image file bytes using an isolate to prevent blocking the main thread.
  ///
  /// This function reads the image from the provided file path and converts it to bytes,
  /// which can be used for setting the wallpaper.
  ///
  /// [filePath] is the path to the image file that needs to be converted to bytes.
  /// Returns a [Future<Uint8List>] which is the byte data of the image.
  Future<Uint8List> _readFileBytesInIsolate(String filePath) async {
    final response = ReceivePort();
    await Isolate.spawn(_readFileBytes, [response.sendPort, filePath]);
    return await response.first;
  }

  /// Isolate function to read file bytes
  static void _readFileBytes(List<dynamic> args) {
    SendPort sendPort = args[0];
    String filePath = args[1];
    try {
      File imageFile = File(filePath);
      Uint8List bytes = imageFile.readAsBytesSync();
      sendPort.send(bytes);
    } catch (e) {
      sendPort.send(Uint8List(0));
    }
  }
}
