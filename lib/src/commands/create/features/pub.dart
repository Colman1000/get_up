import 'dart:io';

import 'package:get_up/src/models/feature_builder.dart';
import 'package:get_up/src/models/new_app.dart';
import 'package:yaml_modify/yaml_modify.dart';

class PubFeature extends FeatureBuilder {
  PubFeature(NewApp app) : super(app);

  String get name => feature;

  static String get feature => 'pub';

  @override
  String get filePath => 'pubspec.yaml';

  @override
  Future run() async {
    final f = await createFile(filePath);

    final yaml = loadYaml(f.readAsStringSync());

    final modifiable = getModifiableNode(yaml);

    final _dep = modifiable['dependencies'] as Map<dynamic, dynamic>;
    _dep["get"] = "^4.6.1";
    modifiable['dependencies'] = _dep;

    final strYaml = toYamlString(modifiable);
    f.writeAsStringSync(strYaml, mode: FileMode.write, flush: true);
  }
}
