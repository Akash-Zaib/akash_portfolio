import 'package:flutter/foundation.dart' show kIsWeb;

/// Resolves a pubspec asset path for [Image.asset] / [AssetImage].
///
/// On **web**, the engine prepends `assets/` when fetching; passing
/// `assets/images/foo.png` becomes a broken `assets/assets/images/foo.png`.
/// Web therefore uses the key **without** the leading `assets/` segment
/// (e.g. `images/foo.png`). Mobile/desktop use the full key
/// `assets/images/foo.png`.
String assetPathForImage(String path) {
  var p = path.replaceAll('\\', '/').trim();
  while (p.startsWith('assets/assets/')) {
    p = p.replaceFirst('assets/assets/', 'assets/');
  }
  if (kIsWeb && p.startsWith('assets/')) {
    return p.substring('assets/'.length);
  }
  if (p.startsWith('assets/')) {
    return p;
  }
  return 'assets/$p';
}
