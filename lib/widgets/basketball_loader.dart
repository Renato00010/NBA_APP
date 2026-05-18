import 'package:flutter/material.dart';

class BasketballLoader extends StatefulWidget {
  final double size;
  final Color? color;

  const BasketballLoader({
    super.key,
    this.size = 48.0,
    this.color,
  });

  @override
  State<BasketballLoader> createState() => _BasketballLoaderState();
}

class _BasketballLoaderState extends State<BasketballLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.color ?? Theme.of(context).colorScheme.primary;

    return Center(
      child: RotationTransition(
        turns: _controller,
        child: Icon(
          Icons.sports_basketball,
          size: widget.size,
          color: themeColor,
        ),
      ),
    );
  }
}
