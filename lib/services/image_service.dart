import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImageService {
  static Future<Directory> _imagesDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(dir.path, 'images'));
    await imagesDir.create(recursive: true);
    return imagesDir;
  }

  static String safeFileName(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');

  static Future<String?> convertToWebP(File imageFile) async {
    try {
      final imagesDir = await _imagesDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.webp';
      final targetPath = p.join(imagesDir.path, fileName);

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

  static Future<File?> convertBytesToWebP(
    List<int> bytes,
    String fileName,
  ) async {
    try {
      final imagesDir = await _imagesDirectory();
      final tempPath = p.join(imagesDir.path, 'temp_$fileName');
      final targetPath = p.join(
        imagesDir.path,
        '${DateTime.now().millisecondsSinceEpoch}.webp',
      );

      final tempFile = File(tempPath);
      await tempFile.writeAsBytes(bytes);

      final result = await FlutterImageCompress.compressAndGetFile(
        tempPath,
        targetPath,
        format: CompressFormat.webp,
        quality: 85,
      );

      await tempFile.delete();

      return result != null ? File(result.path) : null;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> downloadUrlAsWebP(
    String url, {
    required String fileName,
  }) async {
    File? tempFile;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return null;
      }

      final imagesDir = await _imagesDirectory();
      final safeName = safeFileName(fileName);
      final tempPath = p.join(imagesDir.path, '$safeName.source');
      final targetPath = p.join(imagesDir.path, '$safeName.webp');

      tempFile = File(tempPath);
      await tempFile.writeAsBytes(response.bodyBytes);

      final result = await FlutterImageCompress.compressAndGetFile(
        tempPath,
        targetPath,
        format: CompressFormat.webp,
        quality: 85,
      );

      return result?.path;
    } catch (e) {
      return null;
    } finally {
      if (tempFile != null && await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }

  static String getSizeReduction(int originalBytes, int compressedBytes) {
    final reduction = ((originalBytes - compressedBytes) / originalBytes * 100)
        .toStringAsFixed(1);
    return '$reduction% menor';
  }
}
