import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageService {
  // Converte qualquer imagem para WebP e guarda localmente
  static Future<String?> convertToWebP(File imageFile) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.webp';
      final targetPath = p.join(dir.path, 'images', fileName);

      // Cria a pasta se não existir
      await Directory(p.join(dir.path, 'images')).create(recursive: true);

      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        format: CompressFormat.webp,
        quality: 85,
      );

      return result?.path;
    } catch (e) {
      return null;
    }
  }

  // Converte imagem a partir de bytes (ex: imagem da câmara)
  static Future<File?> convertBytesToWebP(
    List<int> bytes,
    String fileName,
  ) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final tempPath = p.join(dir.path, 'images', 'temp_$fileName');
      final targetPath = p.join(
        dir.path,
        'images',
        '${DateTime.now().millisecondsSinceEpoch}.webp',
      );

      await Directory(p.join(dir.path, 'images')).create(recursive: true);

      // Guarda temporariamente
      final tempFile = File(tempPath);
      await tempFile.writeAsBytes(bytes);

      // Converte para WebP
      final result = await FlutterImageCompress.compressAndGetFile(
        tempPath,
        targetPath,
        format: CompressFormat.webp,
        quality: 85,
      );

      // Apaga o ficheiro temporário
      await tempFile.delete();

      return result != null ? File(result.path) : null;
    } catch (e) {
      return null;
    }
  }

  // Calcula a redução de tamanho
  static String getSizeReduction(int originalBytes, int compressedBytes) {
    final reduction = ((originalBytes - compressedBytes) / originalBytes * 100)
        .toStringAsFixed(1);
    return '$reduction% menor';
  }
}
