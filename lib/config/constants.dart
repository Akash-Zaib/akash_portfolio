/// App-wide constants. For production EmailJS keys, prefer build-time defines (see below).
class AppConstants {
  /// Public site URL (EmailJS allowed origins, fallbacks). No trailing slash.
  /// Update if you use a custom domain.
  static const String productionSiteOrigin = 'https://akash-zaib.github.io';

  // Personal Information
  static const String name = 'Akash Zaib Malik';
  static const String role = 'Mobile App Developer (Flutter)';
  static const String phone = '+923056838083';
  static const String email = 'akashzaib61@gmail.com';
  static const String location = 'Islamabad, Pakistan';

  // Social Links
  static const String linkedInUrl =
      'https://www.linkedin.com/in/akash-zaib-malik-0a1968248';
  static const String githubUrl = 'https://github.com/Akash-Zaib';
  static const String whatsAppNumber = '923056838083';

  // Education
  static const String degree = 'BS in Computer Science';
  static const String university = 'Government College University, Faisalabad';
  static const String cgpa = '3.43/4';

  /// Hero / home section profile photo (see `assets/images/`)
  static const String heroProfileImage = 'assets/images/image.jpg';

  // CV — folder for viewing in browser; direct download uses Drive’s uc endpoint
  // (see https://www.howtogeek.com/747810/how-to-make-a-direct-download-link-for-google-drive-files/).
  static const String _cvFolderId = '1PmxifEjghwDZPkYJdQrz-NxebpPvmSUK';

  static const String cvPath =
      'https://drive.google.com/drive/folders/$_cvFolderId?usp=sharing';

  static const String cvFileName = 'Akash_Zaib_Malik_CV.pdf';

  /// Direct download. For a single PDF, prefer that file’s ID (from
  /// `.../file/d/FILE_ID/view`); folder IDs may not download as one file.
  static const String cvDownloadUrl =
      'https://drive.google.com/uc?id=$_cvFolderId&export=download';

  // EmailJS — set in EmailJS dashboard, then either:
  // 1) Replace defaults below, or
  // 2) Build with: flutter build web --dart-define=EMAILJS_SERVICE_ID=... (same for TEMPLATE and PUBLIC_KEY)
  static const String emailJsServiceId = String.fromEnvironment(
    'EMAILJS_SERVICE_ID',
    defaultValue: 'YOUR_SERVICE_ID',
  );
  static const String emailJsTemplateId = String.fromEnvironment(
    'EMAILJS_TEMPLATE_ID',
    defaultValue: 'YOUR_TEMPLATE_ID',
  );
  static const String emailJsPublicKey = String.fromEnvironment(
    'EMAILJS_PUBLIC_KEY',
    defaultValue: 'YOUR_PUBLIC_KEY',
  );
  static const String emailJsUrl =
      'https://api.emailjs.com/api/v1.0/email/send';

  /// True when EmailJS placeholders are still unset (contact form will not work).
  static bool get isEmailJsConfigured =>
      emailJsServiceId != 'YOUR_SERVICE_ID' &&
      emailJsTemplateId != 'YOUR_TEMPLATE_ID' &&
      emailJsPublicKey != 'YOUR_PUBLIC_KEY';

  /// Shown when user tries to send but EmailJS is not set up (English; configure l10n later if needed).
  static const String emailJsNotConfiguredMessage =
      'Message sending is not configured. Add EmailJS keys in AppConstants or build with --dart-define.';

  // Skill Tags for Hero Section
  static const List<String> heroTags = [
    'Flutter',
    'Dart',
    'Firebase',
    'FlutterFlow',
  ];

  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Spacing
  static const double spacingXS = 4;
  static const double spacingSM = 8;
  static const double spacingMD = 16;
  static const double spacingLG = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
  static const double spacingXXXL = 64;

  // Border Radius
  static const double radiusSM = 8;
  static const double radiusMD = 12;
  static const double radiusLG = 16;
  static const double radiusXL = 24;

  // Max Content Width
  static const double maxContentWidth = 1200;
}

// WhatsApp URL generator
String getWhatsAppUrl([String? message]) {
  final defaultMessage =
      message ?? 'Hello! I found your portfolio and would like to connect.';
  final encodedMessage = Uri.encodeComponent(defaultMessage);
  return 'https://wa.me/${AppConstants.whatsAppNumber}?text=$encodedMessage';
}
