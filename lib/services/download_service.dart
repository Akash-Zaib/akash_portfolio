import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class DownloadService {
  static Future<bool> downloadFile(String path, String fileName) async {
    try {
      if (kIsWeb) {
        return await _downloadForWeb(path);
      } else {
        return await _downloadForMobile(path);
      }
    } catch (e) {
      debugPrint('Download error: $e');
      return false;
    }
  }

  static Future<bool> _downloadForWeb(String path) async {
    try {
      final uri = Uri.parse(path);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _downloadForMobile(String path) async {
    try {
      // For mobile, try to open the file or URL
      final uri = Uri.parse(path);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

void debugPrint(String message) {
  // ignore: avoid_print
  print(message);
}
