package com.nativescreens

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier

class NativeComposeActivity : ComponentActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    val title = intent.getStringExtra(EXTRA_TITLE) ?: "Native Screen (Compose)"
    setContent {
      Surface(modifier = Modifier.fillMaxSize()) {
        NativeExampleComposeScreen(
          title = title,
          onClose = {
            NativeScreenModule.notifyNativeScreenClosed()
            finish()
          },
        )
      }
    }
  }

  companion object {
    const val EXTRA_TITLE = "title"
  }
}
