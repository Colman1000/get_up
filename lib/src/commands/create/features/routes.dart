import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';

class RoutesFeature extends FeatureBuilder {
  RoutesFeature(NewApp app) : super(app);

  @override
  String get name => feature;

  static String get feature => 'routes';

  @override
  String get filePath => 'lib${sep}config${sep}routes.dart';

  @override
  Future run() async {
    final f = await createFile(filePath);
    await append(f, '''
import 'package:get/get.dart';

class Routes {
  static final List<GetPage> all = [];
  static final String initial = '';
}

    ''');

    ///TODO: [ADD] Home route
  }
}
