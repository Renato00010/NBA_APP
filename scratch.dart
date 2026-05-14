import 'dart:convert';
import 'dart:io';

void main() async {
  final d = jsonDecode(File('espn.json').readAsStringSync());
  final id = d['events'][0]['id'];
  
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse('https://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?event=$id'));
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  
  final sum = jsonDecode(responseBody);
  print(sum['gameInfo']?['venue'] ?? sum['header']?['competitions']?[0]?['venue']);
}
