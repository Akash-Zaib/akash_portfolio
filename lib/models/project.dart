import 'package:flutter/material.dart';
import '../config/theme.dart';

class Project {
  final String id;
  final String title;

  // ─── CARD DISPLAY (Main Screen) ───
  final String shortDescription; // Brief text for card (1-2 lines)
  final String imagePath; // Card thumbnail
  final IconData icon;
  final Color accentColor;

  // ─── DETAIL PAGE ONLY ───
  final String fullDescription; // Detailed project description
  final String? role; // Your role (e.g., "Lead Flutter Developer")
  final String? duration; // Project duration (e.g., "Jan 2024 - Mar 2024")
  final String? client; // Client name (optional)
  final String heroImage;
  final List<String> galleryImages;
  final List<String> techStack;
  final List<String> features;
  final List<String> responsibilities; // What you did
  final List<String> challenges; // Challenges faced
  final List<String> results; // Outcomes/achievements
  final String? githubUrl;
  final String? liveUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;

  const Project({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.imagePath,
    required this.heroImage,
    this.role,
    this.duration,
    this.client,
    this.galleryImages = const [],
    required this.techStack,
    this.features = const [],
    this.responsibilities = const [],
    this.challenges = const [],
    this.results = const [],
    this.githubUrl,
    this.liveUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.accentColor = const Color(0xFF3B82F6),
    this.icon = Icons.code_rounded,
  });

  // Helper for backward compatibility
  String get description => shortDescription;
}

// ============================================================
// 📝 HOW TO ADD A NEW PROJECT:
// ============================================================
// 1. Copy one of the Project entries below
// 2. Change the id, title, description, and other fields
// 3. Add your images to assets/images/ folder
// 4. That's it! No need to edit any other file!
// ============================================================

