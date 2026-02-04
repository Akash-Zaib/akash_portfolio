import 'package:flutter/material.dart';
import '../config/theme.dart';

class Skill {
  final String name;
  final int percentage;
  final Color progressColor;

  const Skill({
    required this.name,
    required this.percentage,
    this.progressColor = AppTheme.primaryBlue,
  });
}

// ============================================================
// 📝 HOW TO ADD A NEW SKILL:
// ============================================================
// 1. Add a new Skill entry to the skillsList below
// 2. That's it! The UI will automatically update!
// ============================================================

final List<Skill> skillsList = [
  // ─────────────────────────────────────────────────────────
  // Core Skills
  // ─────────────────────────────────────────────────────────
  Skill(
    name: 'Flutter',
    percentage: 95,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    name: 'Dart',
    percentage: 95,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    name: 'Firebase',
    percentage: 90,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    name: 'State Management',
    percentage: 90,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    name: 'Clean Architecture',
    percentage: 88,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    name: 'REST APIs',
    percentage: 85,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    name: 'UI/UX Design',
    percentage: 88,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    name: 'Responsive Design',
    percentage: 92,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    name: 'GetX',
    percentage: 88,
    progressColor: AppTheme.accentTeal,
  ),
  Skill(
    name: 'Provider',
    percentage: 90,
    progressColor: AppTheme.accentPink,
  ),
  Skill(
    name: 'Riverpod',
    percentage: 82,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    name: 'BLoC Pattern',
    percentage: 78,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    name: 'Git & GitHub',
    percentage: 90,
    progressColor: AppTheme.accentTeal,
  ),
  Skill(
    name: 'Agile/Scrum',
    percentage: 85,
    progressColor: AppTheme.accentPink,
  ),
  Skill(
    name: 'Unit Testing',
    percentage: 75,
    progressColor: AppTheme.primaryBlue,
  ),

  // ─────────────────────────────────────────────────────────
  // 🆕 ADD NEW SKILLS BELOW - COPY THIS TEMPLATE:
  // ─────────────────────────────────────────────────────────
  // Skill(
  //   name: 'GraphQL',           // Skill name
  //   percentage: 80,            // Proficiency (0-100)
  //   progressColor: AppTheme.accentTeal,  // Bar color
  // ),
  //
  // 🎨 COLOR OPTIONS:
  //    AppTheme.primaryBlue    - Blue
  //    AppTheme.primaryPurple  - Purple
  //    AppTheme.accentPink     - Pink
  //    AppTheme.accentTeal     - Teal
  // ─────────────────────────────────────────────────────────
];

// ============================================================
// Technical skills categories for detailed view (optional)
// ============================================================
class SkillCategory {
  final String title;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.skills,
  });
}

final List<SkillCategory> skillCategories = [
  SkillCategory(
    title: 'Programming Language',
    skills: ['Dart'],
  ),
  SkillCategory(
    title: 'Mobile App Development',
    skills: ['Flutter (Expert)', 'FlutterFlow (UI)', 'Adalo (Basic)'],
  ),
  SkillCategory(
    title: 'State Management',
    skills: ['Provider', 'GetX', 'Riverpod', 'MobX'],
  ),
  SkillCategory(
    title: 'Backend & APIs',
    skills: ['Firebase (Firestore, Auth, Cloud Functions)', 'REST API', 'Websockets'],
  ),
  SkillCategory(
    title: 'Architecture Patterns',
    skills: ['Clean Architecture', 'MVVM'],
  ),
  SkillCategory(
    title: 'UI/UX Tools',
    skills: ['Figma', 'Responsive UI Design'],
  ),
  SkillCategory(
    title: 'Others',
    skills: ['Push Notifications', 'FCM', 'Shared Preferences', 'App Localization', 'Custom Widgets', 'Animations'],
  ),
];
