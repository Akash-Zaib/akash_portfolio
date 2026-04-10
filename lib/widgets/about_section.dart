import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../services/download_service.dart';
import 'responsive_builder.dart';
import 'animated_entrance.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = ResponsiveBuilder.isMobile(context);

    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: isMobile ? 48 : 80),
        child: ContentContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              AnimatedEntrance(
                delay: Duration.zero,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'ABOUT',
                        style: AppTheme.labelLarge.copyWith(
                          color: AppTheme.primaryBlue,
                          letterSpacing: 3,
                          fontSize: isMobile ? 11 : 12,
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      GradientText(
                        text: l10n.aboutTitle,
                        style: isMobile
                            ? AppTheme.headlineMedium
                            : AppTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 28 : 48),

              // About Content
              if (isMobile)
                _buildMobileLayout(context, l10n)
              else
                _buildDesktopLayout(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        AnimatedEntrance(
          delay: const Duration(milliseconds: 100),
          child: Text(
            l10n.aboutDescription,
            style: AppTheme.bodyLarge.copyWith(height: 1.7, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 24),

        // Info Cards
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: _InfoCard(
            icon: FontAwesomeIcons.graduationCap,
            title: l10n.aboutEducation,
            content:
                '${l10n.aboutEducationDegree}\n${l10n.aboutEducationUniversity}\n${l10n.aboutEducationCGPA}',
            isMobile: true,
          ),
        ),

        const SizedBox(height: 12),

        AnimatedEntrance(
          delay: const Duration(milliseconds: 280),
          child: _InfoCard(
            icon: FontAwesomeIcons.locationDot,
            title: l10n.aboutLocation,
            content: AppConstants.location,
            isMobile: true,
          ),
        ),

        const SizedBox(height: 12),

        AnimatedEntrance(
          delay: const Duration(milliseconds: 360),
          child: _InfoCard(
            icon: FontAwesomeIcons.envelope,
            title: l10n.contactEmail,
            content: AppConstants.email,
            onTap: () => _launchEmail(),
            isMobile: true,
          ),
        ),

        const SizedBox(height: 12),

        AnimatedEntrance(
          delay: const Duration(milliseconds: 440),
          child: _InfoCard(
            icon: FontAwesomeIcons.phone,
            title: l10n.aboutPhone,
            content: AppConstants.phone,
            onTap: () => _launchPhone(),
            isMobile: true,
          ),
        ),

        const SizedBox(height: 24),

        // CV Download Button
        AnimatedEntrance(
          delay: const Duration(milliseconds: 520),
          child: Center(
            child: _DownloadCVButton(
              downloadLabel: l10n.downloadCV,
              downloadingLabel: l10n.downloadingCV,
              downloadedLabel: l10n.downloadedCV,
              isMobile: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Description
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedEntrance(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  l10n.aboutDescription,
                  style: AppTheme.bodyLarge.copyWith(height: 1.8, fontSize: 16),
                ),
              ),

              const SizedBox(height: 32),

              // Education Card
              AnimatedEntrance(
                delay: const Duration(milliseconds: 200),
                child: _InfoCard(
                  icon: FontAwesomeIcons.graduationCap,
                  title: l10n.aboutEducation,
                  content:
                      '${l10n.aboutEducationDegree}\n${l10n.aboutEducationUniversity}\n${l10n.aboutEducationCGPA}',
                  isMobile: false,
                ),
              ),

              const SizedBox(height: 28),

              AnimatedEntrance(
                delay: const Duration(milliseconds: 300),
                child: _DownloadCVButton(
                  downloadLabel: l10n.downloadCV,
                  downloadingLabel: l10n.downloadingCV,
                  downloadedLabel: l10n.downloadedCV,
                  isMobile: false,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Right side - Contact Info
        Expanded(
          flex: 2,
          child: Column(
            children: [
              AnimatedEntrance(
                delay: const Duration(milliseconds: 150),
                child: _InfoCard(
                  icon: FontAwesomeIcons.locationDot,
                  title: l10n.aboutLocation,
                  content: AppConstants.location,
                  isMobile: false,
                ),
              ),

              const SizedBox(height: 16),

              AnimatedEntrance(
                delay: const Duration(milliseconds: 230),
                child: _InfoCard(
                  icon: FontAwesomeIcons.envelope,
                  title: l10n.contactEmail,
                  content: AppConstants.email,
                  onTap: () => _launchEmail(),
                  isMobile: false,
                ),
              ),

              const SizedBox(height: 16),

              AnimatedEntrance(
                delay: const Duration(milliseconds: 310),
                child: _InfoCard(
                  icon: FontAwesomeIcons.phone,
                  title: l10n.aboutPhone,
                  content: AppConstants.phone,
                  onTap: () => _launchPhone(),
                  isMobile: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Future<void> _launchEmail() async {
    final uri = Uri.parse('mailto:${AppConstants.email}');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Fallback: try without mode specification
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  static Future<void> _launchPhone() async {
    final uri = Uri.parse('tel:${AppConstants.phone}');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Fallback: try without mode specification
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }
}

class _InfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback? onTap;
  final bool isMobile;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    this.onTap,
    required this.isMobile,
  });

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.all(widget.isMobile ? 14 : 18),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.primaryBlue.withValues(alpha: 0.08)
                : AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: Border.all(
              color: _isHovered ? AppTheme.primaryBlue : AppTheme.inputBorder,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(widget.isMobile ? 10 : 12),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
                child: FaIcon(
                  widget.icon,
                  color: Colors.white,
                  size: widget.isMobile ? 16 : 18,
                ),
              ),
              SizedBox(width: widget.isMobile ? 14 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: AppTheme.labelLarge.copyWith(
                        color: AppTheme.textMuted,
                        fontSize: widget.isMobile ? 12 : 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.content,
                      style: AppTheme.bodyMedium.copyWith(
                        color: widget.onTap != null
                            ? AppTheme.primaryBlue
                            : AppTheme.textPrimary,
                        height: 1.4,
                        fontSize: widget.isMobile ? 13 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.onTap != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.textMuted,
                    size: widget.isMobile ? 14 : 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DownloadState { idle, downloading, downloaded }

class _DownloadCVButton extends StatefulWidget {
  final String downloadLabel;
  final String downloadingLabel;
  final String downloadedLabel;
  final bool isMobile;

  const _DownloadCVButton({
    required this.downloadLabel,
    required this.downloadingLabel,
    required this.downloadedLabel,
    required this.isMobile,
  });

  @override
  State<_DownloadCVButton> createState() => _DownloadCVButtonState();
}

class _DownloadCVButtonState extends State<_DownloadCVButton> {
  bool _isHovered = false;
  DownloadState _downloadState = DownloadState.idle;

  String get _buttonText {
    switch (_downloadState) {
      case DownloadState.idle:
        return widget.downloadLabel;
      case DownloadState.downloading:
        return widget.downloadingLabel;
      case DownloadState.downloaded:
        return widget.downloadedLabel;
    }
  }

  IconData get _buttonIcon {
    switch (_downloadState) {
      case DownloadState.idle:
        return FontAwesomeIcons.download;
      case DownloadState.downloading:
        return FontAwesomeIcons.spinner;
      case DownloadState.downloaded:
        return FontAwesomeIcons.check;
    }
  }

  bool get _isDisabled => _downloadState != DownloadState.idle;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _isDisabled ? null : _downloadCV,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 24 : 32,
            vertical: widget.isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            gradient: _isDisabled
                ? null
                : (_isHovered
                      ? AppTheme.buttonGradient
                      : AppTheme.primaryGradient),
            color: _isDisabled ? AppTheme.surfaceColor : null,
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            boxShadow: _isHovered && !_isDisabled
                ? [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_downloadState == DownloadState.downloading)
                SizedBox(
                  width: widget.isMobile ? 14 : 16,
                  height: widget.isMobile ? 14 : 16,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else
                FaIcon(
                  _buttonIcon,
                  color: _isDisabled ? AppTheme.textMuted : Colors.white,
                  size: widget.isMobile ? 14 : 16,
                ),
              SizedBox(width: widget.isMobile ? 8 : 12),
              Text(
                _buttonText,
                style: AppTheme.labelLarge.copyWith(
                  color: _isDisabled ? AppTheme.textMuted : Colors.white,
                  fontSize: widget.isMobile ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _downloadCV() async {
    if (_downloadState != DownloadState.idle) return;

    setState(() {
      _downloadState = DownloadState.downloading;
    });

    // Brief delay for UX
    await Future.delayed(const Duration(milliseconds: 800));

    // Use cvDownloadUrl for direct download
    final success = await DownloadService.downloadFile(
      AppConstants.cvDownloadUrl,
      AppConstants.cvFileName,
    );

    if (mounted) {
      setState(() {
        _downloadState = success
            ? DownloadState.downloaded
            : DownloadState.idle;
      });
    }
  }
}
