import 'package:get_up/src/helpers.dart';
import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';

class IntlFeature extends FeatureBuilder {
  IntlFeature(NewApp app) : super(app);

  String get name => feature;

  static String get feature => 'intl';

  @override
  String get filePath => 'lib${sep}config${sep}intl.dart';

  @override
  Future run() async {
    final f = await createFile(filePath);
    await append(f, '''
import 'package:get/get.dart';
    
class Intl extends Translations {
    @override
  Map<String, Map<String, String>> get keys {
    return {
      'en': {
        appName: '${Helpers.fromSnakeCaseWordCase(appName)}',
      },
      // 'ru': { appName: '${Helpers.fromSnakeCaseWordCase(appName)}', },
      // 'uk': { appName: '${Helpers.fromSnakeCaseWordCase(appName)}', },
    };
  }

  static const String appName = 'appName';
}
    ''');
  }
}
