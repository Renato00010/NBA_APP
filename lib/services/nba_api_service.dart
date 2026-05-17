import 'package:dio/dio.dart';

import '../models/standing.dart';

class NbaApiService {
  final Dio _dio = Dio();
  // Buscar jogos via ESPN (sem os limites agressivos da balldontlie)
  Future<List<dynamic>> getEspnScoreboard(String dateYYYYMMDD) async {
    try {
      final response = await _dio.get(
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
      final response = await _dio.get(
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
      final response = await _dio.get(
        'https://site.api.espn.com/apis/site/v2/sports/basketball/nba/news',
      );
      return response.data['articles'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar notícias na ESPN: ${e.message}');
    }
  }

  /// Calendário completo da equipa (época regular = 2, playoffs = 3).
  Future<List<dynamic>> getEspnTeamSchedule(
    String teamSlug, {
    required int season,
    required int seasonType,
  }) async {
    try {
      final response = await _dio.get(
        'https://site.api.espn.com/apis/site/v2/sports/basketball/nba/teams/$teamSlug/schedule',
        queryParameters: {
          'season': season,
          'seasontype': seasonType,
        },
      );
      return response.data['events'] as List<dynamic>? ?? [];
    } on DioException catch (e) {
      throw Exception('Erro ao buscar calendário ESPN: ${e.message}');
    }
  }

  /// Classificação atual da NBA (dados reais ESPN).
  Future<List<Standing>> getEspnStandings() async {
    try {
      final response = await _dio.get(
        'https://site.api.espn.com/apis/site/v2/sports/basketball/nba/standings',
      );
      final data = response.data as Map<String, dynamic>;
      final children = data['children'] as List<dynamic>? ?? [];
      final standings = <Standing>[];

      for (final child in children) {
        final childMap = child as Map<String, dynamic>;
        final conferenceName = childMap['name'] as String? ?? '';
        final entries =
            childMap['standings']?['entries'] as List<dynamic>? ?? [];
        for (final entry in entries) {
          standings.add(
            Standing.fromEspnEntry(
              entry as Map<String, dynamic>,
              conferenceName,
            ),
          );
        }
      }
      return standings;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar classificação ESPN: ${e.message}');
    }
  }
}
