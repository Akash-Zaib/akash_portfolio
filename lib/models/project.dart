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

    imagePath: 'assets/images/oosc/image.png',
    heroImage: 'assets/images/oosc/image.png',
    galleryImages: [
      'assets/images/oosc/image.png',
      'assets/images/oosc/WhatsApp Image 2026-04-09 at 5.24.55 PM.jpeg',
      'assets/images/oosc/WhatsApp Image 2026-04-09 at 5.24.56 PM.jpeg',
      'assets/images/oosc/WhatsApp Image 2026-04-09 at 5.24.56 PM (1).jpeg',
      'assets/images/oosc/WhatsApp Image 2026-04-09 at 5.24.56 PM (2).jpeg',
      'assets/images/oosc/WhatsApp Image 2026-04-09 at 5.24.56 PM (3).jpeg',
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
      "Animations",
      "Custom Packages",
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
    title: 'LOOKBOOK - Fashion App - Flutter',

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
  Project(
    id: 'expense_tracker',
    title: 'Expense Tracker - Personal Finance App',

    // 📱 CARD (Main Screen)
    shortDescription:
        'A Flutter-based expense tracker with Firebase backend for managing income, expenses, budgets, and financial insights in a clean and user-friendly way.',

    // 📄 DETAIL PAGE
    fullDescription:
        '''Developed a modern personal finance mobile application using Flutter for the frontend and Firebase as the backend solution. The app is designed to help users manage their daily expenses, track income, monitor budgets, and gain better control over their financial activities through a clean and intuitive interface.

The application allows users to add, edit, delete, and categorize expenses efficiently while maintaining a structured record of all financial transactions. Users can also track income sources, monitor spending patterns, and review transaction history with smooth filtering and organized lists.

Firebase was used as the backend to handle real-time data storage, user authentication, and cloud-based sync, ensuring secure and seamless access to financial records across sessions. The app architecture was built to provide responsive UI performance, scalable data handling, and a smooth user experience.

To improve financial understanding, the application includes charts, summaries, and reporting views that visually present spending habits, income trends, and category-wise breakdowns. The overall design focuses on usability, fast input workflows, and clear presentation of personal finance data for day-to-day expense management.''',

    role: 'Flutter Developer',
    client: 'Personal / Fintech Project',

    imagePath: 'assets/images/expenseTracker/main.png',
    heroImage: 'assets/images/expenseTracker/main.png',
    galleryImages: [
      'assets/images/expenseTracker/main.png',
      'assets/images/expenseTracker/image1.png',
      'assets/images/expenseTracker/image2.png',
      'assets/images/expenseTracker/image3.png',
      'assets/images/expenseTracker/image4.jpg',
      'assets/images/expenseTracker/image5.jpg',
    ],

    techStack: [
      'Flutter',
      'Dart',
      'Firebase',
      'Firebase Auth',
      'Cloud Firestore',
      'GetX',
      'Charts',
    ],

    features: [
      'Add, edit, and delete expenses بسهولة',
      'Income and expense tracking',
      'Category-based expense management',
      'Budget monitoring and financial planning',
      'Real-time data sync with Firebase',
      'User authentication and secure data access',
      'Transaction history with filters',
      'Financial summaries and charts',
      'Clean and responsive mobile UI',
    ],

    responsibilities: [
      'Developed complete frontend UI using Flutter',
      'Integrated Firebase backend for real-time data storage',
      'Implemented authentication and secure user access',
      'Built expense and income management workflows',
      'Designed transaction history and category-based tracking screens',
      'Created charts and analytics views for financial insights',
      'Structured app flow for smooth and intuitive user experience',
      'Optimized UI responsiveness and data handling performance',
    ],

    challenges: [
      'Managing real-time financial data efficiently with Firebase',
      'Designing a simple but informative finance dashboard',
      'Maintaining smooth UX for frequent data entry and updates',
      'Presenting financial reports in a clear and user-friendly way',
    ],

    results: [
      'Delivered a complete expense tracking solution with cloud-backed storage',
      'Improved finance management through clean transaction workflows',
      'Provided users with clear spending insights and reporting features',
    ],

    accentColor: AppTheme.accentTeal,
    icon: Icons.account_balance_wallet_rounded,
  ),

  // Project(
  //   id: 'fittrack',
  //   title: 'FitTrack - Fitness Companion',
  //   shortDescription:
  //       'Fitness tracking with workout plans and health API integration.',
  //   fullDescription:
  //       '''A comprehensive fitness tracking application designed to help users achieve their health goals through personalized workout plans, detailed progress tracking, and social motivation features.

  // The app integrates with device health APIs to provide accurate activity data, including steps, heart rate, and sleep patterns. Advanced charting visualizes progress over time.''',

  //   role: 'Full Stack Flutter Developer',
  //   duration: 'Feb 2024 - Present',

  //   imagePath: 'assets/images/fittrack.png',
  //   heroImage: 'assets/images/project_fittrack_hero.png',
  //   galleryImages: [],
  //   techStack: ['Flutter', 'GetX', 'Health API', 'SQLite', 'Charts'],
  //   features: [
  //     'Custom workout plan builder',
  //     'Progress tracking with charts',
  //     'Calorie & nutrition counter',
  //     'Social challenges & leaderboards',
  //     'Health API integration',
  //   ],
  //   accentColor: AppTheme.accentTeal,
  //   icon: Icons.fitness_center_rounded,
  // ),

  // ─────────────────────────────────────────────────────────
  // PROJECT 5: FoodieHub - Restaurant App
  // ─────────────────────────────────────────────────────────
  Project(
    id: 'bienas',
    title: 'Binance - Distribution Management App',

    // 📱 CARD (Main Screen)
    shortDescription:
        'A role-based distribution management app for managers, customers, and salesmen with streamlined order processing, product management, and API-driven operational tracking.',

    // 📄 DETAIL PAGE
    fullDescription:
        '''Developed a role-based distribution management mobile application designed to support managers, customers, and salesmen through dedicated workflows and a structured operational system. The application streamlines product distribution, customer ordering, sales activities, and management oversight within a single connected platform.

The customer side of the app enables users to browse products, review item details, place orders, and track order-related activities through a smooth and user-friendly interface. The salesman module supports field operations by helping sales representatives manage customer interactions, process orders, and maintain clear visibility into product and sales workflows.

The manager panel provides centralized control over distribution activities, operational monitoring, and business processes. It allows managers to oversee orders, monitor sales performance, review operational data, and manage the overall flow of the system more efficiently.

MongoDB was used as the backend database for storing products, customer records, order details, sales information, and operational data in a scalable structure. REST APIs were integrated to connect the Flutter application with backend services, enabling dynamic data fetching, order submission, status updates, and role-based business logic execution. The system follows an API-driven architecture that supports smooth communication between mobile interfaces and backend services.

MobX state management was used on the frontend to manage reactive application state, synchronize UI with backend responses, and maintain clean separation between business logic and presentation layers. The overall architecture was built with a focus on scalability, maintainability, and responsive performance across different workflows and user roles.

The complete product experience helps improve distribution efficiency, simplifies order handling, and creates a more organized system for medical and business distribution operations.''',

    role: 'Flutter Developer',
    client: 'Distribution / Medical Supply Business',

    imagePath: 'assets/images/bienance/image.png',
    heroImage: 'assets/images/bienance/image.png',
    galleryImages: [
      'assets/images/bienance/image.png',
      'assets/images/bienance/image1.png',
      'assets/images/bienance/image3.png',
      'assets/images/bienance/image4.png',
      'assets/images/bienance/image5.png',
    ],

    techStack: [
      'Flutter',
      'Dart',
      'MobX',
      'MongoDB',
      'REST APIs',
      'API Integration',
      'Backend Services',
      // 'Role-Based Architecture',
      // 'State Management',
    ],

    features: [
      'Role-based access for Manager, Customer, and Salesman',
      'Customer product browsing and ordering flow',
      'Salesman order handling and customer management',
      'Manager dashboard for operational control',
      'Order processing and distribution workflow',
      'Product and item management',
      'API-driven dynamic data flow',
      'Reactive UI updates with MobX',
      'Clean and responsive mobile UI',
    ],

    responsibilities: [
      'Developed role-based mobile UI for Manager, Customer, and Salesman panels',
      'Built customer ordering and product browsing workflows',
      'Implemented salesman-side order and customer handling features',
      'Created manager dashboard screens for monitoring operations',
      'Structured order processing and distribution flow screens',
      'Integrated REST APIs for dynamic data communication',
      'Connected Flutter app with MongoDB-backed backend services',
      'Implemented MobX state management for reactive data handling',
      'Managed API response states, loading flows, and UI synchronization',
      'Maintained reusable UI components for scalability and consistency',
      'Optimized app structure for smooth role-based navigation',
    ],

    challenges: [
      'Managing multiple user roles with separate workflows',
      'Designing a clean and simple order process across different user types',
      'Integrating REST APIs for dynamic order and product data',
      'Maintaining UI consistency while supporting different permissions',
      'Handling reactive state updates efficiently with MobX',
      'Organizing product, sales, and operational data with MongoDB in a scalable way',
    ],

    results: [
      'Delivered a complete multi-role distribution management solution',
      'Improved operational visibility for managers and sales teams',
      'Simplified customer ordering and sales workflow handling',
      'Enabled backend-driven workflows using MongoDB and REST APIs',
      'Achieved cleaner frontend state handling through MobX architecture',
    ],

    accentColor: AppTheme.primaryBlue,
    icon: Icons.local_shipping_rounded,
  ),
  // ─────────────────────────────────────────────────────────
  // PROJECT 9: EduLearn - E-Learning Platform
  // ─────────────────────────────────────────────────────────
  Project(
    id: 'docmind',
    title: 'DocMind - AI Document Processing',

    // 📱 CARD (Main Screen)
    shortDescription:
        'AI-powered document processing app for extracting, organizing, and managing structured data from invoices, receipts, and forms.',

    // 📄 DETAIL PAGE
    fullDescription:
        '''Developed an AI-powered document processing mobile application designed to simplify the handling of invoices, receipts, forms, and other business documents. The app enables users to upload, scan, and process documents efficiently while converting unstructured content into structured, searchable digital records.

The application supports intelligent document scanning and OCR-based text extraction, allowing users to capture important information directly from physical or digital files. AI-driven processing is used to identify key fields such as names, dates, invoice numbers, totals, and category-specific data, reducing manual entry and improving operational efficiency.

Built with a clean and scalable Flutter architecture, the app provides a smooth document workflow from upload to extraction, review, categorization, and storage. Users can browse processed documents, search records quickly, review extracted fields, and manage document history through an organized and intuitive interface.

The system was designed with a strong focus on usability, structured data handling, and modern mobile UI practices. It is suitable for businesses and teams that need faster document digitization, improved record management, and more reliable processing workflows.''',

    role: 'Flutter Developer',
    client: 'Enterprise / Business Automation',

    imagePath: 'assets/images/docmind.png',
    heroImage: 'assets/images/project_docmind_hero.png',
    galleryImages: [
      'assets/images/project_docmind_1.png',
      'assets/images/project_docmind_2.png',
      'assets/images/project_docmind_3.png',
    ],

    techStack: [
      'Flutter',
      'Dart',
      'MobX',
      'REST APIs',
      'MongoDB',
      'OCR Integration',
      'AI API',
      'Cloud Storage',
    ],

    features: [
      'Document scanning and upload workflow',
      'OCR-based text extraction',
      'AI-powered field detection and processing',
      'Structured data extraction from invoices and forms',
      'Searchable document history',
      'Document categorization and organization',
      'Review and verification of extracted data',
      'Responsive and clean mobile UI',
    ],

    responsibilities: [
      'Developed complete mobile UI using Flutter',
      'Built document upload and scanning workflows',
      'Integrated OCR and AI-based extraction features',
      'Implemented structured document review screens',
      'Created searchable history and document listing modules',
      'Connected app screens with backend APIs for processing workflows',
      'Applied MobX for reactive state management',
      'Maintained reusable UI components and scalable app structure',
    ],

    challenges: [
      'Designing a clean workflow for complex document processing tasks',
      'Presenting extracted data clearly for user review and verification',
      'Handling different document formats in a structured way',
      'Maintaining smooth UI performance during document-heavy operations',
    ],

    results: [
      'Delivered a professional AI-based document processing solution',
      'Improved efficiency in document digitization and structured data handling',
      'Created a scalable workflow for business document management',
    ],

    accentColor: AppTheme.primaryBlue,
    icon: Icons.description_rounded,
  ),

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
