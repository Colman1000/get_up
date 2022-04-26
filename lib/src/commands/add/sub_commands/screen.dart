import 'package:args/command_runner.dart';

class ScreenCommand extends Command {
  // The [name] and [description] properties must be defined by every
  // subclass.
  @override
  final name = "screen";
  @override
  final description = "Record changes to the repository.";

  ScreenCommand() {
    // we can add command specific arguments here.
    // [argParser] is automatically created by the parent class.
    argParser.addOption('name', abbr: 'n', help: 'The name of the screen.');
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the flags/options
    // passed to this command.
    // debugPrint(argResults?.rest);
  }
}
