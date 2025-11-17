/// ✅ دوال التحقق من صحة البيانات
class Validators {
  /// التحقق من البريد الإلكتروني
  static String? email(String? value, {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage ?? 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }

    return null;
  }

  /// التحقق من رقم الهاتف
  static String? phone(String? value, {bool required = false}) {
    if (value == null || value.isEmpty) {
      return required ? 'رقم الهاتف مطلوب' : null;
    }

    // إزالة المسافات والرموز
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // التحقق من الطول (8-15 رقم)
    if (cleaned.length < 8 || cleaned.length > 15) {
      return 'رقم الهاتف غير صحيح';
    }

    // التحقق من الأرقام فقط أو يبدأ بـ +
    final phoneRegex = RegExp(r'^\+?[0-9]+$');
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
    }

    return null;
  }

  /// التحقق من الاسم
  static String? name(String? value, {int minLength = 2}) {
    if (value == null || value.isEmpty) {
      return 'الاسم مطلوب';
    }

    if (value.trim().length < minLength) {
      return 'الاسم يجب أن يكون $minLength أحرف على الأقل';
    }

    // التحقق من عدم وجود أرقام
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return 'الاسم لا يجب أن يحتوي على أرقام';
    }

    return null;
  }

  /// التحقق من الرسالة
  static String? message(String? value, {int minLength = 10}) {
    if (value == null || value.isEmpty) {
      return 'الرسالة مطلوبة';
    }

    if (value.trim().length < minLength) {
      return 'الرسالة يجب أن تكون $minLength أحرف على الأقل';
    }

    return null;
  }

  /// التحقق من حقل مطلوب
  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }

  /// التحقق من الطول الأدنى
  static String? minLength(String? value, int min, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName مطلوب';
    }

    if (value.length < min) {
      return '$fieldName يجب أن يكون $min أحرف على الأقل';
    }

    return null;
  }

  /// التحقق من الطول الأقصى
  static String? maxLength(String? value, int max, String fieldName) {
    if (value != null && value.length > max) {
      return '$fieldName يجب أن لا يتجاوز $max حرف';
    }

    return null;
  }

  /// التحقق من الرقم
  static String? number(String? value, {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage ?? 'الحقل مطلوب';
    }

    if (double.tryParse(value) == null) {
      return 'يجب إدخال رقم صحيح';
    }

    return null;
  }

  /// التحقق من النطاق
  static String? range(
    String? value,
    double min,
    double max, {
    String? errorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return errorMessage ?? 'الحقل مطلوب';
    }

    final numValue = double.tryParse(value);
    if (numValue == null) {
      return 'يجب إدخال رقم صحيح';
    }

    if (numValue < min || numValue > max) {
      return 'القيمة يجب أن تكون بين $min و $max';
    }

    return null;
  }

  /// التحقق من URL
  static String? url(String? value, {bool required = false}) {
    if (value == null || value.isEmpty) {
      return required ? 'الرابط مطلوب' : null;
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'الرابط غير صحيح';
    }

    return null;
  }
}
