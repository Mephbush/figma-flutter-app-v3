import 'package:flutter/material.dart';

/// 🛠️ نموذج بيانات الخدمات
class ServiceModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final IconData icon;
  final List<String> featuresAr;
  final List<String> featuresEn;
  final Color? color;

  ServiceModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.icon,
    required this.featuresAr,
    required this.featuresEn,
    this.color,
  });

  // تحويل إلى JSON للإرسال
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ar': titleAr,
      'title_en': titleEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'features_ar': featuresAr,
      'features_en': featuresEn,
      'color': color != null ? '#${color!.value.toRadixString(16).padLeft(8, '0')}' : null,
    };
  }

  // نسخ مع تعديلات
  ServiceModel copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    IconData? icon,
    List<String>? featuresAr,
    List<String>? featuresEn,
    Color? color,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      icon: icon ?? this.icon,
      featuresAr: featuresAr ?? this.featuresAr,
      featuresEn: featuresEn ?? this.featuresEn,
      color: color ?? this.color,
    );
  }
}