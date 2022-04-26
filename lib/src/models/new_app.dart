class NewApp {
  /*

  -v, --verbose             Noisy logging, including all shell commands executed.

    --[no-]offline           When "flutter pub get" is run by the create command, this indicates whether to run it in offline mode or not. In offline mode, it will need to have all
    --[no-]overwrite         When performing operations, overwrite existing files.
    --description            The description to use for your new Flutter project. This string ends up in the pubspec.yaml file.
                             (defaults to "A new Flutter project.")
    --org                    The organization responsible for your new Flutter project, in reverse domain name notation. This string is used in Java package names and as prefix in the iOS
                             bundle identifier.
                             (defaults to "com.example")
    --project-name           The project name for this new Flutter project. This must be a valid dart package name.
-i, --ios-language           The language to use for iOS-specific code, either ObjectiveC (legacy) or Swift (recommended).
                             [objc, swift (default)]
-a, --android-language       The language to use for Android-specific code, either Java (legacy) or Kotlin (recommended).
                             [java, kotlin (default)]
    --platforms              The platforms supported by this project. Platform folders (e.g. android/) will be generated in the target project. This argument only works when "--template" is
                             set to app or plugin. When adding platforms to a plugin project, the pubspec.yaml will be updated with the requested platform. Adding desktop platforms requires
                             the corresponding desktop config setting to be enabled.
                             [ios (default), android (default), windows (default), linux (default), macos (default), web (default)]
-t, --template=<type>        Specify the type of project to create.

          [app]              (default) Generate a Flutter application.
          [module]           Generate a project to add a Flutter module to an existing Android or iOS application.
          [package]          Generate a shareable Flutter project containing modular Dart code.
          [plugin]           Generate a shareable Flutter project containing an API in Dart code with a platform-specific implementation for Android, for iOS code, or for both.
          [skeleton]         Generate a List View / Detail View Flutter application that follows community best practices.

   */

  bool verbose;
  bool offline;
  bool overwrite;
  String description;
  String org;
  String projectName;
  String iosLang;
  String androidLang;
  String platforms;

  NewApp(
    this.projectName, {
    this.description = "A new Flutter project.",
    this.org = 'com.example',
    this.iosLang = 'swift',
    this.androidLang = 'kotlin',
    this.platforms = 'ios,android,windows,linux,macos,web',
    this.verbose = false,
    this.offline = false,
    this.overwrite = false,
  });
}
