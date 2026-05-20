import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Content {
  final String text;
  Content.text(this.text);
}

class AiChatResponse {
  final String? text;
  AiChatResponse(this.text);
}

class AiChatSession {
  final String apiKey;
  final String systemInstruction;
  final List<Map<String, dynamic>> _history = [];

  AiChatSession({required this.apiKey, required this.systemInstruction});

  List<Map<String, dynamic>> get history => _history;

  Future<AiChatResponse> sendMessage(Content content) async {
    // Add user message to history
    _history.add({
      'role': 'user',
      'parts': [
        {'text': content.text}
      ]
    });

    final String url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey';
    
    String finalUrl = url;
    if (kIsWeb) {
      // Route through CORS proxy on Web
      finalUrl = 'https://corsproxy.io/?url=${Uri.encodeComponent(url)}';
    }

    try {
      final response = await http.post(
        Uri.parse(finalUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': _history,
          'systemInstruction': {
            'parts': [
              {'text': systemInstruction}
            ]
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final contentMap = candidates[0]['content'] as Map?;
          if (contentMap != null) {
            final parts = contentMap['parts'] as List?;
            if (parts != null && parts.isNotEmpty) {
              final textResponse = parts[0]['text'] as String?;
              if (textResponse != null) {
                // Add model response to history
                _history.add({
                  'role': 'model',
                  'parts': [
                    {'text': textResponse}
                  ]
                });
                return AiChatResponse(textResponse);
              }
            }
          }
        }
        return AiChatResponse('Lamento, mas recebi uma resposta vazia do servidor.');
      } else {
        debugPrint('Gemini Error Response: ${response.statusCode} - ${response.body}');
        return AiChatResponse(
          'Erro ao comunicar com a IA (Código HTTP ${response.statusCode}).\n'
          'Detalhes: ${response.body}'
        );
      }
    } catch (e) {
      debugPrint('Gemini Connection Error: $e');
      rethrow;
    }
  }
}

class AiAssistantService {
  static String? customApiKey;

  static const String _defaultApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyCXrxFGgR9iUSpzqpj4uW_4aBLZaamf2Uk',
  );

  static String get apiKey => customApiKey ?? _defaultApiKey;
  
  final String _systemInstruction = 
      "Tu és o Assistente Virtual da NBA, um especialista apaixonado por basquetebol. "
      "O teu objetivo é ajudar o utilizador com estatísticas, informações sobre equipas, "
      "jogadores, regras, história da NBA e a navegação da própria aplicação. "
      "Responde SEMPRE em Português de Portugal (pt-PT) com um tom entusiasta, amigável e profissional. "
      "Utiliza formatação Markdown (negritos, listas, etc.) para tornar as tuas respostas legíveis, dinâmicas e apelativas.";

  AiAssistantService();

  AiChatSession startChat() {
    return AiChatSession(
      apiKey: apiKey,
      systemInstruction: _systemInstruction,
    );
  }

