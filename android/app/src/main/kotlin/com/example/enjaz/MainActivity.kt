package com.example.enjaz

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "cash.etisalat.dev")
            .setMethodCallHandler { call, result ->
                if (call.method == "sendEvent") {
                    // Handle the method call
                    result.success("Event sent")
                } else {
                    result.notImplemented()
                }
            }
    }
}
