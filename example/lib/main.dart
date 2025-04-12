import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

void main() => runApp(const WallpaperExampleApp());

class WallpaperExampleApp extends StatelessWidget {
  const WallpaperExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Manager Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const WallpaperScreen(),
    );
  }
}

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  final PageController _pageController = PageController();
  final WallpaperManagerFlutter _wallpaperManager = WallpaperManagerFlutter();
  int _currentPage = 0;
  bool _isHomeLoading = false;
  bool _isLockLoading = false;
  bool _isBothLoading = false;

  final List<String> _wallpaperAssets = [
    'https://images.unsplash.com/photo-1540206395-68808572332f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHBob25lJTIwd2FsbHBhcGVyfGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1527515234283-d93c5f8486a0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGhvbmUlMjB3YWxscGFwZXJ8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1504681869696-d977211a5f4c?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHBob25lJTIwd2FsbHBhcGVyfGVufDB8fDB8fHww',
  ];

  Future<void> _setWallpaper(int location) async {
    // Update the loading state based on the button clicked
    if (location == WallpaperManagerFlutter.homeScreen) {
      setState(() => _isHomeLoading = true);
    } else if (location == WallpaperManagerFlutter.lockScreen) {
      setState(() => _isLockLoading = true);
    } else if (location == WallpaperManagerFlutter.bothScreens) {
      setState(() => _isBothLoading = true);
    }

    try {
      File file = await DefaultCacheManager().getSingleFile(
        _wallpaperAssets[_currentPage],
      );

      final success = await _wallpaperManager.setWallpaper(file, location);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Wallpaper set successfully!' : 'Failed to set wallpaper',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      // Reset the loading state for the appropriate button
      if (location == WallpaperManagerFlutter.homeScreen) {
        setState(() => _isHomeLoading = false);
      } else if (location == WallpaperManagerFlutter.lockScreen) {
        setState(() => _isLockLoading = false);
      } else if (location == WallpaperManagerFlutter.bothScreens) {
        setState(() => _isBothLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper Manager Demo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _wallpaperAssets.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: _currentPage == index ? 1 : 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: _wallpaperAssets[index],
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: Colors.cyan,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildPageIndicator(),
          _buildActionButtons(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_wallpaperAssets.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color:
                _currentPage == index
                    ? Colors.blue.shade700
                    : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _WallpaperButton(
            icon: Icons.home,
            label: 'Home',
            onPressed: () => _setWallpaper(WallpaperManagerFlutter.homeScreen),
            isLoading: _isHomeLoading,
          ),
          _WallpaperButton(
            icon: Icons.lock,
            label: 'Lock',
            onPressed: () => _setWallpaper(WallpaperManagerFlutter.lockScreen),
            isLoading: _isLockLoading,
          ),
          _WallpaperButton(
            icon: Icons.phone_android,
            label: 'Both',
            onPressed: () => _setWallpaper(WallpaperManagerFlutter.bothScreens),
            isLoading: _isBothLoading,
          ),
        ],
      ),
    );
  }
}

class _WallpaperButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  const _WallpaperButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width * 0.2,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade400],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child:
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 28, color: Colors.white),
                    const SizedBox(height: 5),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
