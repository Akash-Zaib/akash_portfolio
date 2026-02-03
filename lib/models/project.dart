class Project {
  final String titleKey;
  final String descriptionKey;
  final String imagePath;
  final List<String> techStack;
  final List<String> features;
  final String? githubUrl;
  final String? liveUrl;

  const Project({
    required this.titleKey,
    required this.descriptionKey,
    required this.imagePath,
    required this.techStack,
    this.features = const [],
    this.githubUrl,
    this.liveUrl,
  });
}

// Projects from CV - Balanced features for consistent card heights
const List<Project> portfolioProjects = [
  Project(
    titleKey: 'projectOOSCTitle',
    descriptionKey: 'projectOOSCDescription',
    imagePath: 'assets/images/oosc.png',
    techStack: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'MobX', 'Three.js'],
    features: [
      'AI-based learning for children',
      'Voice detection & speech recognition',
      '3D GLB model animations',
      'Alphabet tracing modules (English, Urdu, Math)',
      'Real-time data updates & offline support',
      'Smooth animated screen transitions',
    ],
  ),
  Project(
    titleKey: 'projectISOARTitle',
    descriptionKey: 'projectISOARDescription',
    imagePath: 'assets/images/isoar.png',
    techStack: ['Flutter', 'Firebase', 'Provider', 'Clean Architecture'],
    features: [
      'Multi-role support (Student, Teacher, Admin)',
      'Role-based dynamic navigation',
      'Responsive & adaptive layouts',
      'Reusable modular UI components',
      'Smooth screen transitions',
      'Widget composition best practices',
      'Organization panel with admin controls',
    ],
  ),
  Project(
    titleKey: 'projectLookbookTitle',
    descriptionKey: 'projectLookbookDescription',
    imagePath: 'assets/images/lookbook.png',
    techStack: ['Flutter', 'Firebase Auth', 'FCM', 'Firestore', 'Socket.io'],
    features: [
      'Barcode scanning for product lookup',
      'Real-time messaging between users',
      'Event-specific cart functionality',
      'Rich product detail screens',
      'Push notifications via FCM',
      'Firebase secure authentication',
    ],
  ),
];
