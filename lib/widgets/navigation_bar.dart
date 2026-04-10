import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../providers/locale_provider.dart';
import 'responsive_builder.dart';
import '../services/analytics_service.dart';

/// [section] matches home keys: hero, about, experience, projects, skills, contact.
/// [source] is where the tap came from, e.g. `top_nav`, `mobile_menu`.
typedef PortfolioNavCallback = void Function(String section, String source);

class CustomNavigationBar extends StatefulWidget {
  final PortfolioNavCallback onNavItemTap;

  const CustomNavigationBar({
    super.key,
    required this.onNavItemTap,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = ResponsiveBuilder.isMobile(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: AppTheme.primaryBackground.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: AppTheme.inputBorder.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
          child: isMobile ? _buildMobileNav(l10n) : _buildDesktopNav(l10n),
        ),
      ),
    );
  }

  Widget _buildDesktopNav(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo/Name
        GestureDetector(
          onTap: () => widget.onNavItemTap('hero', 'top_nav'),
          child: Text(
            'AZM',
            style: AppTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = AppTheme.primaryGradient.createShader(
                  const Rect.fromLTWH(0, 0, 100, 30),
                ),
            ),
          ),
        ),

        // Navigation + actions: right-aligned; scroll horizontally only when content overflows
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _NavItem(label: l10n.navAbout, onTap: () => widget.onNavItemTap('about', 'top_nav')),
                      _NavItem(label: l10n.navExperience, onTap: () => widget.onNavItemTap('experience', 'top_nav')),
                      _NavItem(label: l10n.navProjects, onTap: () => widget.onNavItemTap('projects', 'top_nav')),
                      _NavItem(label: l10n.navSkills, onTap: () => widget.onNavItemTap('skills', 'top_nav')),
                      _NavItem(label: l10n.navContact, onTap: () => widget.onNavItemTap('contact', 'top_nav')),
                      const SizedBox(width: 16),
                      const _TopSocialLinks(),
                      const SizedBox(width: 12),
                      const _LanguageDropdown(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileNav(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo/Name
            Text(
              'AZM',
              style: AppTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = AppTheme.primaryGradient.createShader(
                    const Rect.fromLTWH(0, 0, 100, 30),
                  ),
              ),
            ),

            // Menu and Language (right side, same as before)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _TopSocialLinks(compact: true),
                const SizedBox(width: 8),
                const _LanguageDropdown(compact: true),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    _isMenuOpen ? Icons.close : Icons.menu,
                    color: AppTheme.textPrimary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        
        // Mobile Menu Items
        if (_isMenuOpen)
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                _MobileNavItem(
                  label: l10n.navAbout,
                  onTap: () {
                    widget.onNavItemTap('about', 'mobile_menu');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navExperience,
                  onTap: () {
                    widget.onNavItemTap('experience', 'mobile_menu');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navProjects,
                  onTap: () {
                    widget.onNavItemTap('projects', 'mobile_menu');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navSkills,
                  onTap: () {
                    widget.onNavItemTap('skills', 'mobile_menu');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navContact,
                  onTap: () {
                    widget.onNavItemTap('contact', 'mobile_menu');
                    setState(() => _isMenuOpen = false);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.shortAnimation,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.label,
            style: AppTheme.bodyLarge.copyWith(
              color: _isHovered ? AppTheme.primaryBlue : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.inputBorder, width: 0.5),
          ),
        ),
        child: Text(
          label,
          style: AppTheme.bodyLarge.copyWith(color: AppTheme.textPrimary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  final bool compact;

  const _LanguageDropdown({this.compact = false});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale;

    return PopupMenuButton<Locale>(
      offset: const Offset(0, 40),
      color: AppTheme.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.inputBorder),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.inputBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleProvider.localeFlags[currentLocale.languageCode] ?? '🌐',
              style: const TextStyle(fontSize: 16),
            ),
            if (!compact) ...[
              const SizedBox(width: 8),
              Text(
                LocaleProvider.localeNames[currentLocale.languageCode] ?? 'English',
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.textPrimary),
              ),
            ],
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppTheme.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
      onSelected: (Locale locale) {
        localeProvider.setLocale(locale);
      },
      itemBuilder: (context) => LocaleProvider.supportedLocales.map((locale) {
        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            children: [
              Text(
                LocaleProvider.localeFlags[locale.languageCode] ?? '🌐',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 12),
              Text(
                LocaleProvider.localeNames[locale.languageCode] ?? 'Unknown',
                style: AppTheme.bodyMedium.copyWith(
                  color: locale == currentLocale
                      ? AppTheme.primaryBlue
                      : AppTheme.textPrimary,
                ),
              ),
              if (locale == currentLocale)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.check,
                    color: AppTheme.primaryBlue,
                    size: 16,
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _TopSocialLinks extends StatelessWidget {
  final bool compact;

  const _TopSocialLinks({this.compact = false});

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 14.0 : 15.0;
    final buttonSize = compact ? 32.0 : 34.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialNavIcon(
          icon: FontAwesomeIcons.linkedinIn,
          url: AppConstants.linkedInUrl,
          tooltip: 'LinkedIn',
          linkType: 'linkedin',
          iconSize: iconSize,
          size: buttonSize,
        ),
        const SizedBox(width: 8),
        _SocialNavIcon(
          icon: FontAwesomeIcons.whatsapp,
          url: getWhatsAppUrl(),
          tooltip: 'WhatsApp',
          linkType: 'whatsapp',
          iconSize: iconSize,
          size: buttonSize,
        ),
        const SizedBox(width: 8),
        _SocialNavIcon(
          icon: FontAwesomeIcons.github,
          url: AppConstants.githubUrl,
          tooltip: 'GitHub',
          linkType: 'github',
          iconSize: iconSize,
          size: buttonSize,
        ),
      ],
    );
  }
}

class _SocialNavIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  final String linkType;
  final double iconSize;
  final double size;

  const _SocialNavIcon({
    required this.icon,
    required this.url,
    required this.tooltip,
    required this.linkType,
    required this.iconSize,
    required this.size,
  });

  @override
  State<_SocialNavIcon> createState() => _SocialNavIconState();
}

class _SocialNavIconState extends State<_SocialNavIcon> {
  bool _isHovered = false;

  Future<void> _openLink() async {
    await AnalyticsService.logLinkOpen(widget.linkType);
    final uri = Uri.tryParse(widget.url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _openLink,
          child: AnimatedContainer(
            duration: AppConstants.shortAnimation,
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppTheme.primaryBlue.withValues(alpha: 0.16)
                  : AppTheme.surfaceColor.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isHovered
                    ? AppTheme.primaryBlue.withValues(alpha: 0.75)
                    : AppTheme.inputBorder,
              ),
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: widget.iconSize,
                color: _isHovered ? AppTheme.primaryBlue : AppTheme.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
