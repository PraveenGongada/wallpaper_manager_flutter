# wallpaper_manager_flutter

A Plugin to set Wallpaper of HomeScreen,LockScreen and Both Screen without lag even for large images.


## Installation

In the pubspec.yaml of your flutter project, add the following dependency:

```dart
dependencies:
  wallpaper_manager_flutter: ^0.0.2
```
In your dart file add the following import:

```dart
  import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
```
# Usage

## Set Wallpaper from cache file

You can use flutter_cache_manager package to access the cached image files,

In the pubspec.yaml of your flutter project, add the following dependency:

```dart
dependencies:
  flutter_cache_manager: ^3.1.2
```

In your dart file add the following import:

```dart
  import 'package:flutter_cache_manager/flutter_cache_manager.dart';
```

Now pass the image url to the cache manager and await cachedimage and then pass the cached image to the plugin.

Use this inside an async function.

```dart
String url = '';  // Image url 

String cachedimage = await DefaultCacheManager().getSingleFile(url);  //image file

int location = WallpaperManagerFlutter.HOME_SCREEN;  //Choose screen type

WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);   // Wrap with try catch for error management.
```

Check the Example file for Better Understanding.

## Set wallpaper from system file

Use this inside an async Function,

```dart
imagefile = /0/images/image.png,

location = WallpaperManagerFlutter.HOME_SCREEN  //Choose screen type

WallpaperManagerFlutter().setwallpaperwithFile(imagefile, location);
```

