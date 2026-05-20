import Flutter
import UIKit
import WebKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    registerYoutubePlayer(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    registerYoutubePlayer(with: engineBridge.pluginRegistry)
  }

  private func registerYoutubePlayer(with registry: FlutterPluginRegistry) {
    let registrar = registry.registrar(forPlugin: "YoutubePlayerPlatformView")
    registrar.register(
      YoutubePlayerFactory(),
      withId: "nba_app/youtube_player"
    )
  }
}

class YoutubePlayerFactory: NSObject, FlutterPlatformViewFactory {
  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    let params = args as? [String: Any]
    let videoId = params?["videoId"] as? String ?? ""
    return YoutubePlayerPlatformView(frame: frame, videoId: videoId)
  }
}

class YoutubePlayerPlatformView: NSObject, FlutterPlatformView {
  private let webView: WKWebView

  init(frame: CGRect, videoId: String) {
    let configuration = WKWebViewConfiguration()
    configuration.allowsInlineMediaPlayback = true
    configuration.mediaTypesRequiringUserActionForPlayback = []
    webView = WKWebView(frame: frame, configuration: configuration)
    super.init()
    webView.scrollView.isScrollEnabled = false
    webView.isOpaque = false
    webView.backgroundColor = .black
    if let url = URL(string: "https://m.youtube.com/watch?v=\(videoId)") {
      webView.load(URLRequest(url: url))
    }
  }

  func view() -> UIView {
    return webView
  }
}
