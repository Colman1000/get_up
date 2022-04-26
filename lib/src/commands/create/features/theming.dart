import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';

class ThemeFeature extends FeatureBuilder {
  ThemeFeature(NewApp app) : super(app);

  @override
  String get name => feature;

  static String get feature => 'theme';

  @override
  String get filePath => 'lib${sep}config${sep}theme.dart';

  @override
  Future run() async {
    final f = await createFile(filePath);
    await append(f, '''

import 'package:flutter/material.dart';

class CustomTheme {

  static final _light = ThemeData.light();
  
  static final _dark = ThemeData.dark();

  static ThemeData get light => _light;

  static ThemeData get dark => _dark;
  
  ///TODO: implement theme persistence
  static ThemeMode get themeMode => ThemeMode.light;
 
}

    ''');
  }
}
