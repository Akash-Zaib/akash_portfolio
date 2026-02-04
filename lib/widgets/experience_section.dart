import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../models/experience.dart';
import 'responsive_builder.dart';
import 'animated_entrance.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
        child: ContentContainer(
          child: Column(
            children: [
              // Section Title
              AnimatedEntrance(
                delay: Duration.zero,
                child: Column(
                  children: [
                    Text(
                      'EXPERIENCE',
                      style: AppTheme.labelLarge.copyWith(
                        color: AppTheme.primaryBlue,
                        letterSpacing: 3,
                        fontSize: isMobile ? 11 : 12,
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    GradientText(
                      text: l10n.experienceTitle,
                      style: isMobile ? AppTheme.headlineMedium : AppTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: isMobile ? 28 : 48),
              
              // Experience Timeline
              ...workExperiences.asMap().entries.map((entry) {
                final index = entry.key;
                final experience = entry.value;
                final isLast = index == workExperiences.length - 1;
                
                return AnimatedEntrance(
                  delay: Duration(milliseconds: 100 + (index * 120)),
                  child: _ExperienceCard(
                    experience: experience,
                    l10n: l10n,
                    isLast: isLast,
                    isMobile: isMobile,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final Experience experience;
  final AppLocalizations l10n;
  final bool isLast;
  final bool isMobile;

  const _ExperienceCard({
    required this.experience,
    required this.l10n,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;
  bool _isExpanded = false;

  String _getLocalizedText(String key) {
    final l10n = widget.l10n;
    switch (key) {
      case 'expConvoTitle': return l10n.expConvoTitle;
      case 'expConvoCompany': return l10n.expConvoCompany;
      case 'expConvoPeriod': return l10n.expConvoPeriod;
      case 'expConvoDescription': return l10n.expConvoDescription;
      case 'expConvoResp1': return l10n.expConvoResp1;
      case 'expConvoResp2': return l10n.expConvoResp2;
      case 'expConvoResp3': return l10n.expConvoResp3;
      case 'expConvoResp4': return l10n.expConvoResp4;
      case 'expConvoResp5': return l10n.expConvoResp5;
      case 'expTerabitTitle': return l10n.expTerabitTitle;
      case 'expTerabitCompany': return l10n.expTerabitCompany;
      case 'expTerabitPeriod': return l10n.expTerabitPeriod;
      case 'expTerabitDescription': return l10n.expTerabitDescription;
      case 'expTerabitResp1': return l10n.expTerabitResp1;
      case 'expTerabitResp2': return l10n.expTerabitResp2;
      case 'expTerabitResp3': return l10n.expTerabitResp3;
      case 'expTerabitResp4': return l10n.expTerabitResp4;
      case 'expVohTitle': return l10n.expVohTitle;
      case 'expVohCompany': return l10n.expVohCompany;
      case 'expVohPeriod': return l10n.expVohPeriod;
      case 'expVohDescription': return l10n.expVohDescription;
      case 'expVohResp1': return l10n.expVohResp1;
      case 'expVohResp2': return l10n.expVohResp2;
      case 'expVohResp3': return l10n.expVohResp3;
      case 'expVohResp4': return l10n.expVohResp4;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator (desktop only)
        if (!widget.isMobile)
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: widget.experience.isCurrent
                        ? AppTheme.primaryBlue
                        : AppTheme.surfaceColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primaryBlue,
                      width: 2,
                    ),
                  ),
                ),
                if (!widget.isLast)
                  Container(
                    width: 2,
                    height: 100,
                    color: AppTheme.inputBorder,
                  ),
              ],
            ),
          ),
          
          // Card content
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: EdgeInsets.only(bottom: widget.isLast ? 0 : (widget.isMobile ? 16 : 20)),
                  padding: EdgeInsets.all(widget.isMobile ? 16 : 20),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppTheme.primaryBlue.withValues(alpha: 0.08)
                        : AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                    border: Border.all(
                      color: _isHovered ? AppTheme.primaryBlue : AppTheme.inputBorder,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      widget.isMobile
                          ? _buildMobileHeader()
                          : _buildDesktopHeader(),
                      
                      const SizedBox(height: 10),
                      
                      // Description
                      Text(
                        _getLocalizedText(widget.experience.descriptionKey),
                        style: AppTheme.bodyMedium.copyWith(
                          fontSize: widget.isMobile ? 13 : 14,
                        ),
                      ),
                      
                      // Expandable responsibilities
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 14),
                            ...widget.experience.responsibilitiesKeys.map((key) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      width: 5,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                        color: AppTheme.primaryBlue,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _getLocalizedText(key),
                                        style: AppTheme.bodyMedium.copyWith(
                                          color: AppTheme.textSecondary,
                                          fontSize: widget.isMobile ? 12 : 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      ),
                      
                      // Expand/collapse indicator
                      const SizedBox(height: 6),
                      Center(
                        child: Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppTheme.textMuted,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Company
        Text(
          _getLocalizedText(widget.experience.titleKey),
          style: AppTheme.titleLarge.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(
          _getLocalizedText(widget.experience.companyKey),
          style: AppTheme.titleMedium.copyWith(
            color: AppTheme.primaryBlue,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        // Period badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: widget.experience.isCurrent
                ? AppTheme.primaryBlue.withValues(alpha: 0.15)
                : AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
            border: Border.all(
              color: widget.experience.isCurrent
                  ? AppTheme.primaryBlue
                  : AppTheme.inputBorder,
            ),
          ),
          child: Text(
            _getLocalizedText(widget.experience.periodKey),
            style: AppTheme.bodyMedium.copyWith(
              color: widget.experience.isCurrent
                  ? AppTheme.primaryBlue
                  : AppTheme.textSecondary,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getLocalizedText(widget.experience.titleKey),
                style: AppTheme.titleLarge,
              ),
              const SizedBox(height: 3),
              Text(
                _getLocalizedText(widget.experience.companyKey),
                style: AppTheme.titleMedium.copyWith(
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
        ),
        // Period badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: widget.experience.isCurrent
                ? AppTheme.primaryBlue.withValues(alpha: 0.15)
                : AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
            border: Border.all(
              color: widget.experience.isCurrent
                  ? AppTheme.primaryBlue
                  : AppTheme.inputBorder,
            ),
          ),
          child: Text(
            _getLocalizedText(widget.experience.periodKey),
            style: AppTheme.bodyMedium.copyWith(
              color: widget.experience.isCurrent
                  ? AppTheme.primaryBlue
                  : AppTheme.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
