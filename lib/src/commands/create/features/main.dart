import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';

class MainFeature extends FeatureBuilder {
  MainFeature(NewApp app) : super(app);

  @override
  String get name => feature;

  static String get feature => 'main';

  @override
  String get filePath => 'lib${sep}main.dart';

  @override
  Future run() async {
    final f = await createFile(filePath);
    f.writeAsStringSync('', flush: true);
    await append(f, '''
import 'package:flutter/material.dart';
import 'package:$appName/app.dart';

main() {
  runApp(const App());
}

    ''');
  }
}
