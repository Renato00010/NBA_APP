import 'package:dio/dio.dart';

class NbaApiService {
  // Buscar jogos via ESPN (sem os limites agressivos da balldontlie)
  Future<List<dynamic>> getEspnScoreboard(String dateYYYYMMDD) async {
    try {
      final response = await Dio().get(
        'https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard',
        queryParameters: {'dates': dateYYYYMMDD},
      );
      return response.data['events'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar placar da ESPN: ${e.message}');
    }
  }

  // Buscar detalhes de um jogo específico (Odds, TV, Leaders)
  Future<Map<String, dynamic>> getEspnGameSummary(String eventId) async {
    try {
      final response = await Dio().get(
        'https://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary',
        queryParameters: {'event': eventId},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar detalhes do jogo na ESPN: ${e.message}');
    }
  }

  // Buscar notícias da NBA via ESPN
  Future<List<dynamic>> getEspnNews() async {
    try {
      final response = await Dio().get(
        'https://site.api.espn.com/apis/site/v2/sports/basketball/nba/news',
      );
      return response.data['articles'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar notícias na ESPN: ${e.message}');
    }
  }
}
