import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final query = Uri.encodeComponent('NBA Highlights Lakers vs Warriors full game');
  
  // List of public Invidious instances to try
  final instances = [
    'https://yewtu.be',
    'https://vid.puffyan.us',
    'https://inv.tux.im',
  ];
  
  for (final instance in instances) {
    final searchUrl = '$instance/api/v1/search?q=$query';
    print('Trying instance: $instance...');
    try {
      final res = await http.get(Uri.parse(searchUrl)).timeout(const Duration(seconds: 5));
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);
        if (data.isNotEmpty) {
          for (final item in data) {
            if (item['type'] == 'video') {
              print('SUCCESS on $instance!');
              print('Video ID: ${item['videoId']}');
              print('Title: ${item['title']}');
              print('Thumbnail: ${item['videoThumbnails'][0]['url']}');
              return;
            }
          }
        }
      } else {
        print('Status code: ${res.statusCode}');
      }
    } catch (e) {
      print('Failed on $instance: $e');
    }
  }
}
