import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'responsive_builder.dart';
import 'animated_entrance.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onScrollDown;
  final VoidCallback? onContactTap;
  final VoidCallback? onProjectsTap;

  const HeroSection({
    super.key,
    this.onScrollDown,
    this.onContactTap,
    this.onProjectsTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    
    // Bounce animation for scroll indicator
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
    
    // Entrance animation for staggered reveal
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Start entrance animation after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _entranceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = ResponsiveBuilder.isMobile(context);
    final isTablet = ResponsiveBuilder.isTablet(context);
    
    // Calculate hero height
    final heroHeight = screenHeight - (isMobile ? 100 : 80);

    return RepaintBoundary(
      child: AnimatedMeshGradient(
        child: SizedBox(
          width: double.infinity,
          height: heroHeight.clamp(500, 950),
          child: SafeArea(
            child: Padding(
              padding: ResponsiveBuilder.getHorizontalPadding(context),
              child: isMobile || isTablet
                  ? _buildMobileLayout(
                      context,
                      l10n,
                      isMobile,
                      heroHeight,
                    )
                  : _buildDesktopLayout(l10n, heroHeight),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(AppLocalizations l10n, double heroHeight) {
    return Row(
      children: [
        // Left side - Profile Photo
        Expanded(
          flex: 2,
          child: _buildAnimatedElement(
            delay: 0.0,
            child: Center(
              child: ProfilePhotoWidget(
                imagePath: AppConstants.heroProfileImage,
                size: 280,
                showGlow: true,
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 40),
        
        // Right side - Text content
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              
              // Greeting
              _buildAnimatedElement(
                delay: 0.1,
                child: Text(
                  l10n.heroGreeting,
                  style: AppTheme.titleMedium.copyWith(
                    color: AppTheme.primaryBlue,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Name with gradient
              _buildAnimatedElement(
                delay: 0.2,
                child: GradientText(
                  text: l10n.heroName,
                  style: AppTheme.displayLarge.copyWith(fontSize: 56),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Senior title lines (typewriter on subtitle)
              _buildAnimatedElement(
                delay: 0.35,
                child: _buildHeroHeadlines(
                  l10n,
                  useTypewriterForSubtitle: true,
                  isMobile: false,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Skill Tags
              _buildAnimatedElement(
                delay: 0.5,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _SkillTag(label: l10n.heroTagFlutter, isMobile: false),
                    _SkillTag(label: l10n.heroTagDart, isMobile: false),
                    _SkillTag(label: l10n.heroTagFirebase, isMobile: false),
                    _SkillTag(label: l10n.heroTagUIUX, isMobile: false),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // CTA Buttons
              _buildAnimatedElement(
                delay: 0.65,
                child: Row(
                  children: [
                    _CTAButton(
                      label: l10n.heroCTAContact,
                      isPrimary: true,
                      onTap: widget.onContactTap,
                    ),
                    const SizedBox(width: 16),
                    _CTAButton(
                      label: l10n.heroCTAProjects,
                      isPrimary: false,
                      onTap: widget.onProjectsTap,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              _buildAnimatedElement(
                delay: 0.72,
                child: _buildMiniBio(l10n, isMobile: false),
              ),

              const SizedBox(height: 20),

              _buildAnimatedElement(
                delay: 0.78,
                child: _buildPlatformIconRow(context, l10n, isMobile: false),
              ),
              
              const Spacer(flex: 3),
              
              // Scroll indicator
              _buildScrollIndicator(l10n, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AppLocalizations l10n,
    bool isMobile,
    double heroHeight,
  ) {
    final photoSize = isMobile ? 160.0 : 200.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: heroHeight * 0.04),

                // Profile Photo
                _buildAnimatedElement(
                  delay: 0.0,
                  child: ProfilePhotoWidget(
                    imagePath: AppConstants.heroProfileImage,
                    size: photoSize,
                    showGlow: true,
                  ),
                ),

                SizedBox(height: isMobile ? 20 : 28),

                // Greeting
                _buildAnimatedElement(
                  delay: 0.15,
                  child: Text(
                    l10n.heroGreeting,
                    style: AppTheme.labelLarge.copyWith(
                      color: AppTheme.primaryBlue,
                      letterSpacing: 2,
                      fontSize: isMobile ? 12 : 14,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Name with gradient
                _buildAnimatedElement(
                  delay: 0.25,
                  child: GradientText(
                    text: l10n.heroName,
                    style: isMobile
                        ? AppTheme.displayMedium.copyWith(fontSize: 32)
                        : AppTheme.displayMedium.copyWith(fontSize: 42),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: isMobile ? 8 : 12),

                // Senior title lines
                _buildAnimatedElement(
                  delay: 0.35,
                  child: _buildHeroHeadlines(
                    l10n,
                    useTypewriterForSubtitle: false,
                    isMobile: isMobile,
                  ),
                ),

                SizedBox(height: isMobile ? 16 : 24),

                // Skill Tags
                _buildAnimatedElement(
                  delay: 0.45,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: isMobile ? 8 : 10,
                    runSpacing: isMobile ? 8 : 10,
                    children: [
                      _SkillTag(label: l10n.heroTagFlutter, isMobile: isMobile),
                      _SkillTag(label: l10n.heroTagDart, isMobile: isMobile),
                      _SkillTag(label: l10n.heroTagFirebase, isMobile: isMobile),
                      _SkillTag(label: l10n.heroTagUIUX, isMobile: isMobile),
                    ],
                  ),
                ),

                SizedBox(height: isMobile ? 22 : 30),

                // CTA Buttons
                _buildAnimatedElement(
                  delay: 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _CTAButton(
                        label: l10n.heroCTAContact,
                        isPrimary: true,
                        onTap: widget.onContactTap,
                        isMobile: isMobile,
                      ),
                      SizedBox(width: isMobile ? 12 : 16),
                      _CTAButton(
                        label: l10n.heroCTAProjects,
                        isPrimary: false,
                        onTap: widget.onProjectsTap,
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isMobile ? 14 : 18),

                _buildAnimatedElement(
                  delay: 0.63,
                  child: _buildMiniBio(l10n, isMobile: isMobile),
                ),

                SizedBox(height: isMobile ? 12 : 16),

                _buildAnimatedElement(
                  delay: 0.68,
                  child: _buildPlatformIconRow(context, l10n, isMobile: isMobile),
                ),

                SizedBox(height: isMobile ? 14 : 20),

                // Scroll indicator (fixed gap — Spacer breaks inside scroll)
                _buildScrollIndicator(l10n, isMobile),

                SizedBox(height: isMobile ? 12 : 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedElement({
    required double delay,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, _) {
        final animValue = _entranceController.value;
        final delayedStart = delay;
        final adjustedProgress = ((animValue - delayedStart) / (1 - delayedStart)).clamp(0.0, 1.0);
        final progress = Curves.easeOutCubic.transform(adjustedProgress);
        
        return Transform.translate(
          offset: Offset(0, 30 * (1 - progress)),
          child: Opacity(
            opacity: progress,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildScrollIndicator(AppLocalizations l10n, bool isMobile) {
    if (widget.onScrollDown == null) return const SizedBox.shrink();
    
    return _buildAnimatedElement(
      delay: 0.7,
      child: AnimatedBuilder(
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
                      fontSize: isMobile ? 11 : 13,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.inputBorder,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppTheme.textMuted,
                      size: isMobile ? 20 : 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMiniBio(AppLocalizations l10n, {required bool isMobile}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: isMobile ? 340 : 620,
      ),
      child: Text(
        l10n.heroMiniBio,
        style: AppTheme.bodyLarge.copyWith(
          color: AppTheme.textSecondary,
          fontSize: isMobile ? 13 : 15,
          height: 1.6,
        ),
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
      ),
    );
  }

  /// Two-line hero positioning: senior engineer + mobile / hybrid specialization.
  Widget _buildHeroHeadlines(
    AppLocalizations l10n, {
    required bool useTypewriterForSubtitle,
    required bool isMobile,
  }) {
    final seniorStyle = (isMobile
            ? AppTheme.titleMedium
            : AppTheme.titleLarge)
        .copyWith(
      color: AppTheme.textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: isMobile ? 15 : 22,
      height: 1.25,
    );

    final subtitleStyle = AppTheme.titleMedium.copyWith(
      color: AppTheme.textSecondary,
      fontSize: isMobile ? 13 : 18,
      height: isMobile ? 1.45 : 1.35,
    );

    final content = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.heroTitleSenior,
          style: seniorStyle,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        SizedBox(height: isMobile ? 6 : 10),
        if (useTypewriterForSubtitle && !isMobile)
          TypewriterText(
            text: l10n.heroSubtitleMobile,
            style: subtitleStyle.copyWith(fontSize: 20),
            charDuration: const Duration(milliseconds: 28),
            startDelay: const Duration(milliseconds: 400),
          )
        else
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isMobile ? 360 : 640),
            child: Text(
              l10n.heroSubtitleMobile,
              style: subtitleStyle,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
      ],
    );

    return content;
  }

  /// Platform / stack icons (Flutter, RN, Android, iOS, Web, Desktop).
  Widget _buildPlatformIconRow(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isMobile,
  }) {
    final useWrapLayout =
        isMobile || ResponsiveBuilder.isTablet(context);
    final iconSize = isMobile ? 20.0 : 22.0;
    final gap = isMobile ? 10.0 : 12.0;

    final entries = <(IconData, String)>[
      (FontAwesomeIcons.flutter, l10n.platformFlutter),
      (FontAwesomeIcons.react, l10n.platformReactNative),
      (FontAwesomeIcons.android, l10n.platformAndroid),
      (FontAwesomeIcons.apple, l10n.platformIos),
      (FontAwesomeIcons.chrome, l10n.platformWeb),
      (FontAwesomeIcons.desktop, l10n.platformDesktop),
    ];

    Widget chip(IconData icon, String tooltip) {
      return Tooltip(
        message: tooltip,
        child: Container(
          padding: EdgeInsets.all(isMobile ? 8 : 10),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: Border.all(
              color: AppTheme.inputBorder.withValues(alpha: 0.5),
            ),
          ),
          child: FaIcon(
            icon,
            size: iconSize,
            color: AppTheme.textSecondary,
          ),
        ),
      );
    }

    if (useWrapLayout) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final e in entries) chip(e.$1, e.$2),
        ],
      );
    }

    return Row(
      children: [
        for (int i = 0; i < entries.length; i++) ...[
          if (i > 0) SizedBox(width: gap),
          chip(entries[i].$1, entries[i].$2),
        ],
      ],
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
        duration: AppTheme.quickAnimation,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 12 : 18,
          vertical: widget.isMobile ? 6 : 10,
        ),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppTheme.primaryBlue.withValues(alpha: 0.15)
              : AppTheme.surfaceColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          border: Border.all(
            color: _isHovered 
                ? AppTheme.primaryBlue.withValues(alpha: 0.6)
                : AppTheme.inputBorder.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: _isHovered ? [
            BoxShadow(
              color: AppTheme.primaryBlue.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Text(
          widget.label,
          style: AppTheme.labelLarge.copyWith(
            color: _isHovered ? AppTheme.primaryBlue : AppTheme.textPrimary,
            fontSize: widget.isMobile ? 11 : 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback? onTap;
  final bool isMobile;

  const _CTAButton({
    required this.label,
    required this.isPrimary,
    this.onTap,
    this.isMobile = false,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppTheme.quickAnimation,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 20 : 28,
            vertical: widget.isMobile ? 12 : 14,
          ),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? (_isHovered ? AppTheme.buttonGradient : AppTheme.primaryGradient)
                : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _isHovered 
                        ? AppTheme.primaryBlue 
                        : AppTheme.inputBorder,
                    width: 1.5,
                  ),
            boxShadow: widget.isPrimary && _isHovered ? [
              BoxShadow(
                color: AppTheme.primaryBlue.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ] : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTheme.labelLarge.copyWith(
                  color: widget.isPrimary 
                      ? Colors.white 
                      : (_isHovered ? AppTheme.primaryBlue : AppTheme.textPrimary),
                  fontSize: widget.isMobile ? 13 : 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (widget.isPrimary) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: widget.isMobile ? 16 : 18,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

