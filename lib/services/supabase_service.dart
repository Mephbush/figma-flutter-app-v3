/// 🔌 خدمة الاتصال بـ Supabase
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/app_config.dart';
import '../models/contact_model.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // Headers للطلبات
  Map<String, String> get _headers => {
    'apikey': AppConfig.supabaseAnonKey,
    'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
    'Content-Type': 'application/json',
    'Prefer': 'return=representation',
  };

  /// 📧 إرسال رسالة تواصل
  Future<Map<String, dynamic>> sendContactMessage(ContactModel contact) async {
    try {
      if (!AppConfig.isSupabaseConfigured) {
        // وضع تجريبي - حفظ محلي فقط
        return {
          'success': true,
          'message': 'تم حفظ الرسالة محلياً (وضع تجريبي)',
          'data': contact.toJson(),
        };
      }

      final response = await http.post(
        Uri.parse(AppConfig.contactEndpoint),
        headers: _headers,
        body: json.encode(contact.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'success': true,
          'message': 'تم إرسال رسالتك بنجاح',
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'حدث خطأ في الإرسال: ${response.statusCode}',
          'error': response.body,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'خطأ في الاتصال: $e',
        'error': e.toString(),
      };
    }
  }

  /// 📊 تسجيل زيارة صفحة
  Future<void> trackPageVisit(String pageName) async {
    try {
      if (!AppConfig.isSupabaseConfigured) return;

      final data = {
        'page_name': pageName,
        'visited_at': DateTime.now().toIso8601String(),
      };

      await http.post(
        Uri.parse(AppConfig.analyticsEndpoint),
        headers: _headers,
        body: json.encode(data),
      );
    } catch (e) {
      // فشل صامت للتحليلات
      print('Analytics error: $e');
    }
  }

  /// 📈 الحصول على إحصائيات الزيارات
  Future<Map<String, dynamic>> getAnalytics() async {
    try {
      if (!AppConfig.isSupabaseConfigured) {
        return {'success': false, 'message': 'Supabase not configured'};
      }

      final response = await http.get(
        Uri.parse('${AppConfig.analyticsEndpoint}?select=*&order=visited_at.desc&limit=100'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return {
          'success': true,
          'data': data,
          'total': data.length,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch analytics',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// ✉️ الحصول على جميع رسائل التواصل (للـ Admin)
  Future<List<ContactModel>> getContactMessages() async {
    try {
      if (!AppConfig.isSupabaseConfigured) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${AppConfig.contactEndpoint}?select=*&order=created_at.desc'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ContactModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching contacts: $e');
      return [];
    }
  }

  /// 🧪 اختبار الاتصال
  Future<bool> testConnection() async {
    try {
      if (!AppConfig.isSupabaseConfigured) return false;

      final response = await http.get(
        Uri.parse(AppConfig.supabaseUrl),
        headers: _headers,
      ).timeout(const Duration(seconds: 5));

      return response.statusCode < 500;
    } catch (e) {
      return false;
    }
  }
}
