import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../services/repository.dart';

class TeamLogo extends StatelessWidget {
  final String teamId;
  final double size;
  final Color? fallbackColor;
  final String? heroTag;

  const TeamLogo({
    super.key,
    required this.teamId,
    this.size = 40,
    this.fallbackColor,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final color = fallbackColor ?? Theme.of(context).colorScheme.primary;

    Widget child = SizedBox.square(
      dimension: size,
      child: CachedNetworkImage(
        imageUrl: NbaRepository.getTeamLogoUrl(teamId),
        fit: BoxFit.contain,
        placeholder: (context, url) => _FallbackLogo(
          size: size,
          color: color.withValues(alpha: 0.35),
        ),
        errorWidget: (context, url, error) => _FallbackLogo(
          size: size,
          color: color,
        ),
      ),
    );

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: child,
      );
    }
    return child;
  }
}

class _FallbackLogo extends StatelessWidget {
  final double size;
  final Color color;

  const _FallbackLogo({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.sports_basketball, color: color, size: size * 0.72);
  }
}
