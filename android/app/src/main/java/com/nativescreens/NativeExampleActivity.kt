package com.nativescreens

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class NativeExampleActivity : AppCompatActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_native_example)

    val title = intent.getStringExtra(EXTRA_TITLE) ?: "Native Screen"
    findViewById<TextView>(R.id.native_title).text = title

    findViewById<Button>(R.id.native_close).setOnClickListener {
      NativeScreenModule.notifyNativeScreenClosed()
      finish()
    }
  }

  companion object {
    const val EXTRA_TITLE = "title"
  }
}
