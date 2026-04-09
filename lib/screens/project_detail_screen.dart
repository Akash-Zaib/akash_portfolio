import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../models/project.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/animated_entrance.dart';
import '../l10n/app_localizations.dart';
import '../utils/asset_path.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late ScrollController _scrollController;
  late PageController _galleryPageController;
  int _selectedImageIndex = 0;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
    _galleryPageController = PageController();
    
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _entranceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _scrollController.dispose();
    _galleryPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = ResponsiveBuilder.isMobile(context);
    final isTablet = ResponsiveBuilder.isTablet(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            slivers: [
              // Hero image with parallax effect
              SliverToBoxAdapter(
                child: _buildHeroSection(isMobile, isTablet, screenWidth, l10n),
              ),
              
              // Content section
              SliverToBoxAdapter(
                child: _buildContentSection(isMobile, isTablet, l10n),
              ),
              
              // Gallery section
              SliverToBoxAdapter(
                child: _buildGallerySection(isMobile, isTablet, l10n),
              ),
              
              // Features section
              SliverToBoxAdapter(
                child: _buildFeaturesSection(isMobile, l10n),
              ),
              
              // Tech Stack section
              SliverToBoxAdapter(
                child: _buildTechStackSection(isMobile, l10n),
              ),
              
              // Bottom padding
              SliverToBoxAdapter(
                child: SizedBox(height: isMobile ? 40 : 80),
              ),
            ],
          ),
          
          // Floating back button
          _buildBackButton(isMobile),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile, bool isTablet, double screenWidth, AppLocalizations l10n) {
    final heroHeight = isMobile ? 320.0 : isTablet ? 420.0 : 540.0;
    final parallaxOffset = _scrollOffset * 0.2;
    
    return _buildAnimatedElement(
      delay: 0.0,
      child: SizedBox(
        height: heroHeight,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Hero image with parallax
            Transform.translate(
              offset: Offset(0, parallaxOffset),
              child: _buildHeroImage(heroHeight + 100),
            ),
            
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.primaryBackground.withValues(alpha: 0.3),
                    AppTheme.primaryBackground,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
            
            // Project info overlay
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(isMobile ? 20 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.project.accentColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: widget.project.accentColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(
                        widget.project.icon,
                        color: widget.project.accentColor,
                        size: isMobile ? 24 : 32,
                      ),
                    ),
                    
                    SizedBox(height: isMobile ? 12 : 16),
                    
                    // Title
                    Text(
                      widget.project.title,
                      style: isMobile
                          ? AppTheme.headlineMedium.copyWith(fontSize: 24)
                          : AppTheme.headlineLarge,
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

  Widget _buildHeroImage(double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.project.accentColor.withValues(alpha: 0.3),
            AppTheme.primaryBackground,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Image.asset(
        assetPathForImage(widget.project.heroImage),
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          // Fallback gradient with icon
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.project.accentColor.withValues(alpha: 0.2),
                  AppTheme.secondaryBackground,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Icon(
                widget.project.icon,
                size: 100,
                color: widget.project.accentColor.withValues(alpha: 0.3),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentSection(bool isMobile, bool isTablet, AppLocalizations l10n) {
    return _buildAnimatedElement(
      delay: 0.15,
      child: ContentContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 24 : 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project meta info (role, duration, client)
              if (widget.project.role != null || widget.project.duration != null || widget.project.client != null)
                Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 20 : 28),
                  child: Wrap(
                    spacing: isMobile ? 12 : 24,
                    runSpacing: 12,
                    children: [
                      if (widget.project.role != null)
                        _buildMetaChip(Icons.person_outline_rounded, widget.project.role!, isMobile),
                      if (widget.project.duration != null)
                        _buildMetaChip(Icons.calendar_today_rounded, widget.project.duration!, isMobile),
                      if (widget.project.client != null)
                        _buildMetaChip(Icons.business_rounded, widget.project.client!, isMobile),
                    ],
                  ),
                ),
              
              // Section label
              Text(
                'OVERVIEW',
                style: AppTheme.labelLarge.copyWith(
                  color: widget.project.accentColor,
                  letterSpacing: 2,
                  fontSize: isMobile ? 11 : 12,
                ),
              ),
              
              SizedBox(height: isMobile ? 12 : 16),
              
              // Full Description
              Text(
                widget.project.fullDescription,
                style: AppTheme.bodyLarge.copyWith(
                  height: 1.8,
                  fontSize: isMobile ? 15 : 17,
                  color: AppTheme.textSecondary,
                ),
              ),
              
              // Responsibilities section
              if (widget.project.responsibilities.isNotEmpty) ...[
                SizedBox(height: isMobile ? 28 : 40),
                _buildListSection(
                  'MY RESPONSIBILITIES',
                  widget.project.responsibilities,
                  Icons.task_alt_rounded,
                  isMobile,
                ),
              ],
              
              // Challenges section
              if (widget.project.challenges.isNotEmpty) ...[
                SizedBox(height: isMobile ? 28 : 40),
                _buildListSection(
                  'CHALLENGES SOLVED',
                  widget.project.challenges,
                  Icons.psychology_rounded,
                  isMobile,
                ),
              ],
              
              // Results section
              if (widget.project.results.isNotEmpty) ...[
                SizedBox(height: isMobile ? 28 : 40),
                _buildListSection(
                  'KEY RESULTS',
                  widget.project.results,
                  Icons.emoji_events_rounded,
                  isMobile,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMetaChip(IconData icon, String text, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: AppTheme.inputBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isMobile ? 14 : 16,
            color: widget.project.accentColor,
          ),
          SizedBox(width: isMobile ? 6 : 8),
          Text(
            text,
            style: AppTheme.bodyMedium.copyWith(
              fontSize: isMobile ? 12 : 14,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildListSection(String title, List<String> items, IconData icon, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.labelLarge.copyWith(
            color: widget.project.accentColor,
            letterSpacing: 2,
            fontSize: isMobile ? 11 : 12,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 10 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: isMobile ? 2 : 3),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.project.accentColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: widget.project.accentColor,
                  size: isMobile ? 10 : 12,
                ),
              ),
              SizedBox(width: isMobile ? 10 : 14),
              Expanded(
                child: Text(
                  item,
                  style: AppTheme.bodyMedium.copyWith(
                    fontSize: isMobile ? 14 : 15,
                    height: 1.5,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildGallerySection(bool isMobile, bool isTablet, AppLocalizations l10n) {
    if (widget.project.galleryImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildAnimatedElement(
      delay: 0.3,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section label
            Text(
              'GALLERY',
              style: AppTheme.labelLarge.copyWith(
                color: widget.project.accentColor,
                letterSpacing: 2,
                fontSize: isMobile ? 11 : 12,
              ),
            ),
            
            SizedBox(height: isMobile ? 16 : 24),
            
            // Main gallery image
            AspectRatio(
              aspectRatio: _getGalleryAspectRatio(isMobile, isTablet),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                  border: Border.all(color: AppTheme.inputBorder),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.radiusLG - 1),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _galleryPageController,
                        itemCount: widget.project.galleryImages.length,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            color: AppTheme.cardBackground,
                            child: Padding(
                              padding: EdgeInsets.all(isMobile ? 12 : 16),
                              child: Image.asset(
                                assetPathForImage(widget.project.galleryImages[index]),
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholderImage();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      if (widget.project.galleryImages.length > 1) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildCarouselArrow(
                            icon: Icons.chevron_left_rounded,
                            isMobile: isMobile,
                            onTap: () {
                              final target = (_selectedImageIndex - 1)
                                  .clamp(0, widget.project.galleryImages.length - 1);
                              _galleryPageController.animateToPage(
                                target,
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOutCubic,
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _buildCarouselArrow(
                            icon: Icons.chevron_right_rounded,
                            isMobile: isMobile,
                            onTap: () {
                              final target = (_selectedImageIndex + 1)
                                  .clamp(0, widget.project.galleryImages.length - 1);
                              _galleryPageController.animateToPage(
                                target,
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOutCubic,
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: isMobile ? 16 : 20),
            
            // Carousel indicators
            SizedBox(
              height: 24,
              child: Center(
                child: Wrap(
                  spacing: 8,
                  children: List.generate(
                    widget.project.galleryImages.length,
                    (index) => AnimatedContainer(
                      duration: AppTheme.quickAnimation,
                      width: _selectedImageIndex == index ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _selectedImageIndex == index
                            ? widget.project.accentColor
                            : AppTheme.inputBorder,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: isMobile ? 28 : 40),
          ],
        ),
      ),
    );
  }

  double _getGalleryAspectRatio(bool isMobile, bool isTablet) {
    if (isMobile) return 4 / 3;
    if (isTablet) return 16 / 10;
    return 16 / 9;
  }

  Widget _buildCarouselArrow({
    required IconData icon,
    required bool isMobile,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Container(
            width: isMobile ? 34 : 40,
            height: isMobile ? 34 : 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryBackground.withValues(alpha: 0.72),
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.inputBorder),
            ),
            child: Icon(
              icon,
              size: isMobile ? 20 : 24,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.project.accentColor.withValues(alpha: 0.1),
            AppTheme.cardBackground,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: 48,
              color: AppTheme.textMuted,
            ),
            const SizedBox(height: 8),
            Text(
              'Screenshot placeholder',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(bool isMobile, AppLocalizations l10n) {
    if (widget.project.features.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildAnimatedElement(
      delay: 0.45,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section label
            Text(
              'KEY FEATURES',
              style: AppTheme.labelLarge.copyWith(
                color: widget.project.accentColor,
                letterSpacing: 2,
                fontSize: isMobile ? 11 : 12,
              ),
            ),
            
            SizedBox(height: isMobile ? 16 : 24),
            
            // Features list
            ...widget.project.features.asMap().entries.map((entry) {
              final index = entry.key;
              final feature = entry.value;
              return _buildFeatureItem(feature, index, isMobile);
            }),
            
            SizedBox(height: isMobile ? 24 : 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature, int index, bool isMobile) {
    return AnimatedEntrance(
      delay: Duration(milliseconds: 600 + (index * 80)),
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: isMobile ? 2 : 4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: widget.project.accentColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: widget.project.accentColor,
                size: isMobile ? 12 : 14,
              ),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Expanded(
              child: Text(
                feature,
                style: AppTheme.bodyLarge.copyWith(
                  fontSize: isMobile ? 14 : 16,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechStackSection(bool isMobile, AppLocalizations l10n) {
    return _buildAnimatedElement(
      delay: 0.6,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section label
            Text(
              l10n.techStack.toUpperCase(),
              style: AppTheme.labelLarge.copyWith(
                color: widget.project.accentColor,
                letterSpacing: 2,
                fontSize: isMobile ? 11 : 12,
              ),
            ),
            
            SizedBox(height: isMobile ? 16 : 24),
            
            // Tech chips
            Wrap(
              spacing: isMobile ? 8 : 12,
              runSpacing: isMobile ? 8 : 12,
              children: widget.project.techStack.map((tech) {
                return _buildTechChip(tech, isMobile);
              }).toList(),
            ),
            
            // Project Links
            if (_hasAnyLinks()) ...[
              SizedBox(height: isMobile ? 32 : 48),
              Text(
                'PROJECT LINKS',
                style: AppTheme.labelLarge.copyWith(
                  color: widget.project.accentColor,
                  letterSpacing: 2,
                  fontSize: isMobile ? 11 : 12,
                ),
              ),
              SizedBox(height: isMobile ? 16 : 20),
              Wrap(
                spacing: isMobile ? 10 : 14,
                runSpacing: isMobile ? 10 : 14,
                children: [
                  if (widget.project.githubUrl != null)
                    _buildLinkButton(
                      icon: Icons.code_rounded,
                      label: 'GitHub',
                      url: widget.project.githubUrl!,
                      isMobile: isMobile,
                    ),
                  if (widget.project.liveUrl != null)
                    _buildLinkButton(
                      icon: Icons.launch_rounded,
                      label: 'Live Demo',
                      url: widget.project.liveUrl!,
                      isMobile: isMobile,
                    ),
                  if (widget.project.playStoreUrl != null)
                    _buildLinkButton(
                      icon: Icons.android_rounded,
                      label: 'Play Store',
                      url: widget.project.playStoreUrl!,
                      isMobile: isMobile,
                    ),
                  if (widget.project.appStoreUrl != null)
                    _buildLinkButton(
                      icon: Icons.apple_rounded,
                      label: 'App Store',
                      url: widget.project.appStoreUrl!,
                      isMobile: isMobile,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  bool _hasAnyLinks() {
    return widget.project.githubUrl != null ||
        widget.project.liveUrl != null ||
        widget.project.playStoreUrl != null ||
        widget.project.appStoreUrl != null;
  }
  
  Widget _buildLinkButton({
    required IconData icon,
    required String label,
    required String url,
    required bool isMobile,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Launch URL using url_launcher
        },
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 12 : 14,
          ),
          decoration: BoxDecoration(
            color: widget.project.accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: Border.all(
              color: widget.project.accentColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: isMobile ? 18 : 20,
                color: widget.project.accentColor,
              ),
              SizedBox(width: isMobile ? 8 : 10),
              Text(
                label,
                style: AppTheme.labelLarge.copyWith(
                  fontSize: isMobile ? 13 : 14,
                  color: widget.project.accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 14 : 18,
        vertical: isMobile ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: widget.project.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(
          color: widget.project.accentColor.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        tech,
        style: AppTheme.labelLarge.copyWith(
          color: widget.project.accentColor,
          fontSize: isMobile ? 12 : 14,
        ),
      ),
    );
  }

  Widget _buildBackButton(bool isMobile) {
    final opacity = (1 - (_scrollOffset / 200)).clamp(0.5, 1.0);
    
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: isMobile ? 16 : 32,
      child: AnimatedOpacity(
        duration: AppTheme.quickAnimation,
        opacity: opacity,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryBackground.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.inputBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.textPrimary,
              size: isMobile ? 20 : 24,
            ),
          ),
        ),
      ),
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

}
