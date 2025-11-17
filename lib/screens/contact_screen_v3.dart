import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../config/app_theme.dart';
import '../providers/language_provider.dart';
import '../providers/analytics_provider.dart';
import '../widgets/app_drawer.dart';
import '../utils/responsive.dart';

/// 📞 شاشة التواصل - تصميم متطابق مع Figma
class ContactScreenV3 extends StatefulWidget {
  const ContactScreenV3({super.key});

  @override
  State<ContactScreenV3> createState() => _ContactScreenV3State();
}

class _ContactScreenV3State extends State<ContactScreenV3> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().trackPageVisit('contact');
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

    // محاكاة إرسال البيانات
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('تم إرسال رسالتك بنجاح ✅'),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );

      // تنظيف الحقول
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final isArabic = lang.isArabic;

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'تواصل معنا',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // قسم الهيدر
            _buildHeader(context),

            const SizedBox(height: 32),

            // نموذج التواصل
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: _buildContactForm(context),
            ),

            const SizedBox(height: 40),

            // معلومات التواصل
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: _buildContactInfo(context),
            ),

            const SizedBox(height: 40),

            // وسائل التواصل الاجتماعي
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: _buildSocialMedia(context),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context),
          vertical: 32,
        ),
        child: Column(
          children: [
            // أيقونة الرسالة
            Container(
              width: Responsive.value(context: context, mobile: 80, tablet: 100, desktop: 120),
              height: Responsive.value(context: context, mobile: 80, tablet: 100, desktop: 120),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryPurple.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                Icons.mail_outline_rounded,
                size: Responsive.iconSize(context, 40),
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // العنوان
            Text(
              'تواصل معنا',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 32),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // الوصف
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
              ),
              child: Text(
                'نحن هنا للإجابة على أي أسئلة أو استفسارات لديك. تواصل معنا الآن ودعنا نساعدك في تحقيق رؤيتك الرقمية',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  color: AppTheme.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الاسم
            Text(
              'الاسم الكامل',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _nameController,
              hintText: 'أدخل اسمك الكامل',
              icon: Icons.person_outline,
              validator: (v) => v!.isEmpty ? 'الاسم مطلوب' : null,
            ),

            const SizedBox(height: 20),

            // البريد الإلكتروني
            Text(
              'البريد الإلكتروني',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hintText: 'example@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v!.isEmpty) return 'البريد الإلكتروني مطلوب';
                if (!v.contains('@')) return 'البريد الإلكتروني غير صحيح';
                return null;
              },
            ),

            const SizedBox(height: 20),

            // رقم الهاتف
            Text(
              'رقم الهاتف',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _phoneController,
              hintText: '+966 5X XXX XXXX',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 20),

            // الرسالة
            Text(
              'رسالتك',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _messageController,
              hintText: 'اكتب رسالتك هنا...',
              icon: Icons.message_outlined,
              maxLines: 5,
              validator: (v) => v!.isEmpty ? 'الرسالة مطلوبة' : null,
            ),

            const SizedBox(height: 32),

            // زر الإرسال
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: _isLoading ? null : AppTheme.primaryGradient,
                    color: _isLoading ? Colors.grey.shade800 : null,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isLoading
                        ? null
                        : [
                            BoxShadow(
                              color: AppTheme.primaryPurple.withOpacity(0.5),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'إرسال الرسالة',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 16),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(
        color: Colors.white,
        fontSize: Responsive.fontSize(context, 15),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppTheme.textSecondary.withOpacity(0.5),
          fontSize: Responsive.fontSize(context, 14),
        ),
        prefixIcon: Icon(
          icon,
          color: AppTheme.textSecondary,
          size: 22,
        ),
        filled: true,
        fillColor: AppTheme.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppTheme.cardBackground,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.primaryPurple,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.shade400,
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 18,
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات التواصل',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildContactItem(
            context,
            icon: FontAwesomeIcons.phone,
            title: 'الهاتف',
            value: '+966 50 123 4567',
            gradient: AppTheme.primaryGradient,
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            context,
            icon: FontAwesomeIcons.envelope,
            title: 'البريد الإلكتروني',
            value: 'info@viscendstudio.com',
            gradient: AppTheme.blueGradient,
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            context,
            icon: FontAwesomeIcons.locationDot,
            title: 'العنوان',
            value: 'الرياض، المملكة العربية السعودية',
            gradient: AppTheme.primaryGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required LinearGradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // الأيقونة
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryPurple.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),

          const SizedBox(width: 16),

          // النص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 15),
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMedia(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Column(
        children: [
          Text(
            'تابعنا على',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: FontAwesomeIcons.instagram,
                color: const Color(0xFFE4405F),
                onTap: () {},
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: FontAwesomeIcons.twitter,
                color: const Color(0xFF1DA1F2),
                onTap: () {},
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: FontAwesomeIcons.linkedin,
                color: const Color(0xFF0077B5),
                onTap: () {},
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: FontAwesomeIcons.whatsapp,
                color: const Color(0xFF25D366),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }
}
