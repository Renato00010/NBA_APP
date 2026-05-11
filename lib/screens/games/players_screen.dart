import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../db/app_database.dart';

import 'player_detail_screen.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<Player> _players = [];
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadPlayers();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      final text = _searchController.text;
      if (text.length >= 3) {
        _loadPlayers(search: text);
      } else if (text.isEmpty) {
        _loadPlayers();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPlayers({String? search}) async {
    setState(() => _loading = true);
    try {
      final players = await repository.getPlayers(search: search);
      setState(() {
        _players = players;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Widget _playerAvatar(Player player, ThemeData theme) {
    final photoPath = player.photoWebpPath;
    if (photoPath != null && photoPath.isNotEmpty) {
      final imageProvider = photoPath.startsWith('assets/')
          ? AssetImage(photoPath)
          : photoPath.startsWith('http')
          ? CachedNetworkImageProvider(photoPath)
          : File(photoPath).existsSync()
          ? FileImage(File(photoPath)) as ImageProvider
          : null;

      if (imageProvider == null) {
        return _initialsAvatar(player, theme);
      }

      return CircleAvatar(
        radius: 26,
        backgroundImage: imageProvider,
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
      );
    }

    return _initialsAvatar(player, theme);
  }

  Widget _initialsAvatar(Player player, ThemeData theme) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
      child: Text(
        player.fullName.isNotEmpty ? player.fullName[0] : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          'Jogadores',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Pesquisar jogador (mín. 3 letras)...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: Colors.white38),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white38),
                        onPressed: () {
                          _searchController.clear();
                          _loadPlayers();
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _players.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum jogador encontrado',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _players.length,
                    itemBuilder: (context, index) {
                      final player = _players[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlayerDetailScreen(player: player),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _playerAvatar(player, theme),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      player.fullName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      player.position ?? 'Posição desconhecida',
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white38,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
