import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../models/project.dart';
import '../screens/project_detail_screen.dart';
import 'responsive_builder.dart';
import 'animated_entrance.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // Start animation after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted && !_hasAnimated) {
          _hasAnimated = true;
          _entranceController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
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
        decoration: BoxDecoration(
          color: AppTheme.secondaryBackground.withValues(alpha: 0.2),
        ),
        child: Column(
          children: [
            // Section Title (centered with max width)
            ContentContainer(
              child: AnimatedEntrance(
                delay: Duration.zero,
                child: Column(
                  children: [
                    Text(
                      'PORTFOLIO',
                      style: AppTheme.labelLarge.copyWith(
                        color: AppTheme.primaryBlue,
                        letterSpacing: 3,
                        fontSize: isMobile ? 11 : 12,
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    GradientText(
                      text: l10n.projectsTitle,
                      style: isMobile ? AppTheme.headlineMedium : AppTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    Text(
                      'Tap on a project to explore details',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textMuted,
                        fontSize: isMobile ? 13 : 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: isMobile ? 28 : 48),
            
            // Projects Grid (FULL WIDTH)
            FullWidthContainer(
              child: _buildProjectsGrid(context, l10n, isMobile),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, AppLocalizations l10n, bool isMobile) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = ResponsiveBuilder.isTablet(context);
    
    // Calculate number of columns based on screen width - more columns for wider screens
    int crossAxisCount;
    double spacing;
    
    if (isMobile) {
      crossAxisCount = 1;
      spacing = 16;
    } else if (isTablet || screenWidth < 1024) {
      crossAxisCount = 2;
      spacing = 20;
    } else if (screenWidth < 1400) {
      crossAxisCount = 3;
      spacing = 24;
    } else if (screenWidth < 1800) {
      crossAxisCount = 4;
      spacing = 24;
    } else {
      // Very large screens - 5 columns
      crossAxisCount = 5;
      spacing = 28;
    }
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final totalSpacing = spacing * (crossAxisCount - 1);
        
        // Cards expand to fill available space evenly
        final cardWidth = (availableWidth - totalSpacing) / crossAxisCount;
        
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.start, // Align to start for better layout
          children: portfolioProjects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            return AnimatedEntrance(
              delay: Duration(milliseconds: 100 + (index * 60)),
              child: SizedBox(
                key: ValueKey(project.id),
                width: isMobile ? availableWidth : cardWidth,
                child: _ProjectCard(
                  key: ValueKey('card_${project.id}'),
                  project: project,
                  l10n: l10n,
                  isMobile: isMobile,
                  animationController: _entranceController,
                  index: index,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final AppLocalizations l10n;
  final bool isMobile;
  final AnimationController animationController;
  final int index;

  const _ProjectCard({
    super.key,
    required this.project,
    required this.l10n,
    required this.isMobile,
    required this.animationController,
    required this.index,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _navigateToDetail() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProjectDetailScreen(project: widget.project);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.03);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.easeOutCubic));
          final offsetAnimation = animation.drive(tween);
          
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projectColor = widget.project.accentColor;
    final scale = _isPressed ? 0.98 : (_isHovered ? 1.02 : 1.0);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _navigateToDetail();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: AppTheme.quickAnimation,
          transform: Matrix4.identity()..scale(scale),
          transformAlignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              border: Border.all(
                color: _isHovered 
                    ? projectColor.withValues(alpha: 0.6)
                    : AppTheme.inputBorder,
                width: _isHovered ? 1.5 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: projectColor.withValues(alpha: 0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                        spreadRadius: -5,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Image/Icon Header
                _buildHeader(projectColor),
                
                // Project Info
                Padding(
                  padding: EdgeInsets.all(widget.isMobile ? 16 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        widget.project.title,
                        style: AppTheme.titleLarge.copyWith(
                          fontSize: widget.isMobile ? 17 : 19,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: widget.isMobile ? 8 : 10),
                      
                      // Description
                      Text(
                        widget.project.description,
                        style: AppTheme.bodyMedium.copyWith(
                          fontSize: widget.isMobile ? 13 : 14,
                          height: 1.5,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: widget.isMobile ? 14 : 18),
                      
                      // Tech Stack
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.techStack.take(4).map((tech) {
                          return _TechTag(label: tech, color: projectColor);
                        }).toList(),
                      ),
                      
                      SizedBox(height: widget.isMobile ? 14 : 18),
                      
                      // View Project CTA
                      _buildCTA(projectColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color projectColor) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConstants.radiusXL - 1),
      ),
      child: Stack(
        children: [
          // Background gradient
          Container(
            height: widget.isMobile ? 160 : 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  projectColor.withValues(alpha: 0.2),
                  projectColor.withValues(alpha: 0.05),
                  AppTheme.cardBackground,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          // Grid overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _SubtleGridPainter(color: projectColor),
            ),
          ),
          
          // Icon
          Positioned.fill(
            child: Center(
              child: AnimatedContainer(
                duration: AppTheme.quickAnimation,
                padding: EdgeInsets.all(widget.isMobile ? 18 : 22),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? projectColor.withValues(alpha: 0.25)
                      : AppTheme.surfaceColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered 
                        ? projectColor.withValues(alpha: 0.4)
                        : AppTheme.inputBorder.withValues(alpha: 0.5),
                  ),
                  boxShadow: _isHovered ? [
                    BoxShadow(
                      color: projectColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ] : null,
                ),
                child: Icon(
                  widget.project.icon,
                  color: _isHovered ? Colors.white : projectColor,
                  size: widget.isMobile ? 36 : 42,
                ),
              ),
            ),
          ),
          
          // Hover overlay
          if (_isHovered)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      projectColor.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCTA(Color projectColor) {
    return AnimatedContainer(
      duration: AppTheme.quickAnimation,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 14 : 16,
        vertical: widget.isMobile ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: _isHovered
            ? projectColor.withValues(alpha: 0.15)
            : AppTheme.surfaceColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(
          color: _isHovered 
              ? projectColor.withValues(alpha: 0.4)
              : AppTheme.inputBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.l10n.viewProject,
            style: AppTheme.labelLarge.copyWith(
              color: _isHovered ? projectColor : AppTheme.textSecondary,
              fontSize: widget.isMobile ? 12 : 13,
            ),
          ),
          const SizedBox(width: 6),
          AnimatedContainer(
            duration: AppTheme.quickAnimation,
            transform: Matrix4.translationValues(
              _isHovered ? 4 : 0,
              0,
              0,
            ),
            child: Icon(
              Icons.arrow_forward_rounded,
              color: _isHovered ? projectColor : AppTheme.textMuted,
              size: widget.isMobile ? 14 : 16,
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: AppTheme.bodyMedium.copyWith(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Subtle grid painter for card headers
class _SubtleGridPainter extends CustomPainter {
  final Color color;

  _SubtleGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.05)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const gridSize = 30.0;
    
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
