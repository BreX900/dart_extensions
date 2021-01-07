library path_extensions;

import 'package:path/path.dart' show Context, windows;

Context pathExtensionContext = windows;

extension StringPathExtension on String {
  String getBasename() => pathExtensionContext.basename(this);

  String getBasenameWithoutExtension() => pathExtensionContext.basenameWithoutExtension(this);

  String getDirname() => pathExtensionContext.dirname(this);

  String getExtension([int level = 1]) => pathExtensionContext.extension(this, level);

  String getRootPrefix() => pathExtensionContext.rootPrefix(this);

  bool get isAbsolutePath => pathExtensionContext.isAbsolute(this);

  bool get isRelativePath => pathExtensionContext.isRelative(this);

  bool get isRootRelativePath => pathExtensionContext.isRootRelative(this);

  String joinPaths(
      [String part1,
      String part2,
      String part3,
      String part4,
      String part5,
      String part6,
      String part7]) {
    return pathExtensionContext.join(this, part1, part2, part3, part4, part5, part6, part7);
  }

  List<String> splitPath() => pathExtensionContext.split(this);

  String toCanonicalizePath() => pathExtensionContext.canonicalize(this);

  String toNormalizePath() => pathExtensionContext.normalize(this);

  String toRelativePath({String from}) => pathExtensionContext.relative(this, from: from);

  bool isWithin(String parent, String child) => pathExtensionContext.isWithin(parent, child);

  bool equalsPath(String other) => pathExtensionContext.equals(this, other);

  int hashPath() => pathExtensionContext.hash(this);

  String getWithoutExtension() => pathExtensionContext.withoutExtension(this);

  String getSettingExtension(String extension) =>
      pathExtensionContext.setExtension(this, extension);

  Uri toUri() => pathExtensionContext.toUri(this);
}

extension UrlPathExtension on Uri {
  String toPath() => pathExtensionContext.fromUri(this);

  String toPrettyPath() => pathExtensionContext.prettyUri(this);
}
