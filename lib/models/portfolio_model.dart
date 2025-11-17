/// 💼 نموذج بيانات المشاريع في البورتفوليو
class PortfolioModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final String categoryAr;
  final String categoryEn;
  final String imageUrl;
  final String? demoUrl;
  final String? githubUrl;
  final List<String> technologies;
  final DateTime? completedAt;
  final bool isFeatured;

  PortfolioModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.categoryAr,
    required this.categoryEn,
    required this.imageUrl,
    this.demoUrl,
    this.githubUrl,
    required this.technologies,
    this.completedAt,
    this.isFeatured = false,
  });

  // تحويل إلى JSON للإرسال
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ar': titleAr,
      'title_en': titleEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'category_ar': categoryAr,
      'category_en': categoryEn,
      'image_url': imageUrl,
      'demo_url': demoUrl,
      'github_url': githubUrl,
      'technologies': technologies,
      'completed_at': completedAt?.toIso8601String(),
      'is_featured': isFeatured,
    };
  }

  // تحويل من JSON
  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      id: json['id']?.toString() ?? '',
      titleAr: json['title_ar'] ?? '',
      titleEn: json['title_en'] ?? '',
      descriptionAr: json['description_ar'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      categoryAr: json['category_ar'] ?? '',
      categoryEn: json['category_en'] ?? '',
      imageUrl: json['image_url'] ?? '',
      demoUrl: json['demo_url'],
      githubUrl: json['github_url'],
      technologies: json['technologies'] != null
          ? List<String>.from(json['technologies'])
          : [],
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      isFeatured: json['is_featured'] ?? false,
    );
  }

  // نسخ مع تعديلات
  PortfolioModel copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    String? categoryAr,
    String? categoryEn,
    String? imageUrl,
    String? demoUrl,
    String? githubUrl,
    List<String>? technologies,
    DateTime? completedAt,
    bool? isFeatured,
  }) {
    return PortfolioModel(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      categoryAr: categoryAr ?? this.categoryAr,
      categoryEn: categoryEn ?? this.categoryEn,
      imageUrl: imageUrl ?? this.imageUrl,
      demoUrl: demoUrl ?? this.demoUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      technologies: technologies ?? this.technologies,
      completedAt: completedAt ?? this.completedAt,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
