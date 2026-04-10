import 'package:flutter/foundation.dart' show kIsWeb;

import '../config/constants.dart';

/// HTTP `Origin` / referer context for EmailJS and similar APIs.
/// On web, uses the current page origin (works on GitHub Pages and localhost).
/// On mobile/desktop, uses [AppConstants.productionSiteOrigin] for EmailJS allowlists.
String requestOriginHeader() {
  if (kIsWeb) {
    try {
      return Uri.base.origin;
    } catch (_) {
      return AppConstants.productionSiteOrigin;
    }
  }
  return AppConstants.productionSiteOrigin;
}
