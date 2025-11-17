import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_theme.dart';
import '../config/app_constants.dart';
import '../providers/language_provider.dart';
import 'social_links_widget.dart';

/// 📄 فوتر التطبيق مع الروابط ومعلومات الاتصال
class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final isArabic = lang.isArabic;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.textPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                // شعار ووصف الشركة
                Column(
                  children: [
                    Text(
                      AppConstants.companyNameAr,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isArabic
                          ? AppConstants.companyTaglineAr
                          : AppConstants.companyTaglineEn,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // معلومات الاتصال
                _ContactInfoSection(isArabic: isArabic),

                const SizedBox(height: 32),

                // روابط التواصل الاجتماعي
                Column(
                  children: [
                    Text(
                      isArabic ? 'تابعنا على' : 'Follow Us',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    const SocialLinksWidget(
                      iconSize: 28,
                      iconColor: Colors.white,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // روابط سريعة
                _QuickLinksSection(isArabic: isArabic),
              ],
            ),
          ),

          // حقوق النشر
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
            ),
            child: Column(
              children: [
                Text(
                  '© ${DateTime.now().year} ${AppConstants.companyNameAr}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  isArabic ? 'جميع الحقوق محفوظة' : 'All Rights Reserved',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
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

/// 📞 قسم معلومات الاتصال
class _ContactInfoSection extends StatelessWidget {
  final bool isArabic;

  const _ContactInfoSection({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isArabic ? 'تواصل معنا' : 'Contact Us',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.email,
          text: AppConstants.email,
          onTap: () => _launchUrl('mailto:${AppConstants.email}'),
        ),
        const SizedBox(height: 12),
        _ContactItem(
          icon: Icons.phone,
          text: AppConstants.phone,
          onTap: () => _launchUrl('tel:${AppConstants.phone}'),
        ),
        const SizedBox(height: 12),
        _ContactItem(
          icon: Icons.location_on,
          text: AppConstants.address,
        ),
      ],
    );
  }

  static Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }
}

/// 📱 عنصر معلومات الاتصال
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: child,
        ),
      );
    }

    return child;
  }
}

/// 🔗 قسم الروابط السريعة
class _QuickLinksSection extends StatelessWidget {
  final bool isArabic;

  const _QuickLinksSection({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final links = [
      {'name': isArabic ? 'الرئيسية' : 'Home', 'route': '/home'},
      {'name': isArabic ? 'من نحن' : 'About', 'route': '/about'},
      {'name': isArabic ? 'الخدمات' : 'Services', 'route': '/services'},
      {'name': isArabic ? 'الأعمال' : 'Portfolio', 'route': '/portfolio'},
      {'name': isArabic ? 'التواصل' : 'Contact', 'route': '/contact'},
    ];

    return Column(
      children: [
        Text(
          isArabic ? 'روابط سريعة' : 'Quick Links',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: links.map((link) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, link['route']!);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  link['name']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}