package com.example.wallpaper_manager_flutter
import android.app.WallpaperManager
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

class MainActivity: FlutterActivity() {
  private val channel = "setwallpaper"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    val plugin = WallpaperManagerFlutterPlugin()
    val registry = flutterEngine.plugins
    registry.add(plugin)
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
      plugin.onMethodCall(call, result)
    }
  }
}

class WallpaperManagerFlutterPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var context: Context

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    val methodChannel = MethodChannel(binding.binaryMessenger, "setwallpaper")
    methodChannel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "setWallpaper" -> {
        try {
          val wm = WallpaperManager.getInstance(context)
          val stream = call.argument<ByteArray>("data")!!.inputStream()
          val location = call.argument<Int>("location")!!.toInt()
          if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            wm.setStream(stream,null,false,location)
          }
        } catch (e: IOException) {
          e.printStackTrace()
        }
      }
    }
  }
}
