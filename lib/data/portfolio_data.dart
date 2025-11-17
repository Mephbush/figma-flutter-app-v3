import '../models/portfolio_model.dart';

/// 📊 بيانات المشاريع الثابتة للبورتفوليو
class PortfolioData {
  static List<PortfolioModel> getAllProjects() {
    return [
      PortfolioModel(
        id: '1',
        titleAr: 'تطبيق متجر إلكتروني',
        titleEn: 'E-Commerce Mobile App',
        descriptionAr: 'تطبيق متجر إلكتروني متكامل مع نظام دفع آمن وإدارة المنتجات والطلبات',
        descriptionEn: 'Complete e-commerce mobile app with secure payment, product and order management',
        categoryAr: 'تطبيقات الجوال',
        categoryEn: 'Mobile Apps',
        imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800',
        demoUrl: 'https://demo.viscend.com/ecommerce',
        githubUrl: 'https://github.com/viscendstudio/ecommerce-app',
        technologies: ['Flutter', 'Firebase', 'Stripe', 'Provider'],
        isFeatured: true,
        completedAt: DateTime(2024, 10, 15),
      ),
      PortfolioModel(
        id: '2',
        titleAr: 'موقع شركة تقنية',
        titleEn: 'Tech Company Website',
        descriptionAr: 'موقع احترافي لشركة تقنية مع لوحة تحكم لإدارة المحتوى والمدونة',
        descriptionEn: 'Professional tech company website with CMS and blog management',
        categoryAr: 'تصميم مواقع',
        categoryEn: 'Web Design',
        imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800',
        demoUrl: 'https://demo.viscend.com/techco',
        technologies: ['React', 'Next.js', 'Tailwind CSS', 'Supabase'],
        isFeatured: true,
        completedAt: DateTime(2024, 9, 20),
      ),
      PortfolioModel(
        id: '3',
        titleAr: 'هوية بصرية لمطعم',
        titleEn: 'Restaurant Branding',
        descriptionAr: 'تصميم هوية بصرية متكاملة لمطعم تشمل الشعار والقوائم والمطبوعات',
        descriptionEn: 'Complete visual identity for restaurant including logo, menus and prints',
        categoryAr: 'الهوية البصرية',
        categoryEn: 'Branding',
        imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
        demoUrl: 'https://behance.net/gallery/restaurant-brand',
        technologies: ['Illustrator', 'Photoshop', 'InDesign'],
        isFeatured: true,
        completedAt: DateTime(2024, 8, 10),
      ),
      PortfolioModel(
        id: '4',
        titleAr: 'تطبيق إدارة المشاريع',
        titleEn: 'Project Management App',
        descriptionAr: 'تطبيق ويب لإدارة المشاريع والمهام مع لوحة تحكم تفاعلية',
        descriptionEn: 'Web app for project and task management with interactive dashboard',
        categoryAr: 'تطبيقات ويب',
        categoryEn: 'Web Apps',
        imageUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800',
        demoUrl: 'https://demo.viscend.com/projectapp',
        githubUrl: 'https://github.com/viscendstudio/project-manager',
        technologies: ['Vue.js', 'Node.js', 'MongoDB', 'Socket.io'],
        isFeatured: false,
        completedAt: DateTime(2024, 7, 5),
      ),
      PortfolioModel(
        id: '5',
        titleAr: 'تطبيق توصيل طعام',
        titleEn: 'Food Delivery App',
        descriptionAr: 'تطبيق توصيل طعام مع تتبع الطلبات لحظياً وتكامل مع خرائط جوجل',
        descriptionEn: 'Food delivery app with real-time tracking and Google Maps integration',
        categoryAr: 'تطبيقات الجوال',
        categoryEn: 'Mobile Apps',
        imageUrl: 'https://images.unsplash.com/photo-1526367790999-0150786686a2?w=800',
        demoUrl: 'https://demo.viscend.com/foodapp',
        technologies: ['Flutter', 'Firebase', 'Google Maps', 'GetX'],
        isFeatured: true,
        completedAt: DateTime(2024, 6, 18),
      ),
      PortfolioModel(
        id: '6',
        titleAr: 'موقع تعليمي تفاعلي',
        titleEn: 'Interactive Learning Platform',
        descriptionAr: 'منصة تعليمية تفاعلية مع نظام اختبارات وشهادات',
        descriptionEn: 'Interactive learning platform with quiz system and certificates',
        categoryAr: 'تصميم مواقع',
        categoryEn: 'Web Design',
        imageUrl: 'https://images.unsplash.com/photo-1501504905252-473c47e087f8?w=800',
        demoUrl: 'https://demo.viscend.com/eduplatform',
        technologies: ['React', 'TypeScript', 'PostgreSQL', 'Redis'],
        isFeatured: false,
        completedAt: DateTime(2024, 5, 12),
      ),
      PortfolioModel(
        id: '7',
        titleAr: 'هوية بصرية لشركة ناشئة',
        titleEn: 'Startup Branding',
        descriptionAr: 'تصميم هوية بصرية كاملة لشركة ناشئة في مجال التقنية',
        descriptionEn: 'Complete visual identity design for a tech startup',
        categoryAr: 'الهوية البصرية',
        categoryEn: 'Branding',
        imageUrl: 'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=800',
        demoUrl: 'https://behance.net/gallery/startup-brand',
        technologies: ['Illustrator', 'Figma', 'After Effects'],
        isFeatured: false,
        completedAt: DateTime(2024, 4, 22),
      ),
      PortfolioModel(
        id: '8',
        titleAr: 'تطبيق حجز المواعيد',
        titleEn: 'Booking Management App',
        descriptionAr: 'تطبيق لإدارة وحجز المواعيد مع نظام إشعارات ذكي',
        descriptionEn: 'Appointment booking and management app with smart notifications',
        categoryAr: 'تطبيقات الجوال',
        categoryEn: 'Mobile Apps',
        imageUrl: 'https://images.unsplash.com/photo-1506784365847-bbad939e9335?w=800',
        demoUrl: 'https://demo.viscend.com/bookingapp',
        technologies: ['Flutter', 'Laravel', 'MySQL', 'FCM'],
        isFeatured: true,
        completedAt: DateTime(2024, 3, 8),
      ),
      PortfolioModel(
        id: '9',
        titleAr: 'لوحة تحكم تحليلات',
        titleEn: 'Analytics Dashboard',
        descriptionAr: 'لوحة تحكم تحليلية متقدمة مع رسوم بيانية تفاعلية',
        descriptionEn: 'Advanced analytics dashboard with interactive charts',
        categoryAr: 'تطبيقات ويب',
        categoryEn: 'Web Apps',
        imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800',
        demoUrl: 'https://demo.viscend.com/analytics',
        githubUrl: 'https://github.com/viscendstudio/analytics-dashboard',
        technologies: ['React', 'D3.js', 'Chart.js', 'Material-UI'],
        isFeatured: false,
        completedAt: DateTime(2024, 2, 14),
      ),
    ];
  }

  // الحصول على المشاريع المميزة فقط
  static List<PortfolioModel> getFeaturedProjects() {
    return getAllProjects().where((project) => project.isFeatured).toList();
  }

  // الحصول على المشاريع حسب الفئة
  static List<PortfolioModel> getProjectsByCategory(String categoryEn) {
    return getAllProjects()
        .where((project) => project.categoryEn == categoryEn)
        .toList();
  }

  // الحصول على الفئات المتاحة
  static List<String> getCategories() {
    final categories = getAllProjects()
        .map((project) => project.categoryEn)
        .toSet()
        .toList();
    return categories;
  }
}
