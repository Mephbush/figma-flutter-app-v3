import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../config/app_theme.dart';
import '../providers/language_provider.dart';
import '../providers/analytics_provider.dart';
import '../services/supabase_service.dart';
import '../utils/responsive.dart';
import '../widgets/app_drawer.dart';

/// ℹ️ صفحة من نحن
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final _supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().trackPageVisit('about');
      _supabaseService.trackPageVisit('about');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translations;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t['about']),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            _buildHeader(context, t),
            
            SizedBox(height: Responsive.isMobile(context) ? 32 : 48),
            
            // Description
            _buildDescription(context, t),
            
            SizedBox(height: Responsive.isMobile(context) ? 32 : 48),
            
            // Vision & Mission
            _buildVisionMission(context, t),
            
            SizedBox(height: Responsive.isMobile(context) ? 32 : 48),
            
            // Team
            _buildTeam(context),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, dynamic> t) {
    return Container(
      height: Responsive.value(
        context: context,
        mobile: 200.0,
        tablet: 250.0,
        desktop: 280.0,
      ),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Center(
        child: FadeInDown(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: Responsive.iconSize(context, 70),
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 16),
              Text(
                t['aboutTitle'],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.fontSize(context, 28),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, Map<String, dynamic> t) {
    return FadeInUp(
      child: Padding(
        padding: context.pagePadding,
        child: Text(
          t['aboutDescription'],
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: Responsive.fontSize(context, 16),
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildVisionMission(BuildContext context, Map<String, dynamic> t) {
    return Padding(
      padding: context.pagePadding,
      child: Responsive.builder(
        context: context,
        mobile: Column(
          children: [
            _InfoCard(
              icon: Icons.visibility,
              title: t['ourVision'],
              description: t['visionText'],
              gradient: AppTheme.primaryGradient,
            ),
            const SizedBox(height: 20),
            _InfoCard(
              icon: Icons.track_changes,
              title: t['ourMission'],
              description: t['missionText'],
              gradient: AppTheme.blueGradient,
            ),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.visibility,
                title: t['ourVision'],
                description: t['visionText'],
                gradient: AppTheme.primaryGradient,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _InfoCard(
                icon: Icons.track_changes,
                title: t['ourMission'],
                description: t['missionText'],
                gradient: AppTheme.blueGradient,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeam(BuildContext context) {
    final members = [
      {'name': 'أحمد محمد', 'role': 'مدير المشروع'},
      {'name': 'سارة علي', 'role': 'مصممة UI/UX'},
      {'name': 'خالد حسن', 'role': 'مطور تطبيقات'},
      {'name': 'نورا أحمد', 'role': 'مطورة Frontend'},
    ];

    return Padding(
      padding: context.pagePadding,
      child: Column(
        children: [
          Text(
            'فريق العمل',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: Responsive.fontSize(context, 24),
                ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: members.map((member) {
              return _TeamMember(
                name: member['name']!,
                role: member['role']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 28),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 35),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: Responsive.fontSize(context, 20),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.6,
                  fontSize: Responsive.fontSize(context, 14),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TeamMember extends StatelessWidget {
  final String name;
  final String role;

  const _TeamMember({
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context) ? 150 : 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPurple.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: Responsive.fontSize(context, 16),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: Responsive.fontSize(context, 13),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
