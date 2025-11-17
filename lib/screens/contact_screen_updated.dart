import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_theme.dart';
import '../config/app_config.dart';
import '../providers/language_provider.dart';
import '../providers/analytics_provider.dart';
import '../models/contact_model.dart';
import '../services/supabase_service.dart';
import '../utils/responsive.dart';
import '../utils/validators.dart';
import '../widgets/app_drawer.dart';
import '../widgets/gradient_button.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  final _supabaseService = SupabaseService();
  
  bool _isLoading = false;
  bool _isSent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().trackPageVisit('contact');
      // تسجيل في Supabase أيضاً
      _supabaseService.trackPageVisit('contact');
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final contact = ContactModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        message: _messageController.text.trim(),
      );

      final result = await _supabaseService.sendContactMessage(contact);

      if (mounted) {
        setState(() => _isLoading = false);

        if (result['success'] == true) {
          setState(() => _isSent = true);
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      result['message'] ?? 'تم إرسال رسالتك بنجاح ✅',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );

          // مسح النموذج بعد 2 ثانية
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              _formKey.currentState!.reset();
              _nameController.clear();
              _emailController.clear();
              _phoneController.clear();
              _messageController.clear();
              setState(() => _isSent = false);
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      result['message'] ?? 'حدث خطأ، يرجى المحاولة مرة أخرى',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translations;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t['contact']),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            _buildHeader(context, t),
            
            SizedBox(height: Responsive.isMobile(context) ? 24 : 40),
            
            // Form & Info Container
            Responsive.builder(
              context: context,
              mobile: _buildMobileLayout(context, t),
              tablet: _buildTabletLayout(context, t),
              desktop: _buildDesktopLayout(context, t),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, dynamic> t) {
    return Container(
      height: Responsive.value(
        context: context,
        mobile: 180.0,
        tablet: 200.0,
        desktop: 220.0,
      ),
      decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Center(
        child: Padding(
          padding: context.pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail_outline,
                size: Responsive.iconSize(context, 50),
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 12),
              Text(
                t['contactTitle'],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.fontSize(context, 28),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                t['contactDescription'],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: Responsive.fontSize(context, 16),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout(BuildContext context, Map<String, dynamic> t) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildForm(context, t),
          const SizedBox(height: 32),
          _buildContactInfo(context),
        ],
      ),
    );
  }

  // Tablet Layout
  Widget _buildTabletLayout(BuildContext context, Map<String, dynamic> t) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildForm(context, t),
          const SizedBox(height: 40),
          _buildContactInfo(context),
        ],
      ),
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout(BuildContext context, Map<String, dynamic> t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: _buildForm(context, t),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 4,
            child: _buildContactInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, Map<String, dynamic> t) {
    return Container(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 30),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t['sendMessage'],
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: Responsive.fontSize(context, 22),
                  ),
            ),
            const SizedBox(height: 24),
            
            // Name Field
            TextFormField(
              controller: _nameController,
              enabled: !_isLoading && !_isSent,
              decoration: InputDecoration(
                labelText: t['yourName'],
                prefixIcon: const Icon(Icons.person_outline),
                hintText: 'مثال: أحمد محمد',
              ),
              textInputAction: TextInputAction.next,
              validator: Validators.name,
            ),
            const SizedBox(height: 16),
            
            // Email Field
            TextFormField(
              controller: _emailController,
              enabled: !_isLoading && !_isSent,
              decoration: InputDecoration(
                labelText: t['yourEmail'],
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'example@email.com',
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            
            // Phone Field
            TextFormField(
              controller: _phoneController,
              enabled: !_isLoading && !_isSent,
              decoration: InputDecoration(
                labelText: t['yourPhone'],
                prefixIcon: const Icon(Icons.phone_outlined),
                hintText: '+966 50 123 4567',
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.phone(v, required: false),
            ),
            const SizedBox(height: 16),
            
            // Message Field
            TextFormField(
              controller: _messageController,
              enabled: !_isLoading && !_isSent,
              decoration: InputDecoration(
                labelText: t['yourMessage'],
                prefixIcon: const Icon(Icons.message_outlined),
                hintText: 'اكتب رسالتك هنا...',
                alignLabelWithHint: true,
              ),
              maxLines: Responsive.isMobile(context) ? 4 : 6,
              textInputAction: TextInputAction.done,
              validator: Validators.message,
            ),
            const SizedBox(height: 24),
            
            // Submit Button
            SizedBox(
              height: 56,
              child: GradientButton(
                text: _isLoading
                    ? t['sending']
                    : _isSent
                        ? '✅ ${t['messageSent']}'
                        : t['sendMessage'],
                onPressed: _isLoading || _isSent ? null : _submitForm,
              ),
            ),
            
            if (!AppConfig.isSupabaseConfigured) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'وضع تجريبي: لم يتم ربط Supabase بعد',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ContactInfoItem(
          icon: FontAwesomeIcons.phone,
          title: 'الهاتف',
          value: AppConfig.phoneNumber,
          onTap: () {
            // يمكن إضافة url_launcher هنا
          },
        ),
        const SizedBox(height: 16),
        _ContactInfoItem(
          icon: FontAwesomeIcons.envelope,
          title: 'البريد الإلكتروني',
          value: AppConfig.email,
          onTap: () {
            // يمكن إضافة url_launcher هنا
          },
        ),
        const SizedBox(height: 16),
        _ContactInfoItem(
          icon: FontAwesomeIcons.locationDot,
          title: 'العنوان',
          value: AppConfig.address,
        ),
        
        const SizedBox(height: 32),
        
        // Social Media
        _buildSocialMedia(context),
      ],
    );
  }

  Widget _buildSocialMedia(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            'تابعنا',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _SocialButton(icon: FontAwesomeIcons.facebook, color: const Color(0xFF1877F2)),
              _SocialButton(icon: FontAwesomeIcons.twitter, color: const Color(0xFF1DA1F2)),
              _SocialButton(icon: FontAwesomeIcons.instagram, color: const Color(0xFFE4405F)),
              _SocialButton(icon: FontAwesomeIcons.linkedin, color: const Color(0xFF0A66C2)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(15),
          border: onTap != null
              ? Border.all(color: AppTheme.primaryPurple.withValues(alpha: 0.3))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _SocialButton({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white, size: 20),
        onPressed: () {
          // يمكن إضافة url_launcher هنا
        },
      ),
    );
  }
}