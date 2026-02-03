import 'package:flutter/material.dart';
import '../config/theme.dart';

class Skill {
  final String nameKey;
  final int percentage;
  final Color progressColor;

  const Skill({
    required this.nameKey,
    required this.percentage,
    this.progressColor = AppTheme.primaryBlue,
  });
}

// Skills list from CV with percentages
const List<Skill> skillsList = [
  Skill(
    nameKey: 'skillFlutter',
    percentage: 95,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    nameKey: 'skillDart',
    percentage: 95,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    nameKey: 'skillFirebase',
    percentage: 90,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    nameKey: 'skillStateManagement',
    percentage: 90,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    nameKey: 'skillCleanArchitecture',
    percentage: 88,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    nameKey: 'skillRestApi',
    percentage: 85,
    progressColor: AppTheme.primaryPurple,
  ),
  Skill(
    nameKey: 'skillUIUX',
    percentage: 88,
    progressColor: AppTheme.primaryBlue,
  ),
  Skill(
    nameKey: 'skillResponsive',
    percentage: 92,
    progressColor: AppTheme.primaryPurple,
  ),
];

// Technical skills categories for detailed view
class SkillCategory {
  final String titleKey;
  final List<String> skills;

  const SkillCategory({
    required this.titleKey,
    required this.skills,
  });
}

const List<SkillCategory> skillCategories = [
  SkillCategory(
    titleKey: 'Programming Language',
    skills: ['Dart'],
  ),
  SkillCategory(
    titleKey: 'Mobile App Development',
    skills: ['Flutter (Expert)', 'FlutterFlow (UI)', 'Adalo (Basic)'],
  ),
  SkillCategory(
    titleKey: 'State Management',
    skills: ['Provider', 'GetX', 'Riverpod', 'MobX'],
  ),
  SkillCategory(
    titleKey: 'Backend & APIs',
    skills: ['Firebase (Firestore, Auth, Cloud Functions)', 'REST API', 'Websockets'],
  ),
  SkillCategory(
    titleKey: 'Architecture Patterns',
    skills: ['Clean Architecture', 'MVVM'],
  ),
  SkillCategory(
    titleKey: 'UI/UX Tools',
    skills: ['Figma', 'Responsive UI Design'],
  ),
  SkillCategory(
    titleKey: 'Others',
    skills: ['Push Notifications', 'FCM', 'Shared Preferences', 'App Localization', 'Custom Widgets', 'Animations'],
  ),
];
