/// 🔗 ثوابت التطبيق والروابط

class AppConstants {
  // معلومات الشركة
  static const String companyNameAr = 'VisCend Studio';
  static const String companyNameEn = 'VisCend Studio';
  static const String companyTaglineAr = 'استوديو التميز البصري';
  static const String companyTaglineEn = 'Visual Excellence Studio';
  
  // معلومات الاتصال
  static const String email = 'info@viscend.com';
  static const String phone = '+966 50 123 4567';
  static const String whatsapp = '+966501234567';
  static const String address = 'الرياض، المملكة العربية السعودية';
  
  // روابط التواصل الاجتماعي
  static const String facebookUrl = 'https://facebook.com/viscendstudio';
  static const String twitterUrl = 'https://twitter.com/viscendstudio';
  static const String instagramUrl = 'https://instagram.com/viscendstudio';
  static const String linkedinUrl = 'https://linkedin.com/company/viscendstudio';
  static const String githubUrl = 'https://github.com/viscendstudio';
  static const String behanceUrl = 'https://behance.net/viscendstudio';
  static const String dribbbleUrl = 'https://dribbble.com/viscendstudio';
  
  // روابط الموقع
  static const String websiteUrl = 'https://viscend.com';
  static const String blogUrl = 'https://blog.viscend.com';
  
  // معلومات التطبيق
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // حدود وتحقق
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int minMessageLength = 10;
  static const int maxMessageLength = 1000;
  
  // وقت الانتظار للطلبات
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // حجم الأيقونات
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;
  
  // التباعد
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // نصف القطر
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
}

/// 🌐 روابط التواصل الاجتماعي
class SocialLinks {
  final String name;
  final String url;
  final String icon;
  
  const SocialLinks({
    required this.name,
    required this.url,
    required this.icon,
  });
  
  static const List<SocialLinks> all = [
    SocialLinks(
      name: 'Facebook',
      url: AppConstants.facebookUrl,
      icon: 'facebook',
    ),
    SocialLinks(
      name: 'Twitter',
      url: AppConstants.twitterUrl,
      icon: 'twitter',
    ),
    SocialLinks(
      name: 'Instagram',
      url: AppConstants.instagramUrl,
      icon: 'instagram',
    ),
    SocialLinks(
      name: 'LinkedIn',
      url: AppConstants.linkedinUrl,
      icon: 'linkedin',
    ),
    SocialLinks(
      name: 'GitHub',
      url: AppConstants.githubUrl,
      icon: 'github',
    ),
    SocialLinks(
      name: 'Behance',
      url: AppConstants.behanceUrl,
      icon: 'behance',
    ),
    SocialLinks(
      name: 'Dribbble',
      url: AppConstants.dribbbleUrl,
      icon: 'dribbble',
    ),
  ];
}
