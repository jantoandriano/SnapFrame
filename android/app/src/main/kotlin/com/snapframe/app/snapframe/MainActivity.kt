package com.snapframe.app.snapframe

import android.content.ActivityNotFoundException
import android.content.Intent
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "snapframe/whatsapp")
            .setMethodCallHandler { call, result ->
                if (call.method != "shareImage") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }
                val bytes = call.argument<ByteArray>("bytes")
                val phone = call.argument<String>("phone")
                if (bytes == null || phone == null) {
                    result.error("bad_args", "bytes and phone are required", null)
                    return@setMethodCallHandler
                }
                if (shareToWhatsApp(bytes, phone, call.argument<String>("text"))) {
                    result.success(null)
                } else {
                    result.error("not_installed", "WhatsApp is not installed", null)
                }
            }
    }

    /**
     * Opens WhatsApp (or WhatsApp Business) with the image attached and the
     * chat for [phone] preselected via the `jid` extra, which WhatsApp reads
     * but doesn't officially document. Returns false if neither app exists.
     */
    private fun shareToWhatsApp(bytes: ByteArray, phone: String, text: String?): Boolean {
        val dir = File(cacheDir, "shared").apply { mkdirs() }
        val file = File(dir, "snapframe.jpg").apply { writeBytes(bytes) }
        val uri = FileProvider.getUriForFile(this, "$packageName.whatsapp_share", file)

        for (pkg in listOf("com.whatsapp", "com.whatsapp.w4b")) {
            val intent = Intent(Intent.ACTION_SEND).apply {
                type = "image/jpeg"
                setPackage(pkg)
                putExtra(Intent.EXTRA_STREAM, uri)
                text?.let { putExtra(Intent.EXTRA_TEXT, it) }
                putExtra("jid", "$phone@s.whatsapp.net")
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            try {
                startActivity(intent)
                return true
            } catch (_: ActivityNotFoundException) {
                // Try the next WhatsApp flavor.
            }
        }
        return false
    }
}

/** Own subclass so the manifest entry can't clash with plugin providers. */
class WhatsAppShareProvider : FileProvider()
