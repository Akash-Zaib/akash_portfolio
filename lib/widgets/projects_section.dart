import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../models/project.dart';
import 'responsive_builder.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = ResponsiveBuilder.isMobile(context);

    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 48 : 80,
        ),
        child: ContentContainer(
          child: Column(
            children: [
              // Section Title
              GradientText(
                text: l10n.projectsTitle,
                style: isMobile ? AppTheme.headlineMedium : AppTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: isMobile ? 24 : 40),
              
              // Projects Grid
              _buildProjectsGrid(context, l10n, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, AppLocalizations l10n, bool isMobile) {
    final isTablet = ResponsiveBuilder.isTablet(context);
    
    if (isMobile) {
      return Column(
        children: portfolioProjects.map((project) {
          return Padding(
            key: ValueKey(project.titleKey),
            padding: const EdgeInsets.only(bottom: 20),
            child: _ProjectCard(key: ValueKey('card_${project.titleKey}'), project: project, l10n: l10n, isMobile: true),
          );
        }).toList(),
      );
    }
    
    if (isTablet) {
      return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: portfolioProjects.map((project) {
          return SizedBox(
            key: ValueKey(project.titleKey),
            width: (MediaQuery.of(context).size.width - 120) / 2,
            child: _ProjectCard(key: ValueKey('card_${project.titleKey}'), project: project, l10n: l10n, isMobile: false),
          );
        }).toList(),
      );
    }
    
    // Desktop - each card expands independently
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: portfolioProjects.map((project) {
        return Expanded(
          key: ValueKey(project.titleKey),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _ProjectCard(key: ValueKey('card_${project.titleKey}'), project: project, l10n: l10n, isMobile: false),
          ),
        );
      }).toList(),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final AppLocalizations l10n;
  final bool isMobile;

  const _ProjectCard({
    super.key,
    required this.project,
    required this.l10n,
    required this.isMobile,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;
  bool _showFeatures = false;

  String _getLocalizedTitle() {
    switch (widget.project.titleKey) {
      case 'projectOOSCTitle':
        return widget.l10n.projectOOSCTitle;
      case 'projectISOARTitle':
        return widget.l10n.projectISOARTitle;
      case 'projectLookbookTitle':
        return widget.l10n.projectLookbookTitle;
      default:
        return widget.project.titleKey;
    }
  }

  String _getLocalizedDescription() {
    switch (widget.project.descriptionKey) {
      case 'projectOOSCDescription':
        return widget.l10n.projectOOSCDescription;
      case 'projectISOARDescription':
        return widget.l10n.projectISOARDescription;
      case 'projectLookbookDescription':
        return widget.l10n.projectLookbookDescription;
      default:
        return widget.project.descriptionKey;
    }
  }

  Color _getProjectColor() {
    switch (widget.project.titleKey) {
      case 'projectOOSCTitle':
        return AppTheme.primaryBlue;
      case 'projectISOARTitle':
        return AppTheme.primaryPurple;
      case 'projectLookbookTitle':
        return AppTheme.accentPink;
      default:
        return AppTheme.primaryBlue;
    }
  }

  IconData _getProjectIcon() {
    switch (widget.project.titleKey) {
      case 'projectOOSCTitle':
        return Icons.school_rounded;
      case 'projectISOARTitle':
        return Icons.people_rounded;
      case 'projectLookbookTitle':
        return Icons.checkroom_rounded;
      default:
        return Icons.code_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectColor = _getProjectColor();
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => setState(() => _showFeatures = !_showFeatures),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusLG),
            border: Border.all(
              color: _isHovered ? projectColor : AppTheme.inputBorder,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: projectColor.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Project Image/Icon Header
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppConstants.radiusLG - 1),
                ),
                child: Container(
                  height: widget.isMobile ? 140 : 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        projectColor.withValues(alpha: 0.15),
                        AppTheme.primaryBackground,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? projectColor.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        _getProjectIcon(),
                        color: _isHovered ? Colors.white : projectColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Project Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      _getLocalizedTitle(),
                      style: AppTheme.titleLarge.copyWith(
                        fontSize: widget.isMobile ? 16 : 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Description
                    Text(
                      _getLocalizedDescription(),
                      style: AppTheme.bodyMedium.copyWith(
                        fontSize: 13,
                        height: 1.4,
                      ),
                      maxLines: _showFeatures ? 10 : 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Features (expandable)
                    if (_showFeatures) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Key Features:',
                        style: AppTheme.labelLarge.copyWith(
                          color: projectColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...widget.project.features.take(6).map((feature) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: projectColor,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: AppTheme.bodyMedium.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                    
                    const SizedBox(height: 12),
                    
                    // Tech Stack
                    Text(
                      widget.l10n.techStack,
                      style: AppTheme.labelLarge.copyWith(
                        color: AppTheme.textMuted,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.project.techStack.take(6).map((tech) {
                        return _TechTag(label: tech, color: projectColor);
                      }).toList(),
                    ),
                    
                    // Expand indicator
                    const SizedBox(height: 8),
                    Center(
                      child: Icon(
                        _showFeatures
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppTheme.textMuted,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  final Color color;

  const _TechTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: AppTheme.bodyMedium.copyWith(
          fontSize: 10,
          color: color,
        ),
      ),
    );
  }
}