final List<Project> portfolioProjects = [
  // ─────────────────────────────────────────────────────────
  // PROJECT 1: OOSC - AI Learning App
  // ─────────────────────────────────────────────────────────
  Project(
    id: 'oosc',
    title: 'OOSC - AI-Based Learning App',

    // 📱 CARD (Main Screen) - Keep it short!
    shortDescription:
        'AI-powered learning app for children with voice recognition, 3D animations, and interactive tracing modules.',

    // 📄 DETAIL PAGE - Full description
    fullDescription:
        '''Developed a fully AI-based learning mobile application for children using Flutter and Dart. This innovative educational platform combines cutting-edge AI technology with engaging interactive content to revolutionize early childhood education.

Integrated REST APIs and real-time socket connections to enable dynamic content updates and seamless communication between the app and backend. Developed the complete Admin Panel, enabling efficient management of learning content and application flow.

The application features comprehensive alphabet tracing modules for English, Urdu, and Mathematics using CustomPainter for interactive handwriting practice. Advanced voice detection and automatic speech recognition provide real-time feedback on pronunciation using Flutter plugins.

Key technical innovations include 3D GLB model animations delivering immersive learning experiences, real-time lip-syncing implemented via WebView with JavaScript and Three.js bridge integration, and smooth animated screen transitions using PageRouteBuilder and AnimatedContainer.

The architecture leverages MobX state management for scalable, clean, and maintainable code. Backend-driven navigation dynamically controls screen flow based on API responses, while SharedPreferences enables offline support for uninterrupted learning. Performance was optimized by minimizing widget rebuilds and lazy-loading assets.''',

    role: 'Flutter Developer',
    client: 'NGO/Non-profit Organization',

    imagePath: 'assets/images/oosc.png',
    heroImage: 'assets/images/project_oosc_hero.png',
    galleryImages: [
      'assets/images/project_oosc_1.png',
      'assets/images/project_oosc_2.png',
      'assets/images/project_oosc_3.png',
    ],
    techStack: [
      'Flutter',
      'Dart',
      'REST APIs',
      'WebSocket',
      'MobX',
      'Three.js',
      'WebView',
      'Rive',
      'Lottie',
      'CustomPainter',
    ],
    features: [
      'AI-based interactive learning for children',
      'Voice detection and automatic speech recognition',
      '3D GLB model animations with real-time lip-syncing',
      'Alphabet tracing (English, Urdu, Mathematics) using CustomPainter',
      'Real-time content updates via REST APIs and sockets',
      'Backend-driven dynamic navigation',
      'Offline learning support via SharedPreferences',
      'Responsive UI for mobile and tablet devices',
      'Engaging animations using Rive and Lottie',
    ],
    responsibilities: [
      'Developed complete Admin Panel for content management',
      'Implemented alphabet tracing modules using CustomPainter',
      'Built assessment and quiz screens with dynamic widgets',
      'Integrated voice detection and speech recognition plugins',
      'Created 3D GLB model animations with Three.js bridge',
      'Implemented real-time lip-syncing via WebView',
      'Designed smooth screen transitions with PageRouteBuilder',
      'Synchronized animations with audio playback',
      'Applied MobX state management architecture',
      'Optimized performance with lazy-loading and minimal rebuilds',
    ],
    challenges: [
      'Integrating 3D WebGL animations in Flutter via WebView bridge',
      'Implementing accurate speech recognition for children\'s voices',
      'Synchronizing lip-sync animations with real-time audio',
      'Supporting offline mode while maintaining dynamic content updates',
      'Optimizing performance for lower-end devices',
    ],
    accentColor: AppTheme.primaryBlue,
    icon: Icons.school_rounded,
  ),

  // ─────────────────────────────────────────────────────────
  // PROJECT 2: ISOAR - Role-Based App
  // ─────────────────────────────────────────────────────────
  Project(
    id: 'isoar',
    title: 'ISOAR - Role-Based Flutter App',

    // 📱 CARD (Main Screen)
    shortDescription:
        'Multi-role Flutter app with Student, Teacher, Organization, and Admin panels featuring role-based navigation.',

    // 📄 DETAIL PAGE
    fullDescription:
        '''Developed a powerful multi-role Flutter application supporting Student, Teacher, Organization, and Admin panels, each with dedicated role-based UI flows and functionality.

Designed and completed end-to-end UI for all user panels, ensuring consistency, usability, and clean visual hierarchy throughout the application. The interface adapts intelligently based on user roles, providing a tailored experience for each user type.

Implemented sophisticated role-based navigation that dynamically renders screens and features based on the authenticated user type. This architecture ensures secure access control while maintaining a seamless user experience across all panels.

Built responsive and adaptive layouts to support multiple screen sizes and devices, from compact mobile phones to large tablets. Created a comprehensive library of reusable and modular UI components to maintain scalability and significantly reduce code duplication.

Applied Flutter best practices for widget composition, layout optimization, and UI performance, resulting in smooth screen transitions and intuitive user journeys across all different panels.''',

    role: 'Flutter Developer',
    client: 'Startup',

    imagePath: 'assets/images/isoar/main.png',
    heroImage: 'assets/images/isoar/main.png',
    galleryImages: [
      'assets/images/isoar/main.png',
      'assets/images/isoar/image2.png',
      'assets/images/isoar/image3.png',
      'assets/images/isoar/image4.png',
      'assets/images/isoar/image5.png',
      'assets/images/isoar/image6.png',
    ],
    techStack: [
      'Flutter',
      'Dart',
      'GetX',
      'Clean Architecture',
      'Responsive UI',
    ],
    features: [
      'Multi-role support (Student, Teacher, Organization, Admin)',
      'Role-based dynamic screen rendering',
      'Complete end-to-end UI for all user panels',
      'Responsive and adaptive layouts for all devices',
      'Reusable and modular UI components',
      'Smooth screen transitions and animations',
      'Clean visual hierarchy and consistent design',
      'Intuitive user journeys across panels',
    ],
    responsibilities: [
      'Designed complete UI for all user panels (Student, Teacher, Organization, Admin)',
      'Implemented role-based navigation system with dynamic rendering',
      'Built responsive layouts supporting multiple screen sizes',
      'Created reusable widget library for scalability',
      'Ensured UI consistency and clean visual hierarchy',
      'Optimized UI performance and widget composition',
      'Applied Flutter best practices for layout optimization',
    ],
    challenges: [
      'Managing complex navigation flows for 4 different user roles',
      'Ensuring UI consistency across all panels while maintaining unique features',
      'Building scalable component architecture for future expansion',
      'Optimizing performance with dynamic role-based rendering',
    ],
    accentColor: AppTheme.primaryPurple,
    icon: Icons.people_rounded,
  ),

  // ─────────────────────────────────────────────────────────
  // PROJECT 3: LOOKBOOK - Fashion App
  // ─────────────────────────────────────────────────────────
  Project(
    id: 'lookbook',
    title: 'LOOKBOOK - Fashion App',

    // 📱 CARD (Main Screen)
    shortDescription:
        'Fashion e-commerce app with barcode scanning, real-time messaging, and Firebase integration for expo buyers.',

    // 📄 DETAIL PAGE
    fullDescription:
        '''Developed a feature-rich role-based Flutter mobile application tailored for the fashion industry, supporting Customer, Designer, and Admin user models, each with dedicated functionality and unique UI flows.

Implemented innovative barcode scanning functionality enabling fashion buyers to scan clothing items at expos and instantly access detailed product information. Designed rich product detail screens displaying high-quality images, videos, pricing, and fabric information to support informed decision-making.

Built powerful features allowing users to browse, compare, and save items in an event-specific cart for later review—perfect for fashion expo environments. Enabled direct in-app communication between buyers and designers through real-time text messaging for seamless business interactions.

Integrated Firebase Authentication for secure login, password management, and robust user session handling. Implemented Firebase Cloud Messaging (FCM) for real-time notifications and enhanced user engagement, with careful device token management to ensure reliable push notification delivery across all devices.

Ensured real-time data updates using Firebase Firestore, providing a seamless and responsive user experience. Developed following clean UI principles and performance optimization best practices using Provider state management.''',

    role: 'Flutter ',
    client: 'Startup (Fashion Industry)',

    imagePath: 'assets/images/lookbook/image.png',
    heroImage: 'assets/images/lookbook/image.png',
    galleryImages: [
      'assets/images/lookbook/image.png',
      'assets/images/lookbook/lookbook_cover.png',
      'assets/images/lookbook/lookbook_hero.png',
      'assets/images/lookbook/Gemini_Generated_Image_5p2kfz5p2kfz5p2k.png',
      'assets/images/lookbook/Gemini_Generated_Image_5p2kfz5p2kfz5p2k (1).png',
      'assets/images/lookbook/images/lookbook_1.png',
      'assets/images/lookbook/images/lookbook_2.png',
      'assets/images/lookbook/images/lookbook_3.png',
      'assets/images/lookbook/images/image1.png',
      'assets/images/lookbook/images/image2.png',
      'assets/images/lookbook/image.png',
      'assets/images/lookbook/image3.png',
    ],
    techStack: [
      'Flutter',
      'Dart',
      'Provider',
      'Firebase Auth',
      'Firestore',
      'FCM',
      'Barcode Scanner',
    ],
    features: [
      'Barcode scanning for instant product lookup at expos',
      'Rich product details (images, videos, pricing, fabric info)',
      'Event-specific cart for fashion shows and expos',
      'Real-time messaging between buyers and designers',
      'Firebase Authentication with secure sessions',
      'Push notifications via FCM',
      'Real-time data sync with Firestore',
      'Role-based UI (Customer, Designer, Admin)',
    ],
    responsibilities: [
      'Developed role-based UI for Customer, Designer, and Admin panels',
      'Implemented barcode scanning with instant product lookup',
      'Built rich product detail screens with media support',
      'Created event-specific cart system for fashion expos',
      'Integrated real-time messaging between buyers and designers',
      'Set up Firebase Authentication and session management',
      'Implemented FCM for push notifications',
      'Managed device tokens for reliable notification delivery',
      'Implemented Firestore real-time data updates',
      'Applied Provider state management for clean architecture',
    ],
    challenges: [
      'Integrating barcode scanner with real-time product database',
      'Building reliable real-time chat with message delivery confirmation',
      'Managing complex role-based permissions and access control',
      'Handling offline/online sync for expo environments with limited connectivity',
      'Optimizing media-heavy product screens for performance',
    ],
    accentColor: AppTheme.accentPink,
    icon: Icons.checkroom_rounded,
  ),

  // ─────────────────────────────────────────────────────────
  // PROJECT 4: FitTrack - Fitness App
  // ─────────────────────────────────────────────────────────
  //   Project(
  //     id: 'fittrack',
  //     title: 'FitTrack - Fitness Companion',
  //     shortDescription: 'Fitness tracking with workout plans and health API integration.',
  //     fullDescription: '''A comprehensive fitness tracking application designed to help users achieve their health goals through personalized workout plans, detailed progress tracking, and social motivation features.

  // The app integrates with device health APIs to provide accurate activity data, including steps, heart rate, and sleep patterns. Advanced charting visualizes progress over time.''',

  //     role: 'Full Stack Flutter Developer',
  //     duration: 'Feb 2024 - Present',

  //     imagePath: 'assets/images/fittrack.png',
  //     heroImage: 'assets/images/project_fittrack_hero.png',
  //     galleryImages: [],
  //     techStack: ['Flutter', 'GetX', 'Health API', 'SQLite', 'Charts'],
  //     features: [
  //       'Custom workout plan builder',
  //       'Progress tracking with charts',
  //       'Calorie & nutrition counter',
  //       'Social challenges & leaderboards',
  //       'Health API integration',
  //     ],
  //     accentColor: AppTheme.accentTeal,
  //     icon: Icons.fitness_center_rounded,
  //   ),

  //   // ─────────────────────────────────────────────────────────
  //   // PROJECT 5: FoodieHub - Restaurant App
  //   // ─────────────────────────────────────────────────────────
  //   Project(
  //     id: 'foodiehub',
  //     title: 'FoodieHub - Food Delivery',
  //     shortDescription: 'Food delivery platform with real-time tracking and payments.',
  //     fullDescription: '''A complete food delivery ecosystem connecting hungry customers with local restaurants. Features a customer app, restaurant dashboard, and delivery driver application.

  // Real-time order tracking using Google Maps integration provides accurate delivery ETAs. Multiple payment gateways including Stripe and local payment methods ensure seamless transactions.''',

  //     role: 'Mobile App Developer',

  //     imagePath: 'assets/images/foodiehub.png',
  //     heroImage: 'assets/images/project_foodiehub_hero.png',
  //     galleryImages: [],
  //     techStack: ['Flutter', 'Node.js', 'MongoDB', 'Stripe', 'Google Maps'],
  //     features: [
  //       'Real-time order tracking',
  //       'Multiple payment options',
  //       'Restaurant dashboard',
  //       'Push notifications',
  //       'Reviews & ratings system',
  //     ],
  //     accentColor: AppTheme.primaryBlue,
  //     icon: Icons.restaurant_rounded,
  //   ),

  //   // ─────────────────────────────────────────────────────────
  //   // PROJECT 6: MediCare - Health App
  //   // ─────────────────────────────────────────────────────────
  //   Project(
  //     id: 'medicare',
  //     title: 'MediCare - Health Management',
  //     shortDescription: 'Healthcare app with appointments and video consultations.',
  //     fullDescription: '''A comprehensive healthcare management solution enabling patients to book appointments, store medical records securely, receive medication reminders, and conduct telemedicine consultations.

  // Integrated Agora SDK provides crystal-clear video consultations between patients and healthcare providers, with end-to-end encryption ensuring HIPAA compliance.''',

  //     role: 'Flutter Developer',

  //     imagePath: 'assets/images/medicare.png',
  //     heroImage: 'assets/images/project_medicare_hero.png',
  //     galleryImages: [],
  //     techStack: ['Flutter', 'Firebase', 'Agora SDK', 'Cloud Functions'],
  //     features: [
  //       'Doctor appointment booking',
  //       'Medical records storage',
  //       'Medication reminders',
  //       'Video consultations',
  //       'Prescription management',
  //     ],
  //     accentColor: AppTheme.primaryPurple,
  //     icon: Icons.health_and_safety_rounded,
  //   ),

  //   // ─────────────────────────────────────────────────────────
  //   // PROJECT 7: TravelMate - Travel App
  //   // ─────────────────────────────────────────────────────────
  //   Project(
  //     id: 'travelmate',
  //     title: 'TravelMate - Trip Planner',
  //     shortDescription: 'Travel planning with itineraries and offline maps.',
  //     fullDescription: '''An all-in-one travel companion that transforms trip planning from stressful to seamless. Build detailed itineraries, book flights and hotels, discover local guides, and track expenses all in one place.

  // Offline maps and guides ensure you're never lost, even without internet connectivity. The expense tracker automatically categorizes spending and converts currencies in real-time.''',

  //     role: 'Lead Developer',

  //     imagePath: 'assets/images/travelmate.png',
  //     heroImage: 'assets/images/project_travelmate_hero.png',
  //     galleryImages: [],
  //     techStack: ['Flutter', 'Riverpod', 'REST APIs', 'Google Places', 'Hive'],
  //     features: [
  //       'Smart itinerary builder',
  //       'Flight & hotel integration',
  //       'Offline maps & guides',
  //       'Expense tracker',
  //       'Photo journal',
  //     ],
  //     accentColor: AppTheme.accentTeal,
  //     icon: Icons.travel_explore_rounded,
  //   ),

  //   // ─────────────────────────────────────────────────────────
  //   // PROJECT 8: GameZone - Gaming Platform
  //   // ─────────────────────────────────────────────────────────
  //   Project(
  //     id: 'gamezone',
  //     title: 'GameZone - eSports Platform',
  //     shortDescription: 'eSports tournaments with live streaming and team management.',
  //     fullDescription: '''The ultimate eSports tournament platform for competitive gaming communities. Organize tournaments, manage teams, stream live matches, and distribute prizes seamlessly.

  // WebSocket integration enables real-time bracket updates and live chat during matches. Twitch API integration allows streaming directly within the app.''',

  //     role: 'Full Stack Developer',

  //     imagePath: 'assets/images/gamezone.png',
  //     heroImage: 'assets/images/project_gamezone_hero.png',
  //     galleryImages: [],
  //     techStack: ['Flutter', 'WebSocket', 'Firebase', 'Twitch API', 'Stripe'],
  //     features: [
  //       'Tournament brackets',
  //       'Live stream integration',
  //       'Team management',
  //       'Leaderboards & stats',
  //       'Prize distribution',
  //     ],
  //     accentColor: AppTheme.accentPink,
  //     icon: Icons.sports_esports_rounded,
  //   ),

  //   // ─────────────────────────────────────────────────────────
  //   // PROJECT 9: EduLearn - E-Learning Platform
  //   // ─────────────────────────────────────────────────────────
  //   Project(
  //     id: 'edulearn',
  //     title: 'EduLearn - Online Courses',
  //     shortDescription: 'E-learning platform with video courses and certificates.',
  //     fullDescription: '''A feature-rich e-learning platform offering video courses, interactive quizzes, progress tracking, and certificate generation. Supports multiple languages and offline viewing for learning anywhere.

  // Built with scalability in mind using BLoC pattern, the app handles thousands of concurrent users while maintaining smooth video playback and instant quiz feedback.''',

  //     role: 'Mobile Developer',

  //     imagePath: 'assets/images/edulearn.png',
  //     heroImage: 'assets/images/project_edulearn_hero.png',
  //     galleryImages: [],
  //     techStack: ['Flutter', 'BLoC', 'AWS', 'Video Player', 'SQLite'],
  //     features: [
  //       'Video course streaming',
  //       'Interactive quizzes',
  //       'Progress tracking',
  //       'Certificates generation',
  //       'Offline downloads',
  //     ],
  //     accentColor: AppTheme.primaryBlue,
  //     icon: Icons.menu_book_rounded,
  //   ),

  // ─────────────────────────────────────────────────────────
  // 🆕 ADD NEW PROJECTS - TEMPLATE:
  // ─────────────────────────────────────────────────────────
  // Project(
  //   id: 'myproject',
  //   title: 'My Project Name',
  //
  //   // 📱 CARD - Short (1 line)
  //   shortDescription: 'Brief tagline for the card.',
  //
  //   // 📄 DETAIL PAGE - Full story
  //   fullDescription: '''Detailed multi-paragraph description...''',
  //
  //   role: 'Your Role',
  //   duration: 'Start - End',
  //   client: 'Client Name',
  //
  //   imagePath: 'assets/images/myproject.png',
  //   heroImage: 'assets/images/project_myproject_hero.png',
  //   galleryImages: [],
  //   techStack: ['Flutter', 'Firebase'],
  //   features: ['Feature 1', 'Feature 2'],
  //   responsibilities: ['What you did'],
  //   challenges: ['Problems solved'],
  //   results: ['Achievements'],
  //
  //   githubUrl: 'https://github.com/...',
  //   liveUrl: 'https://...',
  //   playStoreUrl: 'https://play.google.com/...',
  //
  //   accentColor: AppTheme.primaryBlue,
  //   icon: Icons.apps_rounded,
  // ),
];
