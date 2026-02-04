import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  
  // Keys for scrolling to sections
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    
    switch (section) {
      case 'hero':
        targetKey = _heroKey;
        break;
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'experience':
        targetKey = _experienceKey;
        break;
      case 'projects':
        targetKey = _projectsKey;
        break;
      case 'skills':
        targetKey = _skillsKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
    }
    
    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToAbout() {
    _scrollToSection('about');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Fixed Navigation Bar
            SafeArea(
              bottom: false,
              child: CustomNavigationBar(
                onNavItemTap: _scrollToSection,
              ),
            ),
            
            // Scrollable Content
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                ),
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    // Hero Section
                    SliverToBoxAdapter(
                      child: RepaintBoundary(
                        key: _heroKey,
                        child: HeroSection(
                          onScrollDown: _scrollToAbout,
                          onContactTap: () => _scrollToSection('contact'),
                          onProjectsTap: () => _scrollToSection('projects'),
                        ),
                      ),
                    ),
                    
                    // About Section
                    SliverToBoxAdapter(
                      child: RepaintBoundary(
                        key: _aboutKey,
                        child: const AboutSection(),
                      ),
                    ),
                    
                    // Experience Section
                    SliverToBoxAdapter(
                      child: RepaintBoundary(
                        key: _experienceKey,
                        child: const ExperienceSection(),
                      ),
                    ),
                    
                    // Projects Section
                    SliverToBoxAdapter(
                      child: RepaintBoundary(
                        key: _projectsKey,
                        child: const ProjectsSection(),
                      ),
                    ),
                    
                    // Skills Section
                    SliverToBoxAdapter(
                      child: RepaintBoundary(
                        key: _skillsKey,
                        child: const SkillsSection(),
                      ),
                    ),
                    
                    // Contact Section
                    SliverToBoxAdapter(
                      child: RepaintBoundary(
                        key: _contactKey,
                        child: const ContactSection(),
                      ),
                    ),
                    
                    // Footer
                    const SliverToBoxAdapter(
                      child: _Footer(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 24 : 32,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.secondaryBackground.withValues(alpha: 0.3),
        border: Border(
          top: BorderSide(
            color: AppTheme.inputBorder.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gradient accent line
            Container(
              width: 60,
              height: 3,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Text(
              '© ${DateTime.now().year} Akash Zaib Malik',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
                fontSize: isMobile ? 12 : 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Built with Flutter & ❤️',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textMuted,
                fontSize: isMobile ? 11 : 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
