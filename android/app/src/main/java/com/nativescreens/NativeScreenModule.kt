package com.nativescreens

import android.content.Intent
import com.facebook.react.bridge.Callback
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class NativeScreenModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String = "NativeScreenModule"

  @ReactMethod
  fun openNativeScreen(title: String, callback: Callback) {
    closeCallback = callback
    val intent = Intent(reactApplicationContext, NativeExampleActivity::class.java).apply {
      putExtra(NativeExampleActivity.EXTRA_TITLE, title)
      addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    }
    reactApplicationContext.startActivity(intent)
  }

  @ReactMethod
  fun openNativeComposeScreen(title: String, callback: Callback) {
    closeCallback = callback
    val intent = Intent(reactApplicationContext, NativeComposeActivity::class.java).apply {
      putExtra(NativeComposeActivity.EXTRA_TITLE, title)
      addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    }
    reactApplicationContext.startActivity(intent)
  }

  companion object {
    private var closeCallback: Callback? = null

    @JvmStatic
    fun notifyNativeScreenClosed() {
      closeCallback?.invoke()
      closeCallback = null
    }
  }
}
