package com.example.nba_app

import android.annotation.SuppressLint
import android.content.Context
import android.view.View
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("nba_app/youtube_player", YoutubePlayerViewFactory())
    }
}

class YoutubePlayerViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val videoId = params?.get("videoId")?.toString().orEmpty()
        return YoutubePlayerPlatformView(context, videoId)
    }
}

class YoutubePlayerPlatformView(
    context: Context,
    private val videoId: String,
) : PlatformView {
    private val webView = WebView(context)

    init {
        configureWebView()
        webView.loadUrl("https://m.youtube.com/watch?v=$videoId")
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun configureWebView() {
        webView.webChromeClient = WebChromeClient()
        webView.webViewClient = WebViewClient()
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.settings.mediaPlaybackRequiresUserGesture = false
        webView.settings.loadWithOverviewMode = true
        webView.settings.useWideViewPort = true
    }

    override fun getView(): View = webView

    override fun dispose() {
        webView.destroy()
    }
}
