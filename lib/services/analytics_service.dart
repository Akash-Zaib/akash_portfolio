import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

/// Centralized Firebase Analytics helpers for the portfolio app.
class AnalyticsService {
  AnalyticsService._();

  static FirebaseAnalytics? get _analytics =>
      Firebase.apps.isEmpty ? null : FirebaseAnalytics.instance;

  static Future<void> _run(Future<void> Function(FirebaseAnalytics a) fn) async {
    final a = _analytics;
    if (a == null) return;
    try {
      await fn(a);
    } catch (_) {
      // Ignore analytics failures (offline, disabled, etc.)
    }
  }

  static Future<void> logProjectTap(String projectId) {
    return _run(
      (a) => a.logEvent(
        name: 'portfolio_project_tap',
        parameters: {'project_id': projectId},
      ),
    );
  }

  static Future<void> logProjectDetailView(String projectId) async {
    await _run((a) async {
      await a.logScreenView(
        screenName: 'project_detail',
        screenClass: 'ProjectDetailScreen',
      );
      await a.logEvent(
        name: 'portfolio_project_view',
        parameters: {'project_id': projectId},
      );
    });
  }

  static Future<void> logCvDownload() {
    return _run((a) => a.logEvent(name: 'portfolio_cv_download'));
  }

  /// Outbound actions: github, linkedin, whatsapp, email, phone, online_cv, etc.
  static Future<void> logLinkOpen(String linkType) {
    return _run(
      (a) => a.logEvent(
        name: 'portfolio_link_open',
        parameters: {'link_type': linkType},
      ),
    );
  }

  /// In-app scroll to section: [source] e.g. top_nav, mobile_menu, hero_contact.
  static Future<void> logSectionNavigate(String section, String source) {
    return _run(
      (a) => a.logEvent(
        name: 'portfolio_section_nav',
        parameters: {
          'section': section,
          'source': source,
        },
      ),
    );
  }

  /// Contact form submitted successfully (no PII in parameters).
  static Future<void> logContactSubmitSuccess() {
    return _run(
      (a) => a.logEvent(
        name: 'portfolio_contact_submit',
        parameters: {'success': 1},
      ),
    );
  }

  /// Foreground time for the segment ending when app went to background (seconds).
  static Future<void> logForegroundSegmentSeconds(int durationSec) {
    if (durationSec <= 0) return Future.value();
    return _run(
      (a) => a.logEvent(
        name: 'portfolio_foreground_segment',
        parameters: {'duration_sec': durationSec},
      ),
    );
  }
}
