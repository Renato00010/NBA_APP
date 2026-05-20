import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

class CorsProxyClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (kIsWeb) {
      final originalUrl = request.url.toString();
      final proxiedUrl = 'https://corsproxy.io/?url=${Uri.encodeComponent(originalUrl)}';
      
      final newRequest = http.Request(request.method, Uri.parse(proxiedUrl))
        ..headers.addAll(request.headers)
        ..maxRedirects = request.maxRedirects
        ..followRedirects = request.followRedirects;
        
      if (request is http.Request) {
        newRequest.bodyBytes = request.bodyBytes;
      }
      
      return _inner.send(newRequest);
    }
    return _inner.send(request);
  }
}

void main() {
  try {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'test',
      httpClient: CorsProxyClient(),
    );
    print("GenerativeModel created successfully with CorsProxyClient!");
  } catch (e) {
    print("Error: $e");
  }
}


