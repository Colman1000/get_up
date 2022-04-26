import 'package:args/command_runner.dart';

import 'sub_commands/screen.dart';

class AddCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = "add";
  @override
  final description = "Generate files for [Views], [Models] ...";

  AddCommand() {
    addSubcommand(ScreenCommand());
  }
}
