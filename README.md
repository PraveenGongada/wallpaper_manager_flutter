# Wallpaper Manager Flutter 🖼️

A powerful Flutter plugin that enables you to programmatically set wallpapers. This plugin maintains smooth performance even with high-resolution wallpapers. Easily customize home screen, lock screen, or both screens with just a few lines of code!

[![Pub Version](https://img.shields.io/pub/v/wallpaper_manager_flutter)](https://pub.dev/packages/wallpaper_manager_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features ✨

- Set wallpapers on home screen, lock screen, or both 🏠
- Efficient image processing using isolates to prevent UI blocking 🚀
- Handles large image files without lag or freezing 💪
- Comprehensive error handling and validation ✅
- Simple and intuitive API 🎯

## Demo 📱

<div align="center">
  <div style="position: relative; width: 80%; max-width: 800px; background-color: #1a1a1a; border-radius: 8px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); margin: 20px auto;">
    <!-- Content area with 16:9 aspect ratio -->
    <div style="position: relative; width: 100%; padding-top: 56.25%; background-color: #000; border-radius: 3px; overflow: hidden;">
      <!-- Mobile app centered in the screen -->
      <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; display: flex; justify-content: center; align-items: center;">
        <img src="https://raw.githubusercontent.com/PraveenGongada/wallpaper_manager_flutter/refs/heads/main/docs/demo.gif" alt="Wallpaper Manager Demo" style="height: 90%; max-height: 90%; object-fit: contain;">
      </div>
    </div>
  </div>
</div>

_A simple demonstration of setting wallpapers without any lag or freezing_

## Installation 📦

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  wallpaper_manager_flutter: ^latest_version
```

## Usage 💻

First, import the package:

```dart
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
```

### Setting Wallpaper

You can set wallpapers for different screens using the following constants:

```dart
// Create instance
final wallpaperManager = WallpaperManagerFlutter();

// Available options for wallpaper location: homeScreen, lockScreen & bothScreens

// Example: Set wallpaper on home screen
try {
  File imageFile = File('path_to_your_image.jpg');
  bool result = await wallpaperManager.setWallpaper(
    imageFile,
    WallpaperManagerFlutter.homeScreen,
  );

  if (result) {
    print('Wallpaper set successfully! 🎉');
  }
} catch (e) {
  print('Error setting wallpaper: $e ❌');
}
```

## Error Handling 🛡️

The plugin includes comprehensive error handling. Here are some common errors you might encounter:

- File does not exist
- Invalid location value
- Platform-specific errors

Always wrap the `setWallpaper` call in a try-catch block to handle potential errors gracefully.

## Platform Support 📱

| Platform | Support | Notes                                                       |
| -------- | ------- | ----------------------------------------------------------- |
| Android  | ✅      | Full support for home screen, lock screen, and both screens |
| iOS      | ❌      | Not supported due to iOS system security restrictions.      |

> **Note:** Requires Android 7.0 (API level 24) or higher.

## Contributing 🤝

Contributions are welcome! If you have a bug fix or new feature, please create a pull request. For major changes, please open an issue first to discuss what you would like to change.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support ❤️

If you find this plugin helpful, please give it a star ⭐ on GitHub and consider following me for more useful Flutter plugins!

For any issues, feature requests, or questions, please [create an issue](https://github.com/PraveenGongada/wallpaper_manager_flutter/issues) on GitHub.
