import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:get_up/src/commands/create/features/pub.dart';
import 'package:get_up/src/commands/create/features/test.dart';
import 'package:get_up/src/helpers.dart';
import 'package:get_up/src/models/new_app.dart';
import 'package:interact/interact.dart';
import 'package:shell/shell.dart';

import 'features/app.dart';
import 'features/main.dart';

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

    final app = NewApp(appName, workingDir: Directory.current.path);

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
      app.platforms = MultiSelect(
        prompt: "Platforms",
        options: NewApp.supportedPlatforms,
        defaults: [true, true, true, false, false, false],
      ).interact().map(NewApp.supportedPlatforms.elementAt).toList();

      //Features
      final _features = app.supportedFeatures.map((e) => e.name).toList();
      app.features = MultiSelect(
        prompt: "Features",
        options: _features,
        defaults: _features.map((_) => true).toList(),
      ).interact().map(app.supportedFeatures.elementAt).toList();
    }

    //Create App
    try {
      final _ = MultiSpinner();
      final shell = Shell();
      //-------------------------------------------------------------------

      final create = _.add(
        Spinner(
          icon: '🏆',
          leftPrompt: (done) => done ? 'Create App  ' : '',
          rightPrompt: (done) => done ? '✔' : 'Creating ${app.projectName}...',
        ),
      );

      await shell.run('flutter', arguments: [
        'create',
        app.projectName,
        '--org',
        app.org,
        '--description',
        app.description,
        '--platforms',
        app.platforms.join(','),
      ]);
      //-------------------------------------------------------------------

      final setup = _.add(
        Spinner(
          icon: '🎈',
          leftPrompt: (done) => done ? 'Setup       ' : '',
          rightPrompt: (done) => done ? '✔' : 'Setting things up...',
        ),
      );
      await furnish(app);

      //-------------------------------------------------------------------

      final pub = _.add(
        Spinner(
          icon: '🍻',
          leftPrompt: (done) => done ? 'Update      ' : '',
          rightPrompt: (done) => done ? '✔' : 'Downloading dependencies',
        ),
      );

      shell.navigate(app.projectPath);

      await shell.run('flutter', arguments: ['pub', 'get']);

      //-------------------------------------------------------------------
      final format = _.add(
        Spinner(
          icon: '📝',
          leftPrompt: (done) => done ? 'Format      ' : '',
          rightPrompt: (done) => done
              ? '✔\n\n\nTo run your app: \n\ncd ${app.projectName} && flutter run\n\n'
              : 'Formatting project...',
        ),
      );

      await shell.run('dart', arguments: ['format', '.']);
      //-------------------------------------------------------------------

      create.done();
      setup.done();
      pub.done();
      format.done();
    } catch (e) {
      reset(); // Reset everything to terminal defaults
      rethrow;
    }
  }

  Future furnish(NewApp app) async {
    Future.wait([
      ...app.features.map((e) => e.run()),
      TestFeature(app).run(),
      MainFeature(app).run(),
      AppFeature(app).run(),
      PubFeature(app).run(),
    ]);
  }
}
