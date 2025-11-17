import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../config/app_theme.dart';
import '../providers/language_provider.dart';
import '../providers/analytics_provider.dart';
import '../widgets/app_drawer.dart';
import '../utils/responsive.dart';

/// ⭐ شاشة مميزاتنا - تصميم متطابق مع Figma
class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().trackPageVisit('features');
    });
  }

  final List<FeatureModel> _features = [
    FeatureModel(
      icon: FontAwesomeIcons.paintbrush,
      title: 'تصميم إبداعي',
      description: 'نقدم تصاميم فريدة ومبتكرة تجمع بين الجمال والوظيفة لتحقيق أفضل تجربة مستخدم',
      gradient: AppTheme.primaryGradient,
    ),
    FeatureModel(
      icon: FontAwesomeIcons.code,
      title: 'تطوير احترافي',
      description: 'كود نظيف ومنظم يتبع أفضل الممارسات البرمجية لضمان أداء عالٍ وسهولة الصيانة',
      gradient: AppTheme.blueGradient,
    ),
    FeatureModel(
      icon: FontAwesomeIcons.rocket,
      title: 'أداء سريع',
      description: 'نحرص على تحسين الأداء لضمان تجربة سلسة وسريعة لجميع المستخدمين',
      gradient: AppTheme.primaryGradient,
    ),
    FeatureModel(
      icon: FontAwesomeIcons.mobile,
      title: 'متوافق مع الأجهزة',
      description: 'تصاميم متجاوبة تعمل بشكل مثالي على جميع الأجهزة والشاشات بمختلف أحجامها',
      gradient: AppTheme.blueGradient,
    ),
    FeatureModel(
      icon: FontAwesomeIcons.shield,
      title: 'أمان عالي',
      description: 'نطبق أحدث معايير الأمان لحماية بياناتك ومعلومات المستخدمين',
      gradient: AppTheme.primaryGradient,
    ),
    FeatureModel(
      icon: FontAwesomeIcons.headset,
      title: 'دعم فني متميز',
      description: 'فريقنا متواجد دائماً لمساعدتك وحل أي مشاكل قد تواجهك بسرعة واحترافية',
      gradient: AppTheme.blueGradient,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ما يميزنا',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // قسم الهيدر
            _buildHeader(context),

            const SizedBox(height: 40),

            // المميزات
            _buildFeatures(context),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context),
          vertical: 32,
        ),
        child: Column(
          children: [
            // أيقونة النجمة
            Container(
              width: Responsive.value(context: context, mobile: 80, tablet: 100, desktop: 120),
              height: Responsive.value(context: context, mobile: 80, tablet: 100, desktop: 120),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryPurple.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                Icons.star_rounded,
                size: Responsive.iconSize(context, 40),
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // العنوان
            Text(
              'ما يميزنا',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 32),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // الوصف
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
              ),
              child: Text(
                'نقدم لك مجموعة من المميزات التي تجعلنا الخيار الأمثل لتحقيق أهدافك الرقمية',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  color: AppTheme.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Column(
        children: _features
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              final feature = entry.value;

              return FadeInUp(
                duration: Duration(milliseconds: 400 + (index * 100)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildFeatureCard(context, feature, index),
                ),
              );
            })
            .toList(),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, FeatureModel feature, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الأيقونة
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: feature.gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryPurple.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              feature.icon,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // المحتوى
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                Text(
                  feature.title,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 18),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // الوصف
                Text(
                  feature.description,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: AppTheme.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// نموذج بيانات الميزة
class FeatureModel {
  final IconData icon;
  final String title;
  final String description;
  final LinearGradient gradient;

  FeatureModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });
}
