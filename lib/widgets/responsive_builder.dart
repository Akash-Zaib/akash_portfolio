import 'package:flutter/material.dart';
import '../config/constants.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < AppConstants.tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Get responsive padding based on screen size
  static EdgeInsets getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileBreakpoint) {
      return const EdgeInsets.symmetric(horizontal: 16);
    } else if (width < AppConstants.tabletBreakpoint) {
      return const EdgeInsets.symmetric(horizontal: 28);
    } else {
      // Calculate padding to center content with max width
      final padding = (width - AppConstants.maxContentWidth) / 2;
      return EdgeInsets.symmetric(horizontal: padding.clamp(40.0, double.infinity));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = getDeviceType(context);
        
        // Use specific widgets if provided, otherwise use builder
        if (deviceType == DeviceType.mobile && mobile != null) {
          return mobile!;
        } else if (deviceType == DeviceType.tablet && tablet != null) {
          return tablet!;
        } else if (deviceType == DeviceType.desktop && desktop != null) {
          return desktop!;
        }
        
        return builder(context, deviceType);
      },
    );
  }
}

// Responsive Widget Helper
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveBuilder.getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }
}

// Content Container with max width
class ContentContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  const ContentContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? AppConstants.maxContentWidth,
        ),
        padding: padding ?? ResponsiveBuilder.getHorizontalPadding(context),
        child: child,
      ),
    );
  }
}
