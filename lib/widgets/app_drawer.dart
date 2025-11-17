import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_theme.dart';
import '../config/app_router.dart';
import '../providers/language_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translations;
    
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.darkBackground, AppTheme.cardBackground],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'V',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryPurple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t['appName'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _DrawerItem(
              icon: FontAwesomeIcons.house,
              title: t['home'],
              route: AppRouter.home,
            ),
            _DrawerItem(
              icon: FontAwesomeIcons.circleInfo,
              title: t['about'],
              route: AppRouter.about,
            ),
            _DrawerItem(
              icon: FontAwesomeIcons.briefcase,
              title: t['services'],
              route: AppRouter.services,
            ),
            _DrawerItem(
              icon: FontAwesomeIcons.images,
              title: t['portfolio'],
              route: AppRouter.portfolio,
            ),
            _DrawerItem(
              icon: FontAwesomeIcons.envelope,
              title: t['contact'],
              route: AppRouter.contact,
            ),
            _DrawerItem(
              icon: FontAwesomeIcons.star,
              title: 'ما يميزنا',
              route: AppRouter.features,
            ),
            const Divider(color: AppTheme.textSecondary),
            ListTile(
              leading: Icon(
                lang.isArabic ? Icons.language : Icons.translate,
                color: AppTheme.primaryPurple,
              ),
              title: Text(
                lang.isArabic ? 'English' : 'العربية',
                style: const TextStyle(color: AppTheme.textPrimary),
              ),
              onTap: () {
                lang.toggleLanguage();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(icon, color: AppTheme.primaryPurple),
      title: Text(title, style: const TextStyle(color: AppTheme.textPrimary)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}