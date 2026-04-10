import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/asset_path.dart';

class AppTheme {
  // Primary Colors - Dark Theme
  static const Color primaryBackground = Color(0xFF0A0F1A);
  static const Color secondaryBackground = Color(0xFF111827);
  static const Color cardBackground = Color(0xFF1A1F2E);
  static const Color surfaceColor = Color(0xFF252B3B);
  
  // Accent Colors - Gradient (refined teal-blue-purple spectrum)
  static const Color primaryBlue = Color(0xFF38BDF8);
  static const Color primaryPurple = Color(0xFF818CF8);
  static const Color accentPink = Color(0xFFF472B6);
  static const Color accentTeal = Color(0xFF2DD4BF);
  
  // Glow colors for effects
  static const Color glowBlue = Color(0xFF0EA5E9);
  static const Color glowPurple = Color(0xFF7C3AED);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  
  // Input Colors
  static const Color inputBackground = Color(0xFF1E293B);
  static const Color inputBorder = Color(0xFF334155);
  
  // Grid pattern color
  static const Color gridColor = Color(0xFF1E3A5F);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple, accentPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient socialGradient = LinearGradient(
    colors: [primaryPurple, accentPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Hero gradient for mesh background
  static const LinearGradient heroGradient = LinearGradient(
    colors: [
      Color(0xFF0A0F1A),
      Color(0xFF0F172A),
      Color(0xFF1E1B4B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Animation Constants
  static const Duration quickAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  static const Duration heroAnimation = Duration(milliseconds: 800);
  
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;

  // Text Styles
  static TextStyle get displayLarge => GoogleFonts.plusJakartaSans(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static TextStyle get displayMedium => GoogleFonts.plusJakartaSans(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static TextStyle get headlineLarge => GoogleFonts.plusJakartaSans(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static TextStyle get titleLarge => GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static TextStyle get titleMedium => GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
  
  static TextStyle get labelLarge => GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  // Theme Data
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryBackground,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      secondary: primaryPurple,
      surface: secondaryBackground,
      error: Color(0xFFEF4444),
    ),
    textTheme: TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      labelLarge: labelLarge,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      hintStyle: bodyMedium.copyWith(color: textMuted),
      labelStyle: bodyMedium,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: textPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: textPrimary,
        side: const BorderSide(color: inputBorder),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: labelLarge,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: inputBorder, width: 1),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBackground,
      elevation: 0,
      titleTextStyle: titleLarge,
      iconTheme: const IconThemeData(color: textPrimary),
    ),
  );
}

// Gradient Text Widget
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    this.gradient = AppTheme.primaryGradient,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: (style ?? AppTheme.displayLarge).copyWith(color: Colors.white),
        textAlign: textAlign,
        softWrap: true,
      ),
    );
  }
}

// Grid Background Painter
class GridBackgroundPainter extends CustomPainter {
  final Color gridColor;
  final double gridSize;

  GridBackgroundPainter({
    this.gridColor = AppTheme.gridColor,
    this.gridSize = 40,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor.withValues(alpha: 0.3)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Grid Background Widget
class GridBackground extends StatelessWidget {
  final Widget child;
  final Color? gridColor;
  final double? gridSize;

  const GridBackground({
    super.key,
    required this.child,
    this.gridColor,
    this.gridSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridBackgroundPainter(
        gridColor: gridColor ?? AppTheme.gridColor,
        gridSize: gridSize ?? 40,
      ),
      child: child,
    );
  }
}

// Animated Mesh Gradient Background
class AnimatedMeshGradient extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;

  const AnimatedMeshGradient({
    super.key,
    required this.child,
    this.colors,
  });

  @override
  State<AnimatedMeshGradient> createState() => _AnimatedMeshGradientState();
}

class _AnimatedMeshGradientState extends State<AnimatedMeshGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: MeshGradientPainter(
            animation: _controller.value,
            colors: widget.colors ?? [
              AppTheme.primaryBlue.withValues(alpha: 0.15),
              AppTheme.primaryPurple.withValues(alpha: 0.1),
              AppTheme.accentPink.withValues(alpha: 0.08),
              AppTheme.accentTeal.withValues(alpha: 0.12),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

class MeshGradientPainter extends CustomPainter {
  final double animation;
  final List<Color> colors;

  MeshGradientPainter({
    required this.animation,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Create animated blob positions
    for (int i = 0; i < colors.length; i++) {
      final phase = animation * 2 * math.pi + (i * math.pi / 2);
      final xOffset = math.sin(phase) * size.width * 0.3;
      final yOffset = math.cos(phase * 0.7) * size.height * 0.3;
      
      final centerX = size.width * (0.2 + (i * 0.25)) + xOffset;
      final centerY = size.height * (0.3 + (i * 0.15)) + yOffset;
      
      paint.shader = RadialGradient(
        colors: [colors[i], colors[i].withValues(alpha: 0)],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: size.width * 0.5,
      ));
      
      canvas.drawCircle(
        Offset(centerX, centerY),
        size.width * 0.5,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(MeshGradientPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

// Staggered Animation Controller Helper
class StaggeredAnimation {
  final AnimationController controller;
  final double delay;
  final double duration;

  StaggeredAnimation({
    required this.controller,
    required this.delay,
    this.duration = 0.4,
  });

  Animation<double> get fadeAnimation => Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Interval(delay, (delay + duration).clamp(0.0, 1.0), curve: Curves.easeOut),
  ));

  Animation<Offset> get slideAnimation => Tween<Offset>(
    begin: const Offset(0, 30),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Interval(delay, (delay + duration).clamp(0.0, 1.0), curve: Curves.easeOutCubic),
  ));
}

// Profile Photo Widget with Glow
class ProfilePhotoWidget extends StatefulWidget {
  final String? imagePath;
  final double size;
  final bool showGlow;

  const ProfilePhotoWidget({
    super.key,
    this.imagePath,
    this.size = 200,
    this.showGlow = true,
  });

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final glowIntensity = 0.3 + (_glowController.value * 0.4);
        
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: widget.showGlow ? [
              BoxShadow(
                color: AppTheme.primaryBlue.withValues(alpha: glowIntensity * 0.5),
                blurRadius: 40,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: AppTheme.primaryPurple.withValues(alpha: glowIntensity * 0.3),
                blurRadius: 60,
                spreadRadius: 10,
              ),
            ] : null,
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryBlue,
                  AppTheme.primaryPurple,
                  AppTheme.accentPink,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryBackground,
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: widget.imagePath != null
                    ? Image.asset(
                        assetPathForImage(widget.imagePath!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.surfaceColor,
      child: Icon(
        Icons.person,
        size: widget.size * 0.5,
        color: AppTheme.textMuted,
      ),
    );
  }
}

// Shimmer Loading Effect
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final bool isLoading;

  const ShimmerEffect({
    super.key,
    required this.child,
    this.isLoading = true,
  });

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                AppTheme.surfaceColor,
                AppTheme.cardBackground,
                AppTheme.surfaceColor,
              ],
              stops: [
                (_controller.value - 0.3).clamp(0.0, 1.0),
                _controller.value,
                (_controller.value + 0.3).clamp(0.0, 1.0),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

// Animated Scale on Hover
class HoverScaleWidget extends StatefulWidget {
  final Widget child;
  final double scale;
  final VoidCallback? onTap;

  const HoverScaleWidget({
    super.key,
    required this.child,
    this.scale = 1.03,
    this.onTap,
  });

  @override
  State<HoverScaleWidget> createState() => _HoverScaleWidgetState();
}

class _HoverScaleWidgetState extends State<HoverScaleWidget> {
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
          curve: AppTheme.defaultCurve,
          transform: Matrix4.diagonal3Values(
            _isHovered ? widget.scale : 1.0,
            _isHovered ? widget.scale : 1.0,
            1.0,
          ),
          transformAlignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
