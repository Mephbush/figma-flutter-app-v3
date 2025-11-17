import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../config/app_theme.dart';
import '../providers/language_provider.dart';
import '../providers/analytics_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/portfolio_card.dart';
import '../data/portfolio_data.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().trackPageVisit('portfolio');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translations;
    final isArabic = lang.isArabic;
    
    // الحصول على المشاريع المفلترة
    final allProjects = PortfolioData.getAllProjects();
    final filteredProjects = _selectedCategory == 'All'
        ? allProjects
        : allProjects.where((p) => p.categoryEn == _selectedCategory).toList();
    
    // الحصول على الفئات
    final categories = ['All', ...PortfolioData.getCategories()];
    
    return Scaffold(
      appBar: AppBar(title: Text(t['portfolio'])),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // رأس الصفحة
            Container(
              height: 200,
              decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInDown(
                        child: Text(
                          t['portfolioTitle'],
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeInDown(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          t['portfolioDescription'],
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
            ),
            
            const SizedBox(height: 24),
            
            // فلاتر الفئات
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category;
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FadeInLeft(
                      delay: Duration(milliseconds: 50 * index),
                      child: FilterChip(
                        label: Text(_getCategoryLabel(category, isArabic)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        backgroundColor: Colors.grey.shade100,
                        selectedColor: AppTheme.primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppTheme.textPrimary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // شبكة المشاريع
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // تحديد عدد الأعمدة بناءً على عرض الشاشة
                  final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                  
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];
                      return FadeInUp(
                        delay: Duration(milliseconds: 100 * index),
                        child: PortfolioCard(project: project),
                      );
                    },
                  );
                },
              ),
            ),
            
            const SizedBox(height: 40),
            
            // دعوة للتواصل
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    isArabic ? 'هل لديك مشروع في ذهنك؟' : 'Have a project in mind?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isArabic
                        ? 'دعنا نتحدث عن كيف يمكننا مساعدتك في تحقيق رؤيتك'
                        : "Let's talk about how we can help bring your vision to life",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/contact');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isArabic ? 'تواصل معنا' : 'Contact Us',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _getCategoryLabel(String category, bool isArabic) {
    if (category == 'All') {
      return isArabic ? 'الكل' : 'All';
    }
    
    // ترجمة أسماء الفئات
    final categoryTranslations = {
      'Mobile Apps': isArabic ? 'تطبيقات الجوال' : 'Mobile Apps',
      'Web Design': isArabic ? 'تصميم مواقع' : 'Web Design',
      'Branding': isArabic ? 'الهوية البصرية' : 'Branding',
      'Web Apps': isArabic ? 'تطبيقات ويب' : 'Web Apps',
    };
    
    return categoryTranslations[category] ?? category;
  }
}
