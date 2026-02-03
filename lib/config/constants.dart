class AppConstants {
  // Personal Information
  static const String name = 'Akash Zaib Malik';
  static const String role = 'Mobile App Developer (Flutter)';
  static const String phone = '+923056838083';
  static const String email = 'akashzaib61@gmail.com';
  static const String location = 'Islamabad, Pakistan';
  
  // Social Links
  static const String linkedInUrl = 'https://www.linkedin.com/in/akash-zaib-malik-0a1968248';
  static const String githubUrl = 'https://github.com/akashzaib';
  static const String whatsAppNumber = '923056838083';
  
  // Education
  static const String degree = 'BS in Computer Science';
  static const String university = 'Government College University, Faisalabad';
  static const String cgpa = '3.43/4';
  
  // CV Path - Place your CV PDF in assets/documents/
  static const String cvPath = 'assets/documents/cv.pdf';
  static const String cvFileName = 'Akash_Zaib_Malik_CV.pdf';
  
  // EmailJS Configuration - UPDATE THESE WITH YOUR ACTUAL VALUES
  static const String emailJsServiceId = 'YOUR_SERVICE_ID';
  static const String emailJsTemplateId = 'YOUR_TEMPLATE_ID';
  static const String emailJsPublicKey = 'YOUR_PUBLIC_KEY';
  static const String emailJsUrl = 'https://api.emailjs.com/api/v1.0/email/send';
  
  // Skill Tags for Hero Section
  static const List<String> heroTags = [
    'Flutter',
    'Dart',
    'Firebase',
    'UI/UX Design',
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
  final defaultMessage = message ?? 'Hello! I found your portfolio and would like to connect.';
  final encodedMessage = Uri.encodeComponent(defaultMessage);
  return 'https://wa.me/${AppConstants.whatsAppNumber}?text=$encodedMessage';
}