  static Future<Map<String, dynamic>> generateMatchupHype({
    required String homeTeam,
    required String awayTeam,
    required String languageCode,
  }) async {
    final bool isEn = languageCode.startsWith('en');
    
    final systemInstruction =
        "Tu és um analisador de rivalidades e hype da NBA. "
        "Deves responder APENAS com um objeto JSON válido, sem qualquer tipo de formatação markdown adicionada (NÃO utilizes blocos de código com ```json ou ```). "
        "O JSON deve conter exatamente as seguintes chaves:\n"
        "- 'hypeIndex': um número inteiro de 0 a 100 indicando o nível de entusiasmo global para este jogo.\n"
        "- 'title': um título curto e marcante para o confronto em ${isEn ? 'Inglês (en-US)' : 'Português de Portugal (pt-PT)'}.\n"
        "- 'rivalryScore': um número inteiro de 0 a 100 indicando a intensidade histórica da rivalidade.\n"
        "- 'analysis': uma análise tática e histórica detalhada e entusiasmante das duas equipas (máximo 2-3 parágrafos) em ${isEn ? 'Inglês (en-US)' : 'Português de Portugal (pt-PT)'}.\n"
        "- 'prediction': uma previsão entusiasmante do vencedor e possível margem de pontos em ${isEn ? 'Inglês (en-US)' : 'Português de Portugal (pt-PT)'}.";

    final String url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey';
    String finalUrl = url;
    if (kIsWeb) {
      finalUrl = 'https://corsproxy.io/?url=${Uri.encodeComponent(url)}';
    }

    try {
      final response = await http.post(
        Uri.parse(finalUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'role': 'user',
              'parts': [
                {
                  'text': 'Gera uma análise estruturada do jogo: $homeTeam contra $awayTeam.'
                }
              ]
            }
          ],
          'systemInstruction': {
            'parts': [
              {'text': systemInstruction}
            ]
          },
          'generationConfig': {
            'responseMimeType': 'application/json',
          }
        }),
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final contentMap = candidates[0]['content'] as Map?;
          if (contentMap != null) {
            final parts = contentMap['parts'] as List?;
            if (parts != null && parts.isNotEmpty) {
              String? textResponse = parts[0]['text'] as String?;
              if (textResponse != null) {
                textResponse = textResponse.trim();
                // Strip markdown backticks if any remained despite instruction
                if (textResponse.startsWith('```')) {
                  final lines = textResponse.split('\n');
                  if (lines.first.startsWith('```')) {
                    lines.removeAt(0);
                  }
                  if (lines.isNotEmpty && lines.last.startsWith('```')) {
                    lines.removeLast();
                  }
                  textResponse = lines.join('\n').trim();
                }
                final parsed = jsonDecode(textResponse) as Map<String, dynamic>;
                if (parsed.containsKey('hypeIndex') &&
                    parsed.containsKey('title') &&
                    parsed.containsKey('rivalryScore') &&
                    parsed.containsKey('analysis') &&
                    parsed.containsKey('prediction')) {
                  return {
                    'hypeIndex': parsed['hypeIndex'] is num ? (parsed['hypeIndex'] as num).toInt() : 80,
                    'title': parsed['title']?.toString() ?? 'Duelo Gigante',
                    'rivalryScore': parsed['rivalryScore'] is num ? (parsed['rivalryScore'] as num).toInt() : 75,
                    'analysis': parsed['analysis']?.toString() ?? '',
                    'prediction': parsed['prediction']?.toString() ?? '',
                  };
                }
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('AI Hype Service failure, using fallback: $e');
    }

    // High fidelity Fallback system for offline / errors
    return _generateOfflineFallback(homeTeam, awayTeam, isEn);
  }

  static Map<String, dynamic> _generateOfflineFallback(
    String home,
    String away,
    bool isEn,
  ) {
    final homeLower = home.toLowerCase();
    final awayLower = away.toLowerCase();

    bool matches(String a, String b) {
      return (homeLower.contains(a) && awayLower.contains(b)) ||
             (homeLower.contains(b) && awayLower.contains(a));
    }

    // 1. Classic Lakers vs Celtics
    if (matches('laker', 'celtic')) {
      return {
        'hypeIndex': 98,
        'title': isEn 
            ? "Classic War: Purple & Gold vs Green Empire" 
            : "Guerra Clássica: Roxo & Dourado contra o Império Verde",
        'rivalryScore': 100,
        'analysis': isEn
            ? "This is the most legendary matchup in NBA history. With a combined 34 championships, the rivalry that ignited with Magic Johnson and Larry Bird and was redefined by Kobe Bryant and Paul Pierce remains electric. Every game between these franchises is more than just basketball; it is a battle for historic league supremacy. Expect relentless defensive intensity from both sides."
            : "Este é o confronto mais lendário da história da NBA. Com 34 campeonatos combinados, a rivalidade que começou com Magic Johnson e Larry Bird e foi redefinida por Kobe Bryant e Paul Pierce continua viva. Cada jogo entre estas franquias é mais do que basquetebol; é uma batalha pela supremacia histórica da liga. Espera-se uma intensidade defensiva implacável de ambos os lados.",
        'prediction': isEn
            ? "Celtics win by 4 points after a dramatic overtime driven by a titanic performance in the fourth quarter."
            : "Celtics vencem por 4 pontos após um prolongamento dramático conduzido por uma exibição titânica no quarto período.",
      };
    }

    // 2. Warriors vs Cavs
    if (matches('warrior', 'cavalier') || matches('warrior', 'cavs')) {
      return {
        'hypeIndex': 92,
        'title': isEn 
            ? "The Battle of the Modern Finals" 
            : "A Batalha das Finais Modernas",
        'rivalryScore': 94,
        'analysis': isEn
            ? "A modern rivalry defined by four epic consecutive NBA Finals between 2015 and 2018. The dynamic, high-passing style of Golden State meets the physical resilience of Cleveland. Even with new rosters, the ghost of historic battles in Ohio and San Francisco guarantees an electrifying atmosphere and plenty of healthy competition."
            : "Uma rivalidade moderna definida por quatro finais consecutivas épicas entre 2015 e 2018. O basquetebol dinâmico e de passes rápidos de Golden State encontra a resiliência física de Cleveland. Mesmo com novos elencos, o fantasma das batalhas históricas no pavilhão de Ohio e de San Francisco garante um ambiente eletrizante e muita provocação saudável.",
        'prediction': isEn
            ? "Warriors win with a barrage of three-pointers in the closing minutes, overcoming the Cavs by 6 points."
            : "Warriors vencem com uma chuva de triplos nos minutos finais, superando os Cavs por 6 pontos.",
      };
    }

    // 3. Lakers vs Clippers
    if (matches('laker', 'clipper')) {
      return {
        'hypeIndex': 89,
        'title': isEn 
            ? "The Battle of Los Angeles" 
            : "A Batalha de Los Angeles",
        'rivalryScore': 87,
        'analysis': isEn
            ? "Supremacy of the Crypto.com Arena is on the line. While the Lakers hold the championship banners in the rafters, the Clippers always enter with an extra chip on their shoulder to prove the city belongs to them too. It is a highly physical matchup where stars on both sides know each other deeply and leave everything on the floor."
            : "A supremacia do Crypto.com Arena está em jogo. Embora os Lakers tenham as faixas de campeão no teto, os Clippers sempre entram com um chip extra no ombro para provar que a cidade também lhes pertence. É um confronto físico, onde as estrelas das duas equipas se conhecem profundamente e dão tudo pela vitória.",
        'prediction': isEn
            ? "Lakers win by 2 points courtesy of a crucial last-second defensive block."
            : "Lakers vencem por 2 pontos graças a um desarme crucial no último segundo.",
      };
    }

    // 4. Generic dynamic generator
    final int hash = (home.length + away.length) % 15;
    final int hypeIndex = 75 + (hash * 37) % 21; // 75 to 95
    final int rivalryScore = 65 + (hash * 13) % 31; // 65 to 95

    final String title = isEn ? "High-Stakes Showdown" : "Confronto de Alta Tensão";
    
    final String analysis;
    final String prediction;

    if (hash % 2 == 0) {
      analysis = isEn
          ? "Tonight's clash promises to set the court on fire! $home and $away face off in a high-level strategic duel. With both teams focused on solidifying their position, every possession will be crucial. Expect a fast-paced game with lightning-quick offensive transitions."
          : "O embate de hoje promete incendiar a quadra! $home e $away defrontam-se num duelo estratégico de alto nível. Com ambas as equipas focadas em consolidar a sua posição na tabela, cada posse de bola será crucial. Espera-se um jogo rápido e de transição ofensiva fulminante.";
      prediction = isEn
          ? "$home wins by 5 points after dominating the defensive rebounds and transition game."
          : "$home vence por 5 pontos, dominando os ressaltos defensivos e o jogo de transição.";
    } else {
      analysis = isEn
          ? "A fascinating tactical matchup awaits. The defensive solidity of the $home will be put to the test by the versatile offensive arsenal of the $away. Coaches have prepared detailed adjustments, and the battle in the paint will be key."
          : "Um confronto tático fascinante aguarda-nos. A solidez defensiva dos $home vai ser posta à prova pelo arsenal ofensivo versátil dos $away. Os treinadores prepararam ajustes minuciosos e a batalha na zona pintada será determinante para ditar o rumo da partida.";
      prediction = isEn
          ? "$away secures a narrow 3-point victory in a thrilling finish down to the final possession."
          : "$away garante uma vitória tangencial por 3 pontos num final impróprio para cardíacos decidido no último segundo.";
    }

    return {
      'hypeIndex': hypeIndex,
      'title': title,
      'rivalryScore': rivalryScore,
      'analysis': analysis,
      'prediction': prediction,
    };
  }
}
