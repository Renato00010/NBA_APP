import 'package:dio/dio.dart';

class NewsApiService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey = 'f603e3e9-b7ce-4d29-89e1-1674009caee6';

  final Dio _dio;

  NewsApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {'X-Api-Key': _apiKey},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  // Buscar notícias NBA
  Future<List<dynamic>> getNbaNews({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/everything',
        queryParameters: {
          'q': 'NBA',
          'language': 'en',
          'sortBy': 'publishedAt',
          'page': page,
          'pageSize': 20,
        },
      );
      return response.data['articles'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar notícias: ${e.message}');
    }
  }

  // Buscar notícias por equipa
  Future<List<dynamic>> getNewsByTeam(String teamName, {int page = 1}) async {
    try {
      final response = await _dio.get(
        '/everything',
        queryParameters: {
          'q': 'NBA $teamName',
          'language': 'en',
          'sortBy': 'publishedAt',
          'page': page,
          'pageSize': 20,
        },
      );
      return response.data['articles'] as List<dynamic>;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar notícias da equipa: ${e.message}');
    }
  }
}
