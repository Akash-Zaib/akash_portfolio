/// Normalizes pubspec asset keys for [Image.asset]. Keeps the full `assets/...`
/// path on web so requests match files under `build/web/assets/` (stripping caused 404s on GitHub Pages).
String assetPathForImage(String path) {
  var p = path.replaceAll('\\', '/').trim();
  while (p.startsWith('assets/assets/')) {
    p = p.replaceFirst('assets/assets/', 'assets/');
  }
  if (p.startsWith('assets/')) {
    return p;
  }
  return 'assets/$p';
}
