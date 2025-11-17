import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_theme.dart';
import '../providers/language_provider.dart';
import '../providers/analytics_provider.dart';
import '../widgets/app_drawer.dart';

/// 💼 صفحة الخدمات
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().trackPageVisit('services');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translations;
    
    final services = [
      {
        'icon': FontAwesomeIcons.laptop,
        'title': t['webDesign'],
        'description': t['webDesignDesc'],
        'color': AppTheme.primaryPurple,
      },
      {
        'icon': FontAwesomeIcons.mobileScreenButton,
        'title': t['appDevelopment'],
        'description': t['appDevelopmentDesc'],
        'color': AppTheme.accentBlue,
      },
      {
        'icon': FontAwesomeIcons.palette,
        'title': t['branding'],
        'description': t['brandingDesc'],
        'color': AppTheme.secondaryPurple,
      },
      {
        'icon': FontAwesomeIcons.pencil,
        'title': t['uiux'],
        'description': t['uiuxDesc'],
        'color': AppTheme.lightBlue,
      },
      {
        'icon': FontAwesomeIcons.bullhorn,
        'title': t['marketing'],
        'description': t['marketingDesc'],
        'color': const Color(0xFFEC4899),
      },
      {
        'icon': FontAwesomeIcons.lightbulb,
        'title': t['consulting'],
        'description': t['consultingDesc'],
        'color': const Color(0xFFF59E0B),
      },
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t['services']),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            _buildHeader(context, t),
            
            const SizedBox(height: 40),
            
            // Services Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: services.asMap().entries.map((entry) {
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * entry.key),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _ServiceCard(
                        icon: entry.value['icon'] as IconData,
                        title: entry.value['title'] as String,
                        description: entry.value['description'] as String,
                        color: entry.value['color'] as Color,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, dynamic> t) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                child: Text(
                  t['servicesTitle'],
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 12),
              
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  t['servicesDescription'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}