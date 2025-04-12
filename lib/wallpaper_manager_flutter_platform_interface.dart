import 'dart:io';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'wallpaper_manager_flutter_method_channel.dart';

/// An abstract class that defines the platform interface for interacting with wallpaper settings.
abstract class WallpaperManagerFlutterPlatform extends PlatformInterface {
  /// Constructs a [WallpaperManagerFlutterPlatform].
  ///
  /// The constructor ensures that the platform-specific implementation is set
  /// and allows the plugin to interact with platform-specific code via method channels.
  WallpaperManagerFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WallpaperManagerFlutterPlatform _instance =
      MethodChannelWallpaperManagerFlutter();

  /// The default instance of [WallpaperManagerFlutterPlatform] to use.
  ///
  /// This is the default platform implementation used by the plugin. By default, it is set to [MethodChannelWallpaperManagerFlutter].
  ///
  /// Use this to access the platform-specific code and invoke methods like `setWallpaper`.
  ///
  /// Example usage:
  /// ```dart
  /// bool result = await WallpaperManagerFlutterPlatform.instance.setWallpaper(imageFile, location);
  /// ```
  static WallpaperManagerFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WallpaperManagerFlutterPlatform] when
  /// they register themselves.
  ///
  /// This method allows users to set a custom platform-specific implementation (e.g., for Android, iOS).
  /// Example:
  /// ```dart
  /// WallpaperManagerFlutterPlatform.instance = CustomWallpaperManagerFlutter();
  /// ```
  static set instance(WallpaperManagerFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Sets the wallpaper from an image file at a specified location.
  ///
  /// This is an abstract method that must be implemented in platform-specific code.
  /// It takes in an image file and the desired location (home screen, lock screen, or both),
  /// and sets the wallpaper accordingly on the platform (Android/iOS).
  ///
  /// [image] is the image file to be set as the wallpaper.
  /// [location] specifies where to set the wallpaper. Valid values are:
  /// - `0`: Home screen
  /// - `1`: Lock screen
  /// - `2`: Both screens
  ///
  /// Returns a [Future<bool>] indicating whether the wallpaper was successfully set.
  ///
  /// Example usage:
  /// ```dart
  /// bool result = await WallpaperManagerFlutterPlatform.instance.setWallpaper(imageFile, 0); // Sets home screen wallpaper
  /// if (result) {
  ///   print("Wallpaper set successfully!");
  /// } else {
  ///   print("Failed to set wallpaper.");
  /// }
  /// ```
  Future<bool> setWallpaper(File image, int location) {
    throw UnimplementedError('setWallpaper() has not been implemented.');
  }
}
