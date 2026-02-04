import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../services/email_service.dart';
import 'responsive_builder.dart';
import 'animated_entrance.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  bool _isLoading = false;
  String? _statusMessage;
  bool _isSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    final success = await EmailService.sendEmail(
      name: _nameController.text,
      email: _emailController.text,
      message: _messageController.text,
    );

    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    
    setState(() {
      _isLoading = false;
      _isSuccess = success;
      _statusMessage = success ? l10n.contactSuccess : l10n.contactError;
    });

    if (success) {
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }

    // Clear status message after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() => _statusMessage = null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = ResponsiveBuilder.isMobile(context);

    return RepaintBoundary(
      child: GridBackground(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 48 : 80,
          ),
          child: ContentContainer(
            child: AnimatedEntrance(
              delay: Duration.zero,
              child: Container(
                padding: EdgeInsets.all(isMobile ? 24 : 48),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                  border: Border.all(
                    color: AppTheme.inputBorder.withValues(alpha: 0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Section label
                    Text(
                      'CONTACT',
                      style: AppTheme.labelLarge.copyWith(
                        color: AppTheme.primaryBlue,
                        letterSpacing: 3,
                        fontSize: isMobile ? 11 : 12,
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    
                    // Title
                    GradientText(
                      text: l10n.contactTitle,
                      style: isMobile 
                          ? AppTheme.headlineMedium 
                          : AppTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: isMobile ? 10 : 14),
                    
                    // Subtitle
                    Text(
                      l10n.contactSubtitle,
                      style: AppTheme.bodyLarge.copyWith(
                        fontSize: isMobile ? 13 : 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: AppTheme.textMuted,
                          size: 12,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppConstants.location,
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textMuted,
                            fontSize: isMobile ? 12 : 13,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: isMobile ? 28 : 40),
                  
                  // Contact Form
                  Form(
                    key: _formKey,
                    child: _buildForm(l10n, isMobile),
                  ),
                  
                  SizedBox(height: isMobile ? 20 : 28),
                  
                  // Submit Button
                  _SubmitButton(
                    label: l10n.contactSend,
                    isLoading: _isLoading,
                    onTap: _submitForm,
                    isMobile: isMobile,
                  ),
                  
                  // Status Message
                  if (_statusMessage != null) ...[
                    const SizedBox(height: 14),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: (_isSuccess ? Colors.green : Colors.red)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                          border: Border.all(
                            color: _isSuccess ? Colors.green : Colors.red,
                          ),
                        ),
                        child: Text(
                          _statusMessage!,
                          style: AppTheme.bodyMedium.copyWith(
                            color: _isSuccess ? Colors.green : Colors.red,
                            fontSize: isMobile ? 12 : 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                  
                  SizedBox(height: isMobile ? 24 : 36),
                  
                  // View Resume Button
                  _ViewResumeButton(label: l10n.viewResume, isMobile: isMobile),
                  
                  SizedBox(height: isMobile ? 20 : 28),
                  
                    // Social Links
                    _SocialLinks(isMobile: isMobile),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isMobile) {
    return Column(
      children: [
        _FormField(
          controller: _nameController,
          label: l10n.contactName,
          hint: l10n.contactNameHint,
          isMobile: isMobile,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        SizedBox(height: isMobile ? 14 : 18),
        _FormField(
          controller: _emailController,
          label: l10n.contactEmail,
          hint: l10n.contactEmailHint,
          keyboardType: TextInputType.emailAddress,
          isMobile: isMobile,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        SizedBox(height: isMobile ? 14 : 18),
        _FormField(
          controller: _messageController,
          label: l10n.contactMessage,
          hint: l10n.contactMessageHint,
          maxLines: isMobile ? 4 : 5,
          isMobile: isMobile,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your message';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isMobile;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.labelLarge.copyWith(
            color: AppTheme.textSecondary,
            fontSize: isMobile ? 12 : 13,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textPrimary,
            fontSize: isMobile ? 14 : 15,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textMuted,
              fontSize: isMobile ? 13 : 14,
            ),
            contentPadding: EdgeInsets.all(isMobile ? 12 : 14),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  final bool isMobile;

  const _SubmitButton({
    required this.label,
    required this.isLoading,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 360),
          padding: EdgeInsets.symmetric(vertical: widget.isMobile ? 14 : 16),
          decoration: BoxDecoration(
            gradient: widget.isLoading
                ? null
                : (_isHovered ? AppTheme.buttonGradient : AppTheme.primaryGradient),
            color: widget.isLoading ? AppTheme.surfaceColor : null,
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            boxShadow: _isHovered && !widget.isLoading
                ? [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    height: widget.isMobile ? 18 : 20,
                    width: widget.isMobile ? 18 : 20,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.textPrimary,
                      ),
                    ),
                  )
                : Text(
                    widget.label,
                    style: AppTheme.labelLarge.copyWith(
                      color: Colors.white,
                      fontSize: widget.isMobile ? 14 : 15,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _ViewResumeButton extends StatefulWidget {
  final String label;
  final bool isMobile;

  const _ViewResumeButton({required this.label, required this.isMobile});

  @override
  State<_ViewResumeButton> createState() => _ViewResumeButtonState();
}

class _ViewResumeButtonState extends State<_ViewResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _openResume,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 24 : 28,
            vertical: widget.isMobile ? 12 : 14,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.surfaceColor
                : AppTheme.secondaryBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: Border.all(color: AppTheme.inputBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.fileLines,
                color: AppTheme.textPrimary,
                size: widget.isMobile ? 14 : 16,
              ),
              SizedBox(width: widget.isMobile ? 8 : 10),
              Text(
                widget.label,
                style: AppTheme.labelLarge.copyWith(
                  fontSize: widget.isMobile ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openResume() async {
    final uri = Uri.parse(AppConstants.cvPath);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SocialLinks extends StatelessWidget {
  final bool isMobile;
  
  const _SocialLinks({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: FontAwesomeIcons.github,
          color: AppTheme.textPrimary,
          onTap: () => _launchUrl(AppConstants.githubUrl),
          isMobile: isMobile,
        ),
        SizedBox(width: isMobile ? 12 : 16),
        _SocialButton(
          icon: FontAwesomeIcons.linkedin,
          color: const Color(0xFF0A66C2),
          onTap: () => _launchUrl(AppConstants.linkedInUrl),
          isMobile: isMobile,
        ),
        SizedBox(width: isMobile ? 12 : 16),
        _SocialButton(
          icon: FontAwesomeIcons.whatsapp,
          color: const Color(0xFF25D366),
          onTap: () => _launchUrl(getWhatsAppUrl()),
          isMobile: isMobile,
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isMobile;

  const _SocialButton({
    required this.icon,
    required this.color,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
          padding: EdgeInsets.all(widget.isMobile ? 12 : 14),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withValues(alpha: 0.15)
                : AppTheme.surfaceColor.withValues(alpha: 0.5),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered ? widget.color : AppTheme.inputBorder,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: FaIcon(
            widget.icon,
            color: _isHovered ? widget.color : AppTheme.textSecondary,
            size: widget.isMobile ? 18 : 20,
          ),
        ),
      ),
    );
  }
}
