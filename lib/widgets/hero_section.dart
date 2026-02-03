import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'responsive_builder.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onScrollDown;

  const HeroSection({
    super.key,
    this.onScrollDown,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = ResponsiveBuilder.isMobile(context);
    final isTablet = ResponsiveBuilder.isTablet(context);
    
    // Calculate hero height - use safe area for mobile
    final heroHeight = screenHeight - (isMobile ? 120 : 80);

    return RepaintBoundary(
      child: GridBackground(
        child: SizedBox(
          width: double.infinity,
          height: heroHeight.clamp(400, 900),
          child: SafeArea(
            child: Padding(
              padding: ResponsiveBuilder.getHorizontalPadding(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: heroHeight * 0.1),
                  
                  // Name with gradient
                  GradientText(
                    text: l10n.heroName,
                    style: isMobile
                        ? AppTheme.displayMedium.copyWith(fontSize: 36)
                        : isTablet
                            ? AppTheme.displayMedium.copyWith(fontSize: 48)
                            : AppTheme.displayLarge.copyWith(fontSize: 64),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: isMobile ? 12 : 20),
                  
                  // Role subtitle
                  Text(
                    l10n.heroRole,
                    style: isMobile
                        ? AppTheme.titleMedium.copyWith(
                            color: AppTheme.textSecondary,
                            fontSize: 16,
                          )
                        : AppTheme.titleLarge.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: isMobile ? 24 : 40),
                  
                  // Skill Tags
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: isMobile ? 8 : 12,
                    runSpacing: isMobile ? 8 : 12,
                    children: [
                      _SkillTag(label: l10n.heroTagFlutter, isMobile: isMobile),
                      _SkillTag(label: l10n.heroTagDart, isMobile: isMobile),
                      _SkillTag(label: l10n.heroTagFirebase, isMobile: isMobile),
                      _SkillTag(label: l10n.heroTagUIUX, isMobile: isMobile),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Scroll indicator
                  if (widget.onScrollDown != null)
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bounceAnimation.value),
                          child: GestureDetector(
                            onTap: widget.onScrollDown,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  l10n.scrollDown,
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: AppTheme.textMuted,
                                    fontSize: isMobile ? 12 : 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppTheme.textMuted,
                                  size: isMobile ? 24 : 28,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  
                  SizedBox(height: isMobile ? 24 : 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillTag extends StatefulWidget {
  final String label;
  final bool isMobile;

  const _SkillTag({required this.label, required this.isMobile});

  @override
  State<_SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<_SkillTag> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppConstants.shortAnimation,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 14 : 20,
          vertical: widget.isMobile ? 8 : 12,
        ),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppTheme.primaryBlue.withValues(alpha: 0.2)
              : AppTheme.surfaceColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          border: Border.all(
            color: _isHovered ? AppTheme.primaryBlue : AppTheme.inputBorder,
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTheme.labelLarge.copyWith(
            color: _isHovered ? AppTheme.primaryBlue : AppTheme.textPrimary,
            fontSize: widget.isMobile ? 12 : 14,
          ),
        ),
      ),
    );
  }
}
