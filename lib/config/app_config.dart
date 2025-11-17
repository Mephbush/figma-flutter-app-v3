/// ⚙️ إعدادات التطبيق والـ API
class AppConfig {
  // Supabase Configuration
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'YOUR_SUPABASE_URL_HERE',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'YOUR_SUPABASE_ANON_KEY_HERE',
  );

  // App Info
  static const String appName = 'VisCend Studio';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // Contact Info
  static const String phoneNumber = '+966 50 123 4567';
  static const String email = 'info@viscendstudio.com';
  static const String address = 'الرياض، المملكة العربية السعودية';
  static const String website = 'https://viscendstudio.com';

  // Social Media
  static const String facebook = 'https://facebook.com/viscendstudio';
  static const String twitter = 'https://twitter.com/viscendstudio';
  static const String instagram = 'https://instagram.com/viscendstudio';
  static const String linkedin = 'https://linkedin.com/company/viscendstudio';

  // API Endpoints
  static String get contactEndpoint => '$supabaseUrl/rest/v1/contacts';
  static String get analyticsEndpoint => '$supabaseUrl/rest/v1/page_visits';

  // Validation
  static bool get isSupabaseConfigured => 
      supabaseUrl != 'YOUR_SUPABASE_URL_HERE' &&
      supabaseAnonKey != 'YOUR_SUPABASE_ANON_KEY_HERE';
}
