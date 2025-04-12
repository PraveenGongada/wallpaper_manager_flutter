import 'wallpaper_manager_flutter_platform_interface.dart';

class WallpaperManagerFlutter {
  /// Constants for wallpaper locations.
  ///
  /// These constants represent the different locations where the wallpaper can be set:
  /// - [homeScreen]: Sets the wallpaper on the home screen.
  /// - [lockScreen]: Sets the wallpaper on the lock screen.
  /// - [bothScreens]: Sets the wallpaper on both the home and lock screens.
  static const int homeScreen = 1;
  static const int lockScreen = 2;
  static const int bothScreens = 3;

  /// Sets the wallpaper on a specific screen.
  ///
  /// This method allows you to set the wallpaper either on the home screen, lock screen, or both.
  /// It ensures that the location provided is valid and then attempts to set the wallpaper.
  ///
  /// [imageFile] is the image file that will be set as the wallpaper.
  /// [location] indicates where the wallpaper should be set. It can be one of:
  /// - [homeScreen] (1)
  /// - [lockScreen] (2)
  /// - [bothScreens] (3)
  ///
  /// Throws an [ArgumentError] if the [location] is not one of the valid values.
  /// Returns a [Future<String?>] that resolves to a status message or an error message.
  Future<bool> setWallpaper(dynamic imageFile, int location) async {
    // Check if the location is valid
    if (location != homeScreen &&
        location != lockScreen &&
        location != bothScreens) {
      throw ArgumentError('Invalid location value provided: $location');
    }

    try {
      // Attempt to set the wallpaper using the WallpaperManagerFlutterPlatform
      return await WallpaperManagerFlutterPlatform.instance.setWallpaper(
        imageFile,
        location,
      );
    } catch (e) {
      // Re-throw any error that occurs during wallpaper setting
      rethrow;
    }
  }
}
