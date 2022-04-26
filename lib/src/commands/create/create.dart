import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:get_up/src/helpers.dart';
import 'package:get_up/src/models/new_app.dart';
import 'package:interact/interact.dart';

class CreateCommand extends Command {
  @override
  final name = "create";

  @override
  final description =
      "Creates scaffolds for a flutter app preconfigured with GetX";

  CreateCommand() {
    argParser.addFlag(
      'defaults',
      abbr: 'd',
      help:
          'When set, getup creates app with defaults without requiring any input from user',
      defaultsTo: false,
    );
  }

  @override
  void run() async {
    final appName =
        Helpers.toSnakeCase((argResults?.rest.first ?? 'new_app').toString());

    final app = NewApp(appName);

    if (argResults?['defaults'] == false) {
      app.projectName = Helpers.toSnakeCase(
        Input(
          prompt: "Project name",
          defaultValue: appName,
          validator: (v) => v.isNotEmpty,
        ).interact(),
      );

      //Description
      final _desc = Input(
        prompt: "Description",
      ).interact();

      app.description = _desc.isNotEmpty ? _desc : app.description;

      //Domain
      app.org = Helpers.toSnakeCase(
        Input(
          prompt: "Domain - prepended to '.${app.projectName}' as your App ID",
          defaultValue: app.org,
          validator: (v) => v.isNotEmpty,
        ).interact(),
      );

      //Platforms
      final _platforms = ['ios', 'android', 'web', 'windows', 'macos', 'linux'];
      app.platforms = MultiSelect(
        prompt: "Platforms",
        options: _platforms,
        defaults: [true, true, true, false, false, false],
      ).interact().map(_platforms.elementAt).join(',');
    }

    //Create App

    final flutterCreate = Spinner(
      icon: '🏆',
      leftPrompt: (done) => '', // prompts are optional
      rightPrompt: (done) => done
          ? 'App created!\n\n cd ${app.projectName} && flutter run'
          : 'Creating your app...',
    ).interact();

    final _ = Process.runSync('flutter', [
      'create',
      app.projectName,
      '--org',
      app.org,
      '--description',
      app.description,
      '--template',
      'skeleton'
    ]);

    flutterCreate.done();
  }
}
