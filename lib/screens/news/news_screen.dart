import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../main.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
      final articles = await repository.getNews();
      setState(() {
        _articles = articles;
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error
              ? _buildErrorWidget()
              : RefreshIndicator(
                  onRefresh: _loadNews,
                  color: theme.colorScheme.primary,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      _buildAppBar(),
                      if (_articles.isNotEmpty)
                        SliverToBoxAdapter(
                          child: _buildFeaturedArticle(_articles[0]),
                        ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Últimas Notícias',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // Começamos do índice 1 porque o 0 é o destaque
                            final actualIndex = index + 1;
                            if (actualIndex >= _articles.length) return null;
                            return _buildNewsCard(_articles[actualIndex]);
                          },
                          childCount: _articles.length > 1 ? _articles.length - 1 : 0,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 80)),
                    ],
                  ),
                ),
    );
  }

  Widget _buildAppBar() {
    final theme = Theme.of(context);
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      backgroundColor: theme.colorScheme.primary, // Cor dinâmica
      elevation: 4,
      title: const Text(
        'NEWS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _loadNews,
          icon: const Icon(Icons.refresh, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildFeaturedArticle(dynamic article) {
    final theme = Theme.of(context);
    final imageUrl = (article['images'] != null && article['images'].isNotEmpty) ? article['images'][0]['url'] : null;
    final title = article['headline'] ?? '';
    final source = 'ESPN';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(article: article),
          ),
        );
      },
      child: Container(
        height: 380,
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagem de fundo
              imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Container(color: Colors.grey[900]),
              // Gradiente
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.8),
                      Colors.black,
                    ],
                  ),
                ),
              ),
              // Conteúdo
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'EM DESTAQUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.white60),
                        const SizedBox(width: 4),
                        Text(
                          'Hoje • $source',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(dynamic article) {
    final theme = Theme.of(context);
    final imageUrl = (article['images'] != null && article['images'].isNotEmpty) ? article['images'][0]['url'] : null;
    final title = article['headline'] ?? '';
    final source = 'ESPN';
    final publishedAt = article['published'] ?? '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(article: article),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Miniatura
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 100,
              height: 100,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[900]),
                      errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
                    )
                  : Container(color: Colors.grey[900]),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  source.toUpperCase(),
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  publishedAt.length >= 10 ? publishedAt.substring(0, 10) : publishedAt,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 64, color: Colors.white24),
          const SizedBox(height: 16),
          const Text(
            'Não foi possível ligar à rede',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Verifica a tua ligação ou tenta mais tarde.',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadNews,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
