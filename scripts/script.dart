import 'dart:io';

void main() {
  final libDir = Directory('lib');

  if (!libDir.existsSync()) {
    print('Error: "lib" directory not found.');
    return;
  }

  final externalBarrel = File('lib/presenter/external.dart');

  final externalFiles = _getDartFiles(Directory('lib/external'));
  _writeExports(externalBarrel, externalFiles, 'external');

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
void _writeExports(File target, List<String> filePaths, String folderName) {
  if (filePaths.isEmpty) {
    print('No files found for $folderName.');
    return;
  }

  // Convert absolute/lib paths to relative paths from lib/presenter/
  // Since we are in lib/presenter/file.dart, we go up one level to lib/
  // then into the target folder.
  final buffer = StringBuffer();
  buffer.writeln('// Generated Barrel File for $folderName');

  for (var path in filePaths) {
    // Normalize path and remove 'lib/' prefix to make it relative to the root of lib
    final relativeFromLib = path.replaceFirst('lib/', '').replaceAll(r'\', '/');
    buffer.writeln("export '../$relativeFromLib';");
  }

  target.writeAsStringSync(buffer.toString());
  print('Updated ${target.path} with ${filePaths.length} exports.');
}
