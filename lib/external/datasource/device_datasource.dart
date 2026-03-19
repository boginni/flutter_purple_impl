import 'package:flutter/services.dart';

class DeviceDatasource  {
  const DeviceDatasource();

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    );
  }

  Future<String?> getClipboardData() async {
    final data = await Clipboard.getData('text/plain');
    return data?.text;
  }
}
