import 'package:dio/dio.dart';

class NbaApiService {
  static const String _baseUrl = 'https://api.balldontlie.io/v1';
  static const String _apiKey = 'f603e3e9-b7ce-4d29-89e1-1674009caee6';

  final Dio _dio;

  NbaApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {'Authorization': _apiKey},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  // Buscar todas as equipas
  Future<List<dynamic>> getTeams() async {
    try {
      final response = await _dio.get('/teams');
      return response.data['data'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar equipas: ${e.message}');
    }
  }

  // Buscar jogos por data
  Future<List<dynamic>> getGamesByDate(String date) async {
    try {
      final response = await _dio.get(
        '/games',
        queryParameters: {'dates[]': date},
      );
      return response.data['data'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar jogos: ${e.message}');
    }
  }

  // Buscar jogos ao vivo
  Future<List<dynamic>> getLiveGames() async {
    try {
      final response = await _dio.get('/games/live');
      return response.data['data'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar jogos ao vivo: ${e.message}');
    }
  }

  // Buscar jogadores
  Future<List<dynamic>> getPlayers({String? search, int page = 1}) async {
    try {
      final response = await _dio.get(
        '/players',
        queryParameters: {
          if (search != null) 'search': search,
          'page': page,
          'per_page': 25,
        },
      );
      return response.data['data'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar jogadores: ${e.message}');
    }
  }

  // Buscar estatísticas de um jogador
  Future<List<dynamic>> getPlayerStats(int playerId) async {
    try {
      final response = await _dio.get(
        '/season_averages',
        queryParameters: {'player_ids[]': playerId, 'season': 2024},
      );
      return response.data['data'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar estatísticas: ${e.message}');
    }
  }

  // Buscar standings
  Future<List<dynamic>> getStandings() async {
    try {
      final response = await _dio.get(
        '/standings',
        queryParameters: {'season': 2024},
      );
      return response.data['data'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar standings: ${e.message}');
    }
  }
}
