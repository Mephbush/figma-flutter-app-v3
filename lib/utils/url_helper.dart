import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../config/app_constants.dart';

/// 🔗 مساعد إدارة الروابط والتواصل
class UrlHelper {
  /// فتح رابط في المتصفح الخارجي
  static Future<bool> launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching URL: $e');
      return false;
    }
  }

  /// فتح البريد الإلكتروني
  static Future<bool> launchEmail({
    String? email,
    String? subject,
    String? body,
  }) async {
    final emailAddress = email ?? AppConstants.email;
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    
    try {
      return await launchUrl(emailUri);
    } catch (e) {
      debugPrint('Error launching email: $e');
      return false;
    }
  }

  /// فتح تطبيق الهاتف
  static Future<bool> launchPhone([String? phoneNumber]) async {
    final phone = phoneNumber ?? AppConstants.phone;
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    
    try {
      return await launchUrl(phoneUri);
    } catch (e) {
      debugPrint('Error launching phone: $e');
      return false;
    }
  }

  /// فتح واتساب
  static Future<bool> launchWhatsApp({
    String? phoneNumber,
    String? message,
  }) async {
    final phone = phoneNumber ?? AppConstants.whatsapp;
    // إزالة الرموز غير الرقمية
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$cleanPhone${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}',
    );
    
    try {
      return await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
      return false;
    }
  }

  /// فتح خرائط جوجل
  static Future<bool> launchMaps(String address) async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );
    
    try {
      return await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching Maps: $e');
      return false;
    }
  }

  /// مشاركة نص
  static Future<bool> shareText(String text) async {
    // ملاحظة: يحتاج إلى إضافة حزمة share_plus للمشاركة الفعلية
    // هذه نسخة مبسطة
    debugPrint('Sharing: $text');
    return true;
  }

  /// فتح موقع الشركة
  static Future<bool> launchWebsite() => launchURL(AppConstants.websiteUrl);

  /// فتح مدونة الشركة
  static Future<bool> launchBlog() => launchURL(AppConstants.blogUrl);

  /// فتح صفحة فيسبوك
  static Future<bool> launchFacebook() => launchURL(AppConstants.facebookUrl);

  /// فتح صفحة تويتر
  static Future<bool> launchTwitter() => launchURL(AppConstants.twitterUrl);

  /// فتح صفحة انستقرام
  static Future<bool> launchInstagram() => launchURL(AppConstants.instagramUrl);

  /// فتح صفحة لينكد إن
  static Future<bool> launchLinkedIn() => launchURL(AppConstants.linkedinUrl);

  /// فتح صفحة جيت هب
  static Future<bool> launchGitHub() => launchURL(AppConstants.githubUrl);

  /// فتح صفحة بيهانس
  static Future<bool> launchBehance() => launchURL(AppConstants.behanceUrl);

  /// فتح صفحة دريبل
  static Future<bool> launchDribbble() => launchURL(AppConstants.dribbbleUrl);

  /// التحقق من صحة الرابط
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// التحقق من صحة البريد الإلكتروني
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// التحقق من صحة رقم الهاتف
  static bool isValidPhone(String phone) {
    // إزالة جميع الرموز غير الرقمية وعلامات +
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    // التحقق من أن الرقم يحتوي على 10-15 رقم على الأقل
    return cleanPhone.length >= 10 && cleanPhone.length <= 15;
  }
}

/// 🌐 روابط مواقع التواصل الاجتماعي الشهيرة
class SocialPlatforms {
  static const facebook = 'Facebook';
  static const twitter = 'Twitter';
  static const instagram = 'Instagram';
  static const linkedin = 'LinkedIn';
  static const github = 'GitHub';
  static const behance = 'Behance';
  static const dribbble = 'Dribbble';
  static const youtube = 'YouTube';
  static const pinterest = 'Pinterest';
  static const tiktok = 'TikTok';
  static const snapchat = 'Snapchat';
  static const whatsapp = 'WhatsApp';
  static const telegram = 'Telegram';
}
