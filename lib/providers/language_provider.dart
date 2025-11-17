import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 🌐 إدارة اللغة في التطبيق
class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('ar', 'SA');
  
  Locale get currentLocale => _currentLocale;
  bool get isArabic => _currentLocale.languageCode == 'ar';
  bool get isEnglish => _currentLocale.languageCode == 'en';

  LanguageProvider() {
    _loadLanguage();
  }

  // تحميل اللغة المحفوظة
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'ar';
    final countryCode = prefs.getString('country_code') ?? 'SA';
    _currentLocale = Locale(languageCode, countryCode);
    notifyListeners();
  }

  // تغيير اللغة
  Future<void> setLanguage(String languageCode, String countryCode) async {
    _currentLocale = Locale(languageCode, countryCode);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
    await prefs.setString('country_code', countryCode);
    
    notifyListeners();
  }

  // التبديل بين العربية والإنجليزية
  Future<void> toggleLanguage() async {
    if (isArabic) {
      await setLanguage('en', 'US');
    } else {
      await setLanguage('ar', 'SA');
    }
  }

  // النصوص المترجمة
  Map<String, dynamic> get translations => isArabic ? _arabicTranslations : _englishTranslations;

  // الترجمات العربية
  static const Map<String, dynamic> _arabicTranslations = {
    'appName': 'VisCend Studio',
    'slogan': 'استوديو التميز البصري',
    
    // Navigation
    'home': 'الرئيسية',
    'about': 'من نحن',
    'services': 'الخدمات',
    'portfolio': 'الأعمال',
    'contact': 'التواصل',
    
    // Home Page
    'welcome': 'مرحباً بك في',
    'heroTitle': 'نصنع التجارب الرقمية المميزة',
    'heroSubtitle': 'نحول أفكارك إلى واقع رقمي متميز من خلال تصميم وتطوير مبتكر',
    'getStarted': 'ابدأ الآن',
    'learnMore': 'اعرف المزيد',
    
    // About Page
    'aboutTitle': 'من نحن',
    'aboutDescription': 'نحن فريق من المصممين والمطورين المبدعين، نسعى لتقديم حلول رقمية مبتكرة تساعد الشركات على النمو والتميز في العالم الرقمي.',
    'ourVision': 'رؤيتنا',
    'visionText': 'أن نكون الخيار الأول للشركات الطموحة التي تبحث عن التميز الرقمي والابتكار في التصميم والتطوير.',
    'ourMission': 'رسالتنا',
    'missionText': 'تقديم حلول رقمية متكاملة تجمع بين الإبداع والتقنية لتحقيق أهداف عملائنا وتجاوز توقعاتهم.',
    
    // Services Page
    'servicesTitle': 'خدماتنا',
    'servicesDescription': 'نقدم مجموعة متكاملة من الخدمات الرقمية',
    'webDesign': 'تصميم المواقع',
    'webDesignDesc': 'تصميم مواقع احترافية وعصرية تعكس هوية علامتك التجارية',
    'appDevelopment': 'تطوير التطبيقات',
    'appDevelopmentDesc': 'بناء تطبيقات موبايل متقدمة لنظامي iOS و Android',
    'branding': 'الهوية البصرية',
    'brandingDesc': 'تصميم هوية بصرية متكاملة ومميزة لعلامتك التجارية',
    'uiux': 'تصميم UI/UX',
    'uiuxDesc': 'تصميم تجارب مستخدم سلسة وجذابة',
    'marketing': 'التسويق الرقمي',
    'marketingDesc': 'استراتيجيات تسويق رقمي فعالة لنمو أعمالك',
    'consulting': 'الاستشارات',
    'consultingDesc': 'استشارات تقنية متخصصة لمشاريعك الرقمية',
    
    // Portfolio Page
    'portfolioTitle': 'أعمالنا',
    'portfolioDescription': 'اطلع على بعض مشاريعنا المميزة',
    'viewProject': 'عرض المشروع',
    
    // Contact Page
    'contactTitle': 'تواصل معنا',
    'contactDescription': 'نحن هنا للإجابة على استفساراتك',
    'yourName': 'اسمك',
    'yourEmail': 'بريدك الإلكتروني',
    'yourPhone': 'رقم الهاتف (اختياري)',
    'yourMessage': 'رسالتك',
    'sendMessage': 'إرسال الرسالة',
    'sending': 'جاري الإرسال...',
    'messageSent': 'تم إرسال رسالتك بنجاح',
    'messageError': 'حدث خطأ، يرجى المحاولة مرة أخرى',
    
    // Contact Info
    'phone': 'الهاتف',
    'email': 'البريد الإلكتروني',
    'address': 'العنوان',
    'followUs': 'تابعنا',
    
    // Common
    'loading': 'جاري التحميل...',
    'error': 'حدث خطأ',
    'tryAgain': 'حاول مرة أخرى',
    'close': 'إغلاق',
  };

  // الترجمات الإنجليزية
  static const Map<String, dynamic> _englishTranslations = {
    'appName': 'VisCend Studio',
    'slogan': 'Visual Excellence Studio',
    
    // Navigation
    'home': 'Home',
    'about': 'About',
    'services': 'Services',
    'portfolio': 'Portfolio',
    'contact': 'Contact',
    
    // Home Page
    'welcome': 'Welcome to',
    'heroTitle': 'We Create Outstanding Digital Experiences',
    'heroSubtitle': 'Transform your ideas into exceptional digital reality through innovative design and development',
    'getStarted': 'Get Started',
    'learnMore': 'Learn More',
    
    // About Page
    'aboutTitle': 'About Us',
    'aboutDescription': 'We are a team of creative designers and developers, striving to provide innovative digital solutions that help companies grow and excel in the digital world.',
    'ourVision': 'Our Vision',
    'visionText': 'To be the first choice for ambitious companies seeking digital excellence and innovation in design and development.',
    'ourMission': 'Our Mission',
    'missionText': 'Providing integrated digital solutions that combine creativity and technology to achieve our clients\' goals and exceed their expectations.',
    
    // Services Page
    'servicesTitle': 'Our Services',
    'servicesDescription': 'We offer a complete range of digital services',
    'webDesign': 'Web Design',
    'webDesignDesc': 'Professional and modern website design that reflects your brand identity',
    'appDevelopment': 'App Development',
    'appDevelopmentDesc': 'Building advanced mobile applications for iOS and Android',
    'branding': 'Branding',
    'brandingDesc': 'Designing a complete and distinctive visual identity for your brand',
    'uiux': 'UI/UX Design',
    'uiuxDesc': 'Designing smooth and attractive user experiences',
    'marketing': 'Digital Marketing',
    'marketingDesc': 'Effective digital marketing strategies for your business growth',
    'consulting': 'Consulting',
    'consultingDesc': 'Specialized technical consulting for your digital projects',
    
    // Portfolio Page
    'portfolioTitle': 'Our Work',
    'portfolioDescription': 'Check out some of our featured projects',
    'viewProject': 'View Project',
    
    // Contact Page
    'contactTitle': 'Contact Us',
    'contactDescription': 'We are here to answer your questions',
    'yourName': 'Your Name',
    'yourEmail': 'Your Email',
    'yourPhone': 'Phone Number (Optional)',
    'yourMessage': 'Your Message',
    'sendMessage': 'Send Message',
    'sending': 'Sending...',
    'messageSent': 'Your message has been sent successfully',
    'messageError': 'An error occurred, please try again',
    
    // Contact Info
    'phone': 'Phone',
    'email': 'Email',
    'address': 'Address',
    'followUs': 'Follow Us',
    
    // Common
    'loading': 'Loading...',
    'error': 'An error occurred',
    'tryAgain': 'Try Again',
    'close': 'Close',
  };
}
