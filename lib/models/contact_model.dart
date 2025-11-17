/// 📧 نموذج بيانات التواصل
class ContactModel {
  final String? id;
  final String name;
  final String email;
  final String? phone;
  final String message;
  final DateTime? createdAt;

  ContactModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.message,
    this.createdAt,
  });

  // تحويل إلى JSON للإرسال
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
      'created_at': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  // تحويل من JSON
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      message: json['message'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // نسخ مع تعديلات
  ContactModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? message,
    DateTime? createdAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
