import 'package:get_up/src/helpers.dart';
import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';

import 'intl.dart';
import 'routes.dart';
import 'theming.dart';

class AppFeature extends FeatureBuilder {
  AppFeature(NewApp app) : super(app);

  @override
  String get name => feature;

  static String get feature => 'app';

  List<String> get featuresNames => app.features.map((f) => f.name).toList();

  @override
  String get filePath => 'lib${sep}app.dart';

  @override
  Future run() async {
    final f = await createFile(filePath);
    f.writeAsStringSync('', flush: true);
    await append(f, '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

${featuresNames.contains(ThemeFeature.feature) ? "import 'package:$appName/config/theme.dart';" : ''}
${featuresNames.contains(RoutesFeature.feature) ? "import 'package:$appName/config/routes.dart';" : ''}
${featuresNames.contains(IntlFeature.feature) ? "import 'package:$appName/config/intl.dart';" : ''}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    title: '${Helpers.fromSnakeCaseWordCase(appName)}',
    ${!featuresNames.contains(RoutesFeature.feature) ? ''''
    home: Scaffold(
        body: Center(
          child: Text(
            'Hello, ${Helpers.fromSnakeCaseWordCase(appName)}!',
            style: TextStyle(
              fontSize: 24
            ),
          ),
        ),
      ),
    ''' : ''}
      ${featuresNames.contains(ThemeFeature.feature) ? '''
    theme: CustomTheme.light,
    darkTheme: CustomTheme.dark,
    themeMode: CustomTheme.themeMode,
    
    ''' : ''}
      ${featuresNames.contains(RoutesFeature.feature) ? ''' getPages: Routes.all,
      initialRoute: Routes.initial,
      
      ''' : ''}
      ${featuresNames.contains(IntlFeature.feature) ? '''translations: Intl(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      // supportedLocales: [
      //   const Locale('en', 'US'),
      //   const Locale('ru', 'RU'),
      // ],
      
      ''' : ''}
    );
  }
}

    ''');
  }
}
