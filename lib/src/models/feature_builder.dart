import 'dart:io';

import 'new_app.dart';

abstract class FeatureBuilder<T> {
  FeatureBuilder(this.app);

  final NewApp app;

  String get sep => app.sep;

  String get appName => app.projectName;

  String get filePath;

  String get name;

  Future<T> run();

  Future<File> createFile(String path) async {
    final _ = File('${app.projectPath}$path');
    if (_.existsSync()) {
      return _;
    }

    await _.create(recursive: true);
    return _;
  }

  Future<File> append(File f, String content) async {
    return f.writeAsString(content, mode: FileMode.append, flush: true);
  }
}
