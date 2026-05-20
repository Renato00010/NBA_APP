import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HighlightVideo {
  final String videoId;
  final String title;
  final String url;
  final String thumbnailUrl;

  const HighlightVideo({
    required this.videoId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory HighlightVideo.fromVideoId(String videoId, {String? title}) {
    return HighlightVideo(
      videoId: videoId,
      title: title ?? 'NBA highlights',
      url: 'https://www.youtube.com/watch?v=$videoId',
      thumbnailUrl: 'https://i.ytimg.com/vi/$videoId/hqdefault.jpg',
    );
  }
}

class YoutubeHighlightsService {
  static const _instances = [
    'https://yewtu.be',
    'https://inv.nadeko.net',
    'https://inv.tux.pizza',
    'https://invidious.nerdvpn.de',
  ];

  Future<HighlightVideo?> findGameHighlights(
    String homeName,
    String awayName,
  ) async {
    final query = _queryFor(homeName, awayName);

    final viaInvidious = await _findWithInvidious(query);
    if (viaInvidious != null) return viaInvidious;

    return _findWithYoutubeSearchPage(query);
  }

  String searchUrl(String homeName, String awayName) {
    final encodedQuery = Uri.encodeComponent(_queryFor(homeName, awayName));
    return 'https://www.youtube.com/results?search_query=$encodedQuery';
  }

  String _queryFor(String homeName, String awayName) {
    final langCode = PlatformDispatcher.instance.locale.languageCode;
    if (langCode == 'pt') {
      return '$awayName x $homeName melhores momentos nba';
    }
    return 'NBA $awayName vs $homeName full game highlights';
  }

  Future<HighlightVideo?> _findWithInvidious(String query) async {
    final encodedQuery = Uri.encodeComponent(query);

    for (final instance in _instances) {
      try {
        final uri = Uri.parse(
          '$instance/api/v1/search?q=$encodedQuery&type=video&sort_by=relevance',
        );
        final res = await http.get(uri).timeout(const Duration(seconds: 6));
        if (res.statusCode != 200) continue;

        final data = jsonDecode(res.body);
        if (data is! List) continue;

        for (final item in data) {
          if (item is! Map || item['type'] != 'video') continue;

          final videoId = item['videoId'];
          if (!_isValidVideoId(videoId)) continue;

          final title = item['title']?.toString() ?? 'NBA highlights';
          if (!_looksLikeGameHighlight(title)) continue;

          return HighlightVideo(
            videoId: videoId,
            title: title,
            url: 'https://www.youtube.com/watch?v=$videoId',
            thumbnailUrl: _bestThumbnail(item, videoId),
          );
        }
      } catch (_) {
        // Try the next public instance.
      }
    }

    return null;
  }

  Future<HighlightVideo?> _findWithYoutubeSearchPage(String query) async {
    try {
      final encodedQuery = Uri.encodeComponent(query);
      final url = 'https://www.youtube.com/results?search_query=$encodedQuery';

      http.Response res;
      if (kIsWeb) {
        final proxyUrl =
            'https://api.allorigins.win/raw?url=${Uri.encodeComponent(url)}';
        res = await http.get(Uri.parse(proxyUrl));
      } else {
        res = await http.get(
          Uri.parse(url),
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36',
            'Accept-Language': 'pt-PT,pt;q=0.9,en-US;q=0.8,en;q=0.7',
          },
        );
      }

      if (res.statusCode != 200) return null;

      final body = res.body;
      final jsonStr = _extractYtInitialData(body);
      if (jsonStr != null) {
        final data = jsonDecode(jsonStr);
        HighlightVideo? matchedVideo;
        
        void searchVideos(dynamic node) {
          if (matchedVideo != null) return;
          if (node is Map) {
            final video = node['videoRenderer'];
            if (video is Map<String, dynamic>) {
              final videoId = video['videoId'];
              final title = _videoTitle(video);
              if (_isValidVideoId(videoId) && _looksLikeGameHighlight(title)) {
                matchedVideo = HighlightVideo.fromVideoId(videoId, title: title);
                return;
              }
            }
            node.values.forEach(searchVideos);
          } else if (node is List) {
            node.forEach(searchVideos);
          }
        }
        
        searchVideos(data);
        if (matchedVideo != null) return matchedVideo;
      }

      final regexMatch = RegExp(
        r'"videoId":"([a-zA-Z0-9_-]{11})"',
      ).firstMatch(body);
      if (regexMatch != null) {
        return HighlightVideo.fromVideoId(regexMatch.group(1)!);
      }
    } catch (_) {
      // Silent failure keeps the UI usable when YouTube changes markup.
    }

    return null;
  }

  String _bestThumbnail(Map<dynamic, dynamic> item, String videoId) {
    final thumbnails = item['videoThumbnails'];
    if (thumbnails is List && thumbnails.isNotEmpty) {
      final sorted = thumbnails.whereType<Map>().toList()
        ..sort((a, b) {
          final aw = int.tryParse(a['width']?.toString() ?? '') ?? 0;
          final bw = int.tryParse(b['width']?.toString() ?? '') ?? 0;
          return bw.compareTo(aw);
        });
      final url = sorted.firstOrNull?['url']?.toString();
      if (url != null && url.isNotEmpty) return url;
    }

    return 'https://i.ytimg.com/vi/$videoId/hqdefault.jpg';
  }

  String? _extractYtInitialData(String body) {
    final marker = 'ytInitialData = ';
    final markerIndex = body.indexOf(marker);
    if (markerIndex == -1) return null;

    final start = body.indexOf('{', markerIndex + marker.length);
    if (start == -1) return null;

    var depth = 0;
    var inString = false;
    var escaped = false;

    for (var i = start; i < body.length; i++) {
      final code = body.codeUnitAt(i);

      if (escaped) {
        escaped = false;
        continue;
      }
      if (code == 0x5C) {
        escaped = inString;
        continue;
      }
      if (code == 0x22) {
        inString = !inString;
        continue;
      }
      if (inString) continue;

      if (code == 0x7B) depth++;
      if (code == 0x7D) {
        depth--;
        if (depth == 0) return body.substring(start, i + 1);
      }
    }

    return null;
  }

  String _videoTitle(Map<String, dynamic> video) {
    final runs = video['title']?['runs'];
    if (runs is List && runs.isNotEmpty) {
      final first = runs.first;
      if (first is Map && first['text'] != null) {
        return first['text'].toString();
      }
    }

    return video['title']?['simpleText']?.toString() ?? 'NBA highlights';
  }

  bool _isValidVideoId(dynamic value) {
    return value is String && RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(value);
  }

  bool _looksLikeGameHighlight(String title) {
    final normalized = title.toLowerCase();
    final hasHighlightKw = normalized.contains('highlight') ||
        normalized.contains('recap') ||
        normalized.contains('full game') ||
        normalized.contains('melhores') ||
        normalized.contains('resumo');
    
    // For English titles, 'nba' is usually required to avoid generic highlights,
    // but for specific Portuguese game matchups, 'melhores' is often enough.
    return hasHighlightKw;
  }
}
