package com.praveen.wallpaper_manager_flutter

import android.annotation.TargetApi
import android.app.WallpaperManager
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

/**
 * MainActivity that configures the Flutter plugin and sets up the method channel for wallpaper operations.
 */
class MainActivity : FlutterActivity() {
    private val channel = "wallpaper_manager_flutter" // The method channel name for wallpaper operations

    /**
     * Configures the Flutter engine and registers the WallpaperManagerFlutterPlugin.
     */
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        val plugin = WallpaperManagerFlutterPlugin()
        val registry = flutterEngine.plugins
        registry.add(plugin)
        super.configureFlutterEngine(flutterEngine)

        // Set up the method channel for communication between Flutter and native code
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            plugin.onMethodCall(call, result) // Delegate method calls to the plugin
        }
    }
}

/**
 * Plugin to handle wallpaper-related operations for the Flutter app.
 */
class WallpaperManagerFlutterPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var context: Context

    /**
     * Initializes the plugin by attaching it to the Flutter engine and setting up the method channel.
     */
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        val methodChannel = MethodChannel(binding.binaryMessenger, "wallpaper_manager_flutter")
        methodChannel.setMethodCallHandler(this) // Set the method call handler
    }

    /**
     * Detaches the plugin from the engine. Cleanup can be done here if necessary.
     */
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        // No cleanup needed for now
    }

    /**
     * Handles method calls from Flutter. Specifically, it supports setting the wallpaper.
     *
     * @param call The method call sent from Flutter.
     * @param result The result object used to send back a response to Flutter.
     */
    @TargetApi(Build.VERSION_CODES.N)
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            // Handle the setWallpaper method call
            "setWallpaper" -> {
                try {
                    // Extract the byte array and location from the method arguments
                    val wallpaperData = call.argument<ByteArray>("imageBytes") ?: run {
                        result.error("INVALID_ARGUMENT", "Wallpaper data is required.", null)
                        return
                    }

                    val location = call.argument<Int>("location") ?: run {
                        result.error("INVALID_ARGUMENT", "Location is required.", null)
                        return
                    }

                    // Convert byte array to InputStream
                    val stream = wallpaperData.inputStream()

                    // Get the WallpaperManager instance
                    val wallpaperManager = WallpaperManager.getInstance(context)

                    // set the wallpaper
                    wallpaperManager.setStream(stream, null, false, location)

                    // If everything goes well, return success
                    result.success(true)
                } catch (e: IOException) {
                    // Handle any IOException (e.g., failure in setting the wallpaper)
                    e.printStackTrace()
                    result.error("IO_EXCEPTION", "Failed to set the wallpaper: ${e.message}", null)
                } catch (e: Exception) {
                    // Catch any other exceptions and provide a generic error message
                    e.printStackTrace()
                    result.error("UNKNOWN_ERROR", "An unexpected error occurred: ${e.message}", null)
                }
            }

            else -> {
                // If an unsupported method is called, return method not implemented
                result.notImplemented()
            }
        }
    }
}
