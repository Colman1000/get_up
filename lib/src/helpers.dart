class Helpers {
  static String toCamelCase(String str) {
    return str.replaceAllMapped(
        RegExp(r'(^|_)([a-zA-Z])'), (Match m) => m[2]?.toUpperCase() ?? '');
  }

  static String toSnakeCase(String str) {
    return str.replaceAllMapped(RegExp(r'([a-z])([A-Z])'),
        (Match m) => '${m[1]}_${m[2]?.toLowerCase()}');
  }

  static String toPascalCase(String str) {
    return str.replaceAllMapped(
        RegExp(r'(_|-)([a-zA-Z])'), (Match m) => m[2]?.toUpperCase() ?? '');
  }

  static String fromSnakeCaseToCamelCase(String str) {
    return str.replaceAllMapped(
        RegExp(r'(_|-)([a-zA-Z])'), (Match m) => m[2]?.toUpperCase() ?? '');
  }

  static String fromSnakeCaseToPascalCase(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}'.replaceAllMapped(
        RegExp(r'(_|-)([a-zA-Z])'), (Match m) => m[2]?.toUpperCase() ?? '');
  }

  static String fromSnakeCaseWordCase(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}'.replaceAllMapped(
        RegExp(r'(_|-)([a-zA-Z])'), (Match m) => ' ${m[2]?.toUpperCase()}');
  }
}
