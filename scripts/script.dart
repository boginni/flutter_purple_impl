import 'dart:io';

void main() {
  final libDir = Directory('lib');

  if (!libDir.existsSync()) {
    print('Error: "lib" directory not found.');
    return;
  }

  // Paths to the barrel files inside presenter
  final domainBarrel = File('lib/flutter_purple_impl.dart');

  // 1. Process Domain Exports
  final domainFiles = _getDartFiles(Directory('lib/src'));
  _writeExports(domainBarrel, domainFiles);

  print('Successfully updated barrel files in lib/presenter/');
}

/// Recursively finds all .dart files in a directory,
/// excluding the directory's own barrel file if it exists.
List<String> _getDartFiles(Directory dir) {
  if (!dir.existsSync()) return [];

  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .map((file) => file.path)
      .toList();
}

/// Writes the export statements to the target file.
void _writeExports(File target, List<String> filePaths) {
  if (filePaths.isEmpty) {
    print('No files found for src');
    return;
  }

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED FILE - DO NOT EDIT');

  for (var path in filePaths) {
    final relativeFromLib = path.replaceFirst('lib/', '').replaceAll(r'\', '/');
    buffer.writeln("export '$relativeFromLib';");
  }

  target.writeAsStringSync(buffer.toString());
  print('Updated ${target.path} with ${filePaths.length} exports.');
}
