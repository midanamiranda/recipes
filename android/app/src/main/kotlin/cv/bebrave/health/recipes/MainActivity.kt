package cv.bebrave.health.recipes

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "recipes.platform/appcenter"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getAndroidAppSecret" -> {
                    try {
                        result.success(BuildConfig.ANDROID_APP_SECRET)
                    } catch (ex: Exception) {
                        result.error("UNAVAILABLE", "Android App Secret not available.", null)
                    }
                }
            }
        }
    }
}
