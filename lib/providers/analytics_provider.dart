import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 📊 نظام التحليلات والإحصائيات
class AnalyticsProvider extends ChangeNotifier {
  int _totalVisits = 0;
  int _todayVisits = 0;
  Map<String, int> _pageVisits = {};
  String _lastVisitDate = '';

  int get totalVisits => _totalVisits;
  int get todayVisits => _todayVisits;
  Map<String, int> get pageVisits => _pageVisits;

  AnalyticsProvider() {
    _loadAnalytics();
    _trackAppOpen();
  }

  /// تحميل البيانات المحفوظة
  Future<void> _loadAnalytics() async {
    final prefs = await SharedPreferences.getInstance();
    _totalVisits = prefs.getInt('total_visits') ?? 0;
    _todayVisits = prefs.getInt('today_visits') ?? 0;
    _lastVisitDate = prefs.getString('last_visit_date') ?? '';
    
    // تحميل زيارات الصفحات
    final pages = ['home', 'about', 'services', 'portfolio', 'contact'];
    for (var page in pages) {
      _pageVisits[page] = prefs.getInt('page_$page') ?? 0;
    }
    
    // إعادة تعيين العداد اليومي إذا كان يوم جديد
    final today = DateTime.now().toIso8601String().split('T')[0];
    if (_lastVisitDate != today) {
      _todayVisits = 0;
      _lastVisitDate = today;
    }
    
    notifyListeners();
  }

  /// تسجيل فتح التطبيق
  Future<void> _trackAppOpen() async {
    _totalVisits++;
    _todayVisits++;
    await _saveAnalytics();
    notifyListeners();
  }

  /// تسجيل زيارة صفحة
  Future<void> trackPageVisit(String pageName) async {
    _pageVisits[pageName] = (_pageVisits[pageName] ?? 0) + 1;
    await _saveAnalytics();
    notifyListeners();
  }

  /// حفظ البيانات
  Future<void> _saveAnalytics() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('total_visits', _totalVisits);
    await prefs.setInt('today_visits', _todayVisits);
    await prefs.setString('last_visit_date', _lastVisitDate);
    
    // حفظ زيارات الصفحات
    for (var entry in _pageVisits.entries) {
      await prefs.setInt('page_${entry.key}', entry.value);
    }
  }

  /// الحصول على أكثر صفحة زيارة
  String get mostVisitedPage {
    if (_pageVisits.isEmpty) return 'home';
    
    return _pageVisits.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// إعادة تعيين الإحصائيات
  Future<void> resetAnalytics() async {
    _totalVisits = 0;
    _todayVisits = 0;
    _pageVisits.clear();
    _lastVisitDate = '';
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }
}
