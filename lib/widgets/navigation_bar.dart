import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../providers/locale_provider.dart';
import 'responsive_builder.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(String) onNavItemTap;

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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryBackground.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(
            color: AppTheme.inputBorder,
            width: 1,
          ),
        ),
      ),
      child: isMobile ? _buildMobileNav(l10n) : _buildDesktopNav(l10n),
    );
  }

  Widget _buildDesktopNav(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo/Name
        GestureDetector(
          onTap: () => widget.onNavItemTap('hero'),
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
        
        // Navigation Items
        Row(
          children: [
            _NavItem(label: l10n.navAbout, onTap: () => widget.onNavItemTap('about')),
            _NavItem(label: l10n.navExperience, onTap: () => widget.onNavItemTap('experience')),
            _NavItem(label: l10n.navProjects, onTap: () => widget.onNavItemTap('projects')),
            _NavItem(label: l10n.navSkills, onTap: () => widget.onNavItemTap('skills')),
            _NavItem(label: l10n.navContact, onTap: () => widget.onNavItemTap('contact')),
            const SizedBox(width: 16),
            const _LanguageDropdown(),
          ],
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
            
            // Menu and Language
            Row(
              children: [
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
                    widget.onNavItemTap('about');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navExperience,
                  onTap: () {
                    widget.onNavItemTap('experience');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navProjects,
                  onTap: () {
                    widget.onNavItemTap('projects');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navSkills,
                  onTap: () {
                    widget.onNavItemTap('skills');
                    setState(() => _isMenuOpen = false);
                  },
                ),
                _MobileNavItem(
                  label: l10n.navContact,
                  onTap: () {
                    widget.onNavItemTap('contact');
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
