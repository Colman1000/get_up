import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';

class TestFeature extends FeatureBuilder {
  TestFeature(NewApp app) : super(app);

  String get name => feature;

  static String get feature => 'test';

  @override
  String get filePath => 'test${sep}widget_test.dart';

  @override
  Future run() async {
    final f = await createFile(filePath);
    await f.writeAsString('', flush: true);
    await append(f, '''

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:${appName}/app.dart';

void main() {
  testWidgets('Write test case', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Run tests here ...
    
  });
}

    ''');
  }
}
