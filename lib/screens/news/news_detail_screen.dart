import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final dynamic article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = (article['images'] != null && article['images'].isNotEmpty) ? article['images'][0]['url'] : null;
    final title = article['headline'] ?? '';
    final source = 'ESPN';
    final publishedAt = article['published'] ?? '';
    final content = article['description'] ?? 'Conteúdo não disponível.';
    
    // Format date if possible
    String dateStr = publishedAt;
    if (dateStr.length >= 10) {
      dateStr = dateStr.substring(0, 10);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0A0A0A),
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey[900]),
                          errorWidget: (context, url, error) => const Icon(Icons.image_not_supported, color: Colors.white24, size: 50),
                        )
                      : Container(color: Colors.grey[900]),
                  // Gradient to fade into background color
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                          const Color(0xFF0A0A0A),
                        ],
                        stops: const [0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source and Date badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
                        ),
                        child: Text(
                          source.toUpperCase(),
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.calendar_today, size: 14, color: Colors.white54),
                      const SizedBox(width: 6),
                      Text(
                        dateStr,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Divider
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 24),
                  // Content
                  Text(
                    content.replaceAll(RegExp(r'\[\+\d+ chars\]'), ''),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (article['links']?['web']?['href'] != null)
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final url = Uri.parse(article['links']['web']['href']);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Ler Notícia Completa', style: TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 80), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
