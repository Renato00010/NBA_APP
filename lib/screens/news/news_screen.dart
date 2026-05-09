import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/news_api_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsApiService _newsApi = NewsApiService();
  List<dynamic> _articles = [];
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    setState(() {
      _loading = true;
      _error = false;
    });
    try {
      final articles = await _newsApi.getNbaNews();
      setState(() {
        _articles = articles.where((a) => a['title'] != '[Removed]').toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          'Notícias',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Erro ao carregar notícias',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loadNews,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadNews,
              color: theme.colorScheme.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  final imageUrl = article['urlToImage'];
                  final title = article['title'] ?? 'Sem título';
                  final description = article['description'] ?? 'Sem descrição';
                  final source =
                      article['source']['name'] ?? 'Fonte desconhecida';
                  final publishedAt = article['publishedAt'] ?? '';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagem
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: 180,
                                    color: theme.colorScheme.primary
                                        .withOpacity(0.2),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        height: 180,
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.2),
                                        child: const Icon(
                                          Icons.image_outlined,
                                          color: Colors.white54,
                                          size: 40,
                                        ),
                                      ),
                                )
                              : Container(
                                  height: 180,
                                  color: theme.colorScheme.primary.withOpacity(
                                    0.2,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: Colors.white54,
                                      size: 40,
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                description,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 6,
                                    color: theme.colorScheme.tertiary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    source,
                                    style: TextStyle(
                                      color: theme.colorScheme.tertiary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    publishedAt.length >= 10
                                        ? publishedAt.substring(0, 10)
                                        : publishedAt,
                                    style: const TextStyle(
                                      color: Colors.white38,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
