# wallpaper_manager_flutter

A Plugin to set Wallpaper of HomeScreen,LockScreen and Both Screen without lag even for large images.


## Installation

In the pubspec.yaml of your flutter project, add the following dependency:

dependencies:
  wallpaper_manager_flutter: ^0.0.1

In your library add the following import:

  import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

# Usage

## Set wallpaper from system file

Use this inside an async Function,

```dart
imagefile = /o/users/image,
location = WallpaperManagerFlutter.HOME_SCREEN  //Choose screen type
var result = await WallpaperManagerFlutter().setwallpaperwithFile(imagefile, location);
```

## Set Wallpaper from cache file

You can use flutter_cache_manager package to access the cache image files,

In the pubspec.yaml of your flutter project, add the following dependency:

```dart
dependencies:
  flutter_cache_manager: ^3.1.2
```

In your library add the following import:

```dart
  import 'package:flutter_cache_manager/flutter_cache_manager.dart';
```

```dart
var cachedimage = await DefaultCacheManager().getSingleFile(url);

location = WallpaperManagerFlutter.HOME_SCREEN  //Choose screen type

var result = await WallpaperManagerFlutter().setwallpaperwithFile(cachedimage, location);
```

