import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_theme.dart';
import '../config/app_router.dart';
import '../providers/language_provider.dart';
import '../providers/analytics_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/gradient_button.dart';

/// 🏠 الصفحة الرئيسية
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // تسجيل زيارة الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().trackPageVisit('home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translations;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t['appName']),
        actions: [
          // Language Toggle
          IconButton(
            icon: Icon(
              lang.isArabic ? Icons.language : Icons.translate,
            ),
            onPressed: () => lang.toggleLanguage(),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            _buildHeroSection(context, t),
            
            const SizedBox(height: 40),
            
            // Quick Services
            _buildQuickServices(context, t),
            
            const SizedBox(height: 40),
            
            // Features
            _buildFeatures(context, t),
            
            const SizedBox(height: 40),
            
            // Stats
            _buildStats(context),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Hero Section
  Widget _buildHeroSection(BuildContext context, Map<String, dynamic> t) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: GridPatternPainter(),
              ),
            ),
          ),
          
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(
                    child: Text(
                      t['welcome'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      t['heroTitle'],
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      t['heroSubtitle'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientButton(
                          text: t['getStarted'],
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.contact);
                          },
                        ),
                        
                        const SizedBox(width: 16),
                        
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.about);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white, width: 2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(t['learnMore']),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Quick Services
  Widget _buildQuickServices(BuildContext context, Map<String, dynamic> t) {
    final services = [
      {
        'icon': FontAwesomeIcons.laptop,
        'title': t['webDesign'],
        'color': AppTheme.primaryPurple,
      },
      {
        'icon': FontAwesomeIcons.mobileScreenButton,
        'title': t['appDevelopment'],
        'color': AppTheme.accentBlue,
      },
      {
        'icon': FontAwesomeIcons.palette,
        'title': t['branding'],
        'color': AppTheme.secondaryPurple,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          FadeInUp(
            child: Text(
              t['servicesTitle'],
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 30),
          
          ...services.asMap().entries.map((entry) {
            return FadeInUp(
              delay: Duration(milliseconds: 200 * entry.key),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _ServiceCard(
                  icon: entry.value['icon'] as IconData,
                  title: entry.value['title'] as String,
                  color: entry.value['color'] as Color,
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.services);
                  },
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  /// Features
  Widget _buildFeatures(BuildContext context, Map<String, dynamic> t) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'لماذا نحن؟',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          
          const SizedBox(height: 30),
          
          _FeatureItem(
            icon: Icons.speed,
            title: 'سرعة في التنفيذ',
            description: 'نلتزم بالمواعيد ونسلم المشاريع في الوقت المحدد',
          ),
          
          const SizedBox(height: 20),
          
          _FeatureItem(
            icon: Icons.workspace_premium,
            title: 'جودة عالية',
            description: 'نضمن أعلى معايير الجودة في جميع أعمالنا',
          ),
          
          const SizedBox(height: 20),
          
          _FeatureItem(
            icon: Icons.support_agent,
            title: 'دعم مستمر',
            description: 'نوفر دعماً فنياً متواصلاً لجميع عملائنا',
          ),
        ],
      ),
    );
  }

  /// Stats
  Widget _buildStats(BuildContext context) {
    final analytics = context.watch<AnalyticsProvider>();
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x4D9333EA), // primaryPurple with 30% opacity
            Color(0x4D7C3AED), // secondaryPurple with 30% opacity
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'إحصائيات التطبيق',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          
          const SizedBox(height: 30),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                value: '${analytics.totalVisits}',
                label: 'إجمالي الزيارات',
              ),
              _StatItem(
                value: '${analytics.todayVisits}',
                label: 'زيارات اليوم',
              ),
              _StatItem(
                value: '${analytics.pageVisits.length}',
                label: 'الصفحات',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Service Card Widget
class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            
            const SizedBox(width: 20),
            
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/// Feature Item Widget
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Stat Item Widget
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
        ),
      ],
    );
  }
}

/// Grid Pattern Painter
class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    const spacing = 30.0;

    // رسم الخطوط العمودية
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // رسم الخطوط الأفقية
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}