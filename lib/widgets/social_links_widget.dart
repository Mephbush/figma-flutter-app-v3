import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_constants.dart';

/// 🌐 ويدجت روابط التواصل الاجتماعي
class SocialLinksWidget extends StatelessWidget {
  final double iconSize;
  final Color? iconColor;
  final bool showLabels;
  final Axis direction;

  const SocialLinksWidget({
    super.key,
    this.iconSize = 24.0,
    this.iconColor,
    this.showLabels = false,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final links = [
      _SocialLinkData(
        name: 'Facebook',
        icon: FontAwesomeIcons.facebook,
        url: AppConstants.facebookUrl,
        color: const Color(0xFF1877F2),
      ),
      _SocialLinkData(
        name: 'Twitter',
        icon: FontAwesomeIcons.twitter,
        url: AppConstants.twitterUrl,
        color: const Color(0xFF1DA1F2),
      ),
      _SocialLinkData(
        name: 'Instagram',
        icon: FontAwesomeIcons.instagram,
        url: AppConstants.instagramUrl,
        color: const Color(0xFFE4405F),
      ),
      _SocialLinkData(
        name: 'LinkedIn',
        icon: FontAwesomeIcons.linkedin,
        url: AppConstants.linkedinUrl,
        color: const Color(0xFF0A66C2),
      ),
      _SocialLinkData(
        name: 'GitHub',
        icon: FontAwesomeIcons.github,
        url: AppConstants.githubUrl,
        color: const Color(0xFF181717),
      ),
      _SocialLinkData(
        name: 'Behance',
        icon: FontAwesomeIcons.behance,
        url: AppConstants.behanceUrl,
        color: const Color(0xFF1769FF),
      ),
      _SocialLinkData(
        name: 'Dribbble',
        icon: FontAwesomeIcons.dribbble,
        url: AppConstants.dribbbleUrl,
        color: const Color(0xFFEA4C89),
      ),
    ];

    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        children: links.map((link) => _buildSocialIcon(link, context)).toList(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: links.map((link) => _buildSocialIcon(link, context)).toList(),
      );
    }
  }

  Widget _buildSocialIcon(_SocialLinkData link, BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(link.url),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: showLabels
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    link.icon,
                    size: iconSize,
                    color: iconColor ?? link.color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    link.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              )
            : FaIcon(
                link.icon,
                size: iconSize,
                color: iconColor ?? link.color,
              ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }
}

class _SocialLinkData {
  final String name;
  final IconData icon;
  final String url;
  final Color color;

  const _SocialLinkData({
    required this.name,
    required this.icon,
    required this.url,
    required this.color,
  });
}
