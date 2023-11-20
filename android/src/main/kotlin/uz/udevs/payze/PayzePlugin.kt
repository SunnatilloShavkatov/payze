package uz.udevs.payze

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

const val MAIN_ACTIVITY = 201
const val PAYZE_ACTIVITY_FINISH = 301

/** PayzePlugin */
class PayzePlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener, PluginRegistry.NewIntentListener {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var resultMethod: Result? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "payze")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "pay") {
            val args = call.arguments as HashMap<*, *>
            resultMethod = result
            val intent = Intent(activity, PayzeActivity::class.java)
            intent.putExtra("number", args["cardNumber"] as String)
            intent.putExtra("cardHolder", args["cardHolder"] as String)
            intent.putExtra("expirationDate", args["cardNumber"] as String)
            intent.putExtra("securityNumber", args["cvv"] as String)
            intent.putExtra("transactionId", args["transactionId"] as String)
            activity?.startActivityForResult(intent, MAIN_ACTIVITY)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as FlutterActivity
        binding.addOnNewIntentListener(this)
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == MAIN_ACTIVITY && resultCode == PAYZE_ACTIVITY_FINISH) {
            if (data == null || data.extras == null) {
                resultMethod?.success(null)
            } else if (data.getStringExtra("result") == null) {
                resultMethod?.success(null)
            } else {
                resultMethod?.success(data.getStringExtra("result"))
            }
        }
        return true
    }


    override fun onNewIntent(intent: Intent): Boolean {
        return true
    }
}
