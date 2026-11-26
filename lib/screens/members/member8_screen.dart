import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Member8Screen extends StatefulWidget {
  const Member8Screen({super.key});

  @override
  State<Member8Screen> createState() => _Member8ScreenState();
}

class _Member8ScreenState extends State<Member8Screen> {
  String _selectedSkillCategory = 'All';
  bool _showContactDetails = true;

  // Color Palette - Clean Light Mode with Deep Indigo & Warm Amber
  static const Color _bgColor = Color(0xFFF4F6FA);
  static const Color _cardColor = Colors.white;
  static const Color _primaryColor = Color(0xFF312E81);
  static const Color _accentColor = Color(0xFFD97706);
  static const Color _textDark = Color(0xFF1E293B);
  static const Color _textMuted = Color(0xFF64748B);
  static const Color _borderColor = Color(0xFFE2E8F0);

  // TODO: Update with your actual Soft Skills, Technical Skills & Talents
  final List> _allSkills = const [
    {'name': 'Teamwork & Collaboration', 'category': 'Soft Skills'},
    {'name': 'Problem Solving', 'category': 'Soft Skills'},
    {'name': 'Leadership', 'category': 'Soft Skills'},
    {'name': 'Time Management', 'category': 'Soft Skills'},
    {'name': 'Communication', 'category': 'Soft Skills'},
    {'name': 'Flutter & Dart', 'category': 'Technical'},
    {'name': 'Java & Spring Boot', 'category': 'Technical'},
    {'name': 'Web Development', 'category': 'Technical'},
    {'name': 'Database Management (MySQL)', 'category': 'Technical'},
    {'name': 'Git & GitHub', 'category': 'Technical'},
    {'name': 'Sports / Photography / Music', 'category': 'Talents'},
  ];

  List> get _filteredSkills {
    if (_selectedSkillCategory == 'All') return _allSkills;
    return _allSkills
        .where((s) => s['category'] == _selectedSkillCategory)
        .toList();
  }

  Future<void> _launchExternalUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $url'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to launch link: $url'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Member Profile • 23IT0490',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProfileBanner(),
                  const SizedBox(height: 20),
                  _buildQuickLinksCard(),
                  const SizedBox(height: 20),
                  _buildContactInfoCard(),
                  const SizedBox(height: 20),
                  _buildAcademicCard(),
                  const SizedBox(height: 20),
                  _buildInteractiveSkillsCard(),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), Color(0xFF4338CA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(49, 46, 129, 0.2),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _accentColor, width: 3),
            ),
            child: ClipOval(
              child: Image.asset(
                'lib/assets/images/23IT0490.jpg',
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110,
                    height: 110,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text(
                      'SK',
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'K. A. S. K. Kapuhenthuduwa',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'NDT Information Technology Undergraduate',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE0E7FF),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: _accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Reg No: 23IT0490',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinksCard() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        // TODO: Update with your actual GitHub, LinkedIn, and Email links
        _buildLinkChip(
          icon: Icons.code_rounded,
          label: 'GitHub',
          onTap: () => _launchExternalUrl('https://github.com/aselsenath2002'),
        ),
        _buildLinkChip(
          icon: Icons.business_center_outlined,
          label: 'LinkedIn',
          onTap: () => _launchExternalUrl(
              'https://www.linkedin.com/in/asel-senath-6100a1360'),
        ),
        _buildLinkChip(
          icon: Icons.email_outlined,
          label: 'Email Me',
          onTap: () => _launchExternalUrl('mailto:aselsenath2002@gmail.com'),
        ),
      ],
    );
  }

  Widget _buildLinkChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: _cardColor,
        foregroundColor: _primaryColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: _borderColor),
        ),
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, color: _primaryColor),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Personal Information',
                  style: TextStyle(
                    color: _textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showContactDetails = !_showContactDetails;
                  });
                },
                child: Text(
                  _showContactDetails ? 'Hide' : 'Show',
                  style: const TextStyle(
                    color: _accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (_showContactDetails) ...[
            const Divider(color: _borderColor, height: 24),
            const _DetailRow(
              icon: Icons.badge_outlined,
              label: 'Full Name',
              value: 'Mr K A S K Kapuhenthuduwa',
            ),
            const SizedBox(height: 14),
            const _DetailRow(
              icon: Icons.numbers_rounded,
              label: 'Registration Number',
              value: '23IT0490',
            ),
            const SizedBox(height: 14),
            // TODO: Update Address
            const _DetailRow(
              icon: Icons.location_on_outlined,
              label: 'Address',
              value: '390/2, Nagashandiya, Mandawala',
            ),
            const SizedBox(height: 14),
            // TODO: Update Email
            const _DetailRow(
              icon: Icons.email_outlined,
              label: 'Email Address',
              value: 'aselsenath2002@gmail.com',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAcademicCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.school_outlined,
