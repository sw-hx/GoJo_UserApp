import 'package:url_launcher/url_launcher.dart';

class OpenMapService {
  static Future<void> openMapFromUrl(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      final webUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$url',
      );
      await launchUrl(webUri);
    }
  }
}
