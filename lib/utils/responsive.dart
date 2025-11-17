/// 📱 أدوات التصميم المتجاوب (Responsive)
import 'package:flutter/material.dart';

class Responsive {
  /// الحصول على عرض الشاشة
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// الحصول على ارتفاع الشاشة
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// هل الجهاز موبايل؟ (أقل من 600px)
  static bool isMobile(BuildContext context) {
    return width(context) < 600;
  }

  /// هل الجهاز تابلت؟ (بين 600 و 900px)
  static bool isTablet(BuildContext context) {
    return width(context) >= 600 && width(context) < 900;
  }

  /// هل الجهاز ديسكتوب؟ (أكبر من 900px)
  static bool isDesktop(BuildContext context) {
    return width(context) >= 900;
  }

  /// الحصول على Padding مناسب
  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 32);
    }
  }

  /// الحصول على حجم خط متجاوب
  static double fontSize(BuildContext context, double baseSize) {
    double screenWidth = width(context);
    
    if (screenWidth < 360) {
      return baseSize * 0.85; // شاشات صغيرة جداً
    } else if (screenWidth < 600) {
      return baseSize; // موبايل عادي
    } else if (screenWidth < 900) {
      return baseSize * 1.1; // تابلت
    } else {
      return baseSize * 1.2; // ديسكتوب
    }
  }

  /// الحصول على عدد الأعمدة في Grid
  static int gridCrossAxisCount(BuildContext context, {int? mobile, int? tablet, int? desktop}) {
    if (isMobile(context)) {
      return mobile ?? 2;
    } else if (isTablet(context)) {
      return tablet ?? 3;
    } else {
      return desktop ?? 4;
    }
  }

  /// Widget Builder حسب حجم الشاشة
  static Widget builder({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// قيمة متجاوبة حسب نوع الجهاز
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// Safe Area Padding
  static EdgeInsets safeArea(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// حجم AppBar متجاوب
  static double appBarHeight(BuildContext context) {
    return isMobile(context) ? 56 : 64;
  }

  /// Icon Size متجاوب
  static double iconSize(BuildContext context, double baseSize) {
    if (isMobile(context)) {
      return baseSize;
    } else if (isTablet(context)) {
      return baseSize * 1.2;
    } else {
      return baseSize * 1.4;
    }
  }

  /// Horizontal Padding متجاوب
  static double horizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return 20.0;
    } else if (isTablet(context)) {
      return 32.0;
    } else {
      return 48.0;
    }
  }
}

/// Extension على BuildContext للوصول السريع
extension ResponsiveContext on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  
  double get screenWidth => Responsive.width(this);
  double get screenHeight => Responsive.height(this);
  
  EdgeInsets get pagePadding => Responsive.pagePadding(this);
  EdgeInsets get safeArea => Responsive.safeArea(this);
}