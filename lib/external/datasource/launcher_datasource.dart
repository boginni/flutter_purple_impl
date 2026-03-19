import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vector_math/vector_math.dart';

class LauncherDatasource {
  Future<void> openBrowser(String url) async {
    final bool hasOpened = await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!hasOpened) {
      throw Exception();
    }
  }

  Future<void> openMapApp(Vector2 position) async {
    late final String url;

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      url = 'http://maps.apple.com/?ll=${position.x},${position.y}';
    } else {
      url =
          'geo:${position.x},${position.y}'
          '?q=${position.x},${position.y}';
    }

    final bool hasOpened = await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!hasOpened) {
      throw Exception();
    }
  }

  Future<void> openMailApp(String email) {
    throw UnimplementedError();
  }

  Future<void> openSettings() {
    throw UnimplementedError();
  }
}
