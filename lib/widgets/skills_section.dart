import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../models/skill.dart';
import 'responsive_builder.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // Start animation after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted && !_hasAnimated) {
          _hasAnimated = true;
          _controller.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                text: l10n.skillsTitle,
                style: isMobile ? AppTheme.headlineMedium : AppTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: isMobile ? 24 : 40),
              
              // Skills Grid
              _buildSkillsGrid(l10n, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(AppLocalizations l10n, bool isMobile) {
    if (isMobile) {
      return Column(
        children: skillsList.asMap().entries.map((entry) {
          final index = entry.key;
          final skill = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _AnimatedSkillBar(
              skill: skill,
              l10n: l10n,
              animation: _controller,
              delay: index * 0.08,
              isMobile: true,
            ),
          );
        }).toList(),
      );
    }

    final halfLength = (skillsList.length / 2).ceil();
    final leftSkills = skillsList.sublist(0, halfLength);
    final rightSkills = skillsList.sublist(halfLength);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          child: Column(
            children: leftSkills.asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: _AnimatedSkillBar(
                  skill: skill,
                  l10n: l10n,
                  animation: _controller,
                  delay: index * 0.08,
                  isMobile: false,
                ),
              );
            }).toList(),
          ),
        ),
        
        const SizedBox(width: 40),
        
        // Right Column
        Expanded(
          child: Column(
            children: rightSkills.asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: _AnimatedSkillBar(
                  skill: skill,
                  l10n: l10n,
                  animation: _controller,
                  delay: (halfLength + index) * 0.08,
                  isMobile: false,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _AnimatedSkillBar extends StatefulWidget {
  final Skill skill;
  final AppLocalizations l10n;
  final Animation<double> animation;
  final double delay;
  final bool isMobile;

  const _AnimatedSkillBar({
    required this.skill,
    required this.l10n,
    required this.animation,
    required this.delay,
    required this.isMobile,
  });

  @override
  State<_AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<_AnimatedSkillBar> {
  bool _isHovered = false;

  String _getLocalizedName() {
    switch (widget.skill.nameKey) {
      case 'skillFlutter':
        return widget.l10n.skillFlutter;
      case 'skillDart':
        return widget.l10n.skillDart;
      case 'skillFirebase':
        return widget.l10n.skillFirebase;
      case 'skillStateManagement':
        return widget.l10n.skillStateManagement;
      case 'skillCleanArchitecture':
        return widget.l10n.skillCleanArchitecture;
      case 'skillRestApi':
        return widget.l10n.skillRestApi;
      case 'skillUIUX':
        return widget.l10n.skillUIUX;
      case 'skillResponsive':
        return widget.l10n.skillResponsive;
      default:
        return widget.skill.nameKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) {
          // Calculate delayed progress
          final animValue = widget.animation.value;
          final delayedStart = widget.delay;
          final adjustedProgress = ((animValue - delayedStart) / (1 - delayedStart)).clamp(0.0, 1.0);
          final progress = Curves.easeOutCubic.transform(adjustedProgress);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Skill name and percentage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      _getLocalizedName(),
                      style: AppTheme.titleMedium.copyWith(
                        color: _isHovered ? widget.skill.progressColor : AppTheme.textPrimary,
                        fontSize: widget.isMobile ? 14 : 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _isHovered 
                          ? widget.skill.progressColor.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${(widget.skill.percentage * progress).round()}%',
                      style: AppTheme.titleMedium.copyWith(
                        color: widget.skill.progressColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.isMobile ? 14 : 16,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // Progress bar
              LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Background
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        height: _isHovered ? 10 : 8,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      
                      // Progress
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        height: _isHovered ? 10 : 8,
                        width: constraints.maxWidth * (widget.skill.percentage / 100) * progress,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              widget.skill.progressColor,
                              widget.skill.progressColor.withValues(alpha: 0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: widget.skill.progressColor.withValues(
                                alpha: _isHovered ? 0.5 : 0.3,
                              ),
                              blurRadius: _isHovered ? 10 : 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
