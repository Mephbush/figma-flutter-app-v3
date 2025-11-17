import 'package:flutter/material.dart';
import '../models/service_model.dart';

/// 🛠️ بيانات الخدمات الثابتة
class ServicesData {
  static List<ServiceModel> getAllServices() {
    return [
      ServiceModel(
        id: '1',
        titleAr: 'تصميم المواقع',
        titleEn: 'Web Design',
        descriptionAr: 'تصميم مواقع احترافية متجاوبة مع جميع الأجهزة باستخدام أحدث التقنيات',
        descriptionEn: 'Professional responsive website design using latest technologies',
        icon: Icons.language,
        color: const Color(0xFF9333EA),
        featuresAr: [
          'تصميم متجاوب مع جميع الشاشات',
          'واجهات مستخدم حديثة وجذابة',
          'أداء عالي وسرعة تحميل',
          'تحسين محركات البحث SEO',
          'دعم فني مستمر',
        ],
        featuresEn: [
          'Responsive design for all screens',
          'Modern and attractive UI',
          'High performance and fast loading',
          'SEO optimization',
          'Continuous technical support',
        ],
      ),
      ServiceModel(
        id: '2',
        titleAr: 'تطوير التطبيقات',
        titleEn: 'App Development',
        descriptionAr: 'تطوير تطبيقات جوال احترافية لأنظمة iOS و Android باستخدام Flutter',
        descriptionEn: 'Professional mobile app development for iOS & Android using Flutter',
        icon: Icons.phone_android,
        color: const Color(0xFF7C3AED),
        featuresAr: [
          'تطبيقات أصلية عالية الأداء',
          'تصميم واجهات سهل الاستخدام',
          'تكامل مع خدمات السحابة',
          'نظام إشعارات متقدم',
          'تحديثات دورية ودعم',
        ],
        featuresEn: [
          'High-performance native apps',
          'User-friendly interface design',
          'Cloud services integration',
          'Advanced notification system',
          'Regular updates and support',
        ],
      ),
      ServiceModel(
        id: '3',
        titleAr: 'الهوية البصرية',
        titleEn: 'Visual Identity',
        descriptionAr: 'تصميم هوية بصرية متكاملة تعكس قيم وشخصية علامتك التجارية',
        descriptionEn: 'Complete visual identity design reflecting your brand values and personality',
        icon: Icons.palette,
        color: const Color(0xFF3B82F6),
        featuresAr: [
          'تصميم شعار احترافي',
          'دليل هوية بصرية شامل',
          'تصميم بطاقات العمل',
          'تصميم المطبوعات',
          'ملفات قابلة للطباعة',
        ],
        featuresEn: [
          'Professional logo design',
          'Comprehensive brand guidelines',
          'Business card design',
          'Print design',
          'Print-ready files',
        ],
      ),
      ServiceModel(
        id: '4',
        titleAr: 'تصميم واجهات المستخدم',
        titleEn: 'UI/UX Design',
        descriptionAr: 'تصميم تجربة مستخدم استثنائية مع واجهات جميلة وسهلة الاستخدام',
        descriptionEn: 'Exceptional user experience design with beautiful and easy-to-use interfaces',
        icon: Icons.design_services,
        color: const Color(0xFF06B6D4),
        featuresAr: [
          'دراسة سلوك المستخدمين',
          'نماذج تفاعلية',
          'اختبار قابلية الاستخدام',
          'تصميم متوافق مع معايير الوصول',
          'وثائق تصميم شاملة',
        ],
        featuresEn: [
          'User behavior research',
          'Interactive prototypes',
          'Usability testing',
          'Accessibility compliant design',
          'Comprehensive design documentation',
        ],
      ),
      ServiceModel(
        id: '5',
        titleAr: 'التسويق الرقمي',
        titleEn: 'Digital Marketing',
        descriptionAr: 'استراتيجيات تسويق رقمي فعالة لتعزيز حضورك الإلكتروني',
        descriptionEn: 'Effective digital marketing strategies to enhance your online presence',
        icon: Icons.trending_up,
        color: const Color(0xFF8B5CF6),
        featuresAr: [
          'إدارة حسابات التواصل الاجتماعي',
          'حملات إعلانية مستهدفة',
          'تحسين محركات البحث',
          'تسويق المحتوى',
          'تحليلات وتقارير دورية',
        ],
        featuresEn: [
          'Social media management',
          'Targeted ad campaigns',
          'Search engine optimization',
          'Content marketing',
          'Analytics and regular reports',
        ],
      ),
      ServiceModel(
        id: '6',
        titleAr: 'استشارات تقنية',
        titleEn: 'Technical Consulting',
        descriptionAr: 'استشارات تقنية متخصصة لمساعدتك في اتخاذ القرارات الصحيحة',
        descriptionEn: 'Specialized technical consulting to help you make the right decisions',
        icon: Icons.lightbulb,
        color: const Color(0xFFF59E0B),
        featuresAr: [
          'تحليل المتطلبات التقنية',
          'اختيار التقنيات المناسبة',
          'تخطيط المشاريع',
          'مراجعة الكود والأداء',
          'تدريب الفرق التقنية',
        ],
        featuresEn: [
          'Technical requirements analysis',
          'Choosing appropriate technologies',
          'Project planning',
          'Code and performance review',
          'Technical team training',
        ],
      ),
    ];
  }

  // الحصول على خدمة معينة بالمعرف
  static ServiceModel? getServiceById(String id) {
    try {
      return getAllServices().firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }

  // الحصول على عدد محدد من الخدمات
  static List<ServiceModel> getLimitedServices(int limit) {
    final services = getAllServices();
    return services.take(limit).toList();
  }
}
