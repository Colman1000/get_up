import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';

class AssetFeature extends FeatureBuilder {
  AssetFeature(NewApp app) : super(app);

  String get name => feature;

  static String get feature => 'assets';

  @override
  String get filePath => 'lib${sep}config${sep}assets.dart';

  @override
  Future run() async {
    final f = await createFile(filePath);
    await append(f, '''
class Assets {
  const Assets._(); // this basically makes it so you can't instantiate this class
  
  //static const String asset1 = 'path/to/asset1.png';
}
    ''');
  }
}
