library get_up;

import 'package:args/command_runner.dart';
import 'package:get_up/src/commands/create/create.dart';

void main(List<String> args) {
  CommandRunner(
    "getup",
    "A Simple, Fast, and Easy CLI tool for scaffolding a GetX based application.",
  )
    ..addCommand(CreateCommand())
    ..run(args);
}
