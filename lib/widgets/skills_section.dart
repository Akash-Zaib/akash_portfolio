import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../models/skill.dart';
import 'responsive_builder.dart';
import 'animated_entrance.dart';

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
        child: Column(
          children: [
            // Section Title (centered)
            ContentContainer(
              child: AnimatedEntrance(
                delay: Duration.zero,
                child: Column(
                  children: [
                    Text(
                      'SKILLS',
                      style: AppTheme.labelLarge.copyWith(
                        color: AppTheme.primaryBlue,
                        letterSpacing: 3,
                        fontSize: isMobile ? 11 : 12,
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    GradientText(
                      text: l10n.skillsTitle,
                      style: isMobile ? AppTheme.headlineMedium : AppTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: isMobile ? 28 : 48),
            
            // Skills Grid (FULL WIDTH)
            FullWidthContainer(
              child: _buildSkillsGrid(l10n, isMobile, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(AppLocalizations l10n, bool isMobile, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
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

    // Determine number of columns based on screen width
    int columnCount;
    double spacing;
    
    if (screenWidth < 1024) {
      columnCount = 2;
      spacing = 32;
    } else if (screenWidth < 1600) {
      columnCount = 3;
      spacing = 40;
    } else {
      columnCount = 4;
      spacing = 48;
    }
    
    // Split skills into columns
    final List<List<Skill>> columns = List.generate(columnCount, (_) => []);
    for (int i = 0; i < skillsList.length; i++) {
      columns[i % columnCount].add(skillsList[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columns.asMap().entries.map((columnEntry) {
        final columnIndex = columnEntry.key;
        final columnSkills = columnEntry.value;
        
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: columnIndex == 0 ? 0 : spacing / 2,
              right: columnIndex == columns.length - 1 ? 0 : spacing / 2,
            ),
            child: Column(
              children: columnSkills.asMap().entries.map((entry) {
                final skillIndex = entry.key;
                final skill = entry.value;
                final globalIndex = columnIndex + (skillIndex * columnCount);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _AnimatedSkillBar(
                    skill: skill,
                    l10n: l10n,
                    animation: _controller,
                    delay: globalIndex * 0.05,
                    isMobile: false,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
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
                        widget.skill.name,
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
