import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imageurl =
      'https://unsplash.com/photos/AnBzL_yOWBc/download?force=true&w=2400';
  //'https://unsplash.com/photos/1zTg4KT4EtE/download?force=true&w=2400';

  // Image Dimensions are 2400 x 3598

  Future<void> _setwallpaper(location) async {
    var file = await DefaultCacheManager().getSingleFile(imageurl);
    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wallpaper updated'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Setting Wallpaper'),
        ),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper Manager Example'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: imageurl,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, uri) => Center(
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _setwallpaper(WallpaperManagerFlutter.HOME_SCREEN);
                  },
                  child: Text('Home Screen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _setwallpaper(WallpaperManagerFlutter.LOCK_SCREEN);
                  },
                  child: Text('Lock Screen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _setwallpaper(WallpaperManagerFlutter.BOTH_SCREENS);
                  },
                  child: Text('Both Screens'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
