import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Member5Screen extends StatefulWidget {
  const Member5Screen({super.key});

  @override
  State<Member5Screen> createState() => _Member5ScreenState();
}

class _Member5ScreenState extends State<Member5Screen> {
  int _selectedSection = 0;
  bool _showContactDetails = false;

  static const String _email = 'ayanthijayamali29@gmail.com';
  static const String _phone = '+94 70 111 0117';
  static const String _githubUrl = 'https://github.com/Ayanthi486';
  static const String _linkedinUrl = 'https://www.linkedin.com/in/ayanthi-jayamali-11891635b';

  // Unique Deep Purple & Slate Theme for 23IT0486
  final Color _bgDark = const Color(0xFF0F0C1D);
  final Color _cardDark = const Color(0xFF1A162E);
  final Color _accentPurple = const Color(0xFF8B5CF6);
  final Color _accentLight = const Color(0xFFC4B5FD);

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(text, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF281E4B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  Future<void> _openUrl(String rawUrl) async {
    final uri = Uri.parse(rawUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await Clipboard.setData(ClipboardData(text: rawUrl));
        _showMessage('Link copied: $rawUrl');
      }
    } catch (_) {
      await Clipboard.setData(ClipboardData(text: rawUrl));
      _showMessage('Could not open link directly. Copied: $rawUrl');
    }
  }

  Future<void> _contactEmail() async {
    final mailUri = Uri(scheme: 'mailto', path: _email);
    try {
      final launched = await launchUrl(mailUri);
      if (!launched) {
        await Clipboard.setData(const ClipboardData(text: _email));
        _showMessage('Email copied to clipboard: $_email');
      }
    } catch (_) {
      await Clipboard.setData(const ClipboardData(text: _email));
      _showMessage('Email copied to clipboard: $_email');
    }
  }

  Future<void> _callPhone() async {
    final telUri = Uri(scheme: 'tel', path: _phone.replaceAll(' ', ''));
    try {
      final launched = await launchUrl(telUri);
      if (!launched) {
        await Clipboard.setData(const ClipboardData(text: _phone));
        _showMessage('Phone copied: $_phone');
      }
    } catch (_) {
      await Clipboard.setData(const ClipboardData(text: _phone));
      _showMessage('Phone copied: $_phone');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgDark,
      appBar: AppBar(
        backgroundColor: _cardDark,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '23IT0486 • Ayanthi Jayamali',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle Contact Info',
            icon: Icon(
              _showContactDetails ? Icons.visibility_off : Icons.contact_mail,
              color: _accentLight,
            ),
            onPressed: () {
              setState(() {
                _showContactDetails = !_showContactDetails;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. PROFILE HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_cardDark, const Color(0xFF281E4B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _accentPurple.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _accentPurple, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage(
                        'lib/assets/images/Ayanthi.jpeg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'AYANTHI JAYAMALI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _accentPurple.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Reg No: 23IT0486  |  Software & ML Enthusiast',
                      style: TextStyle(
                        color: _accentLight,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Tappable Address & Email
                  _buildTappableInfoRow(
                    icon: Icons.location_on_outlined,
                    text: 'Homagama, Sri Lanka',
                    onTap: () => _showMessage('Location: Homagama, Sri Lanka'),
                  ),
                  const SizedBox(height: 6),
                  _buildTappableInfoRow(
                    icon: Icons.email_outlined,
                    text: _email,
                    onTap: _contactEmail,
                  ),

                  if (_showContactDetails) ...[
                    const SizedBox(height: 6),
                    _buildTappableInfoRow(
                      icon: Icons.phone_outlined,
                      text: _phone,
                      onTap: _callPhone,
                    ),
                    const SizedBox(height: 6),
                    _buildTappableInfoRow(
                      icon: Icons.code,
                      text: 'github.com/Ayanthi486',
                      onTap: () => _openUrl(_githubUrl),
                    ),
                    const SizedBox(height: 6),
                    _buildTappableInfoRow(
                      icon: Icons.work_outline,
                      text: 'LinkedIn: Ayanthi Jayamali',
                      onTap: () => _openUrl(_linkedinUrl),
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Quick Action Link Buttons (Always easy to tap)
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _buildActionChipButton(
                        icon: Icons.code_rounded,
                        label: 'GitHub',
                        onTap: () => _openUrl(_githubUrl),
                      ),
                      _buildActionChipButton(
                        icon: Icons.work_outline_rounded,
                        label: 'LinkedIn',
                        onTap: () => _openUrl(_linkedinUrl),
                      ),
                      _buildActionChipButton(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        onTap: _contactEmail,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _showContactDetails = !_showContactDetails;
                      });
                    },
                    icon: Icon(
                      _showContactDetails
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: _accentLight,
                      size: 18,
                    ),
                    label: Text(
                      _showContactDetails
                          ? 'Hide Extra Contact Details'
                          : 'Show Phone & Full Contact List',
                      style: TextStyle(color: _accentLight, fontSize: 12.5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 2. INTERACTIVE NAVIGATION TABS
            Row(
              children: [
                _buildTabButton(0, 'About & Skills'),
                const SizedBox(width: 8),
                _buildTabButton(1, 'Projects & Exp'),
                const SizedBox(width: 8),
                _buildTabButton(2, 'Certs & Links'),
              ],
            ),

            const SizedBox(height: 18),

            // 3. TAB CONTENT
            if (_selectedSection == 0) _buildAboutAndSkillsSection(),
            if (_selectedSection == 1) _buildProjectsAndExperienceSection(),
            if (_selectedSection == 2) _buildCertificationsAndLinksSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutAndSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          title: 'Profile Summary',
          icon: Icons.person_outline,
          child: const Text(
            'Final-year NDT Information Technology undergraduate at the Institute of Technology, University of Moratuwa (ITUM), with a strong passion for Machine Learning and Software Engineering. Experienced in full-stack web development alongside hands-on AI/ML workflows.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
              fontSize: 13.5,
            ),
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Academic Qualifications',
          icon: Icons.school_outlined,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'National Diploma in Technology (NDT) in Information Technology',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Institute of Technology, University of Moratuwa (ITUM)',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Soft Skills & Special Talents',
          icon: Icons.psychology_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Problem Solving',
              'Team Collaboration',
              'Clean Code Practices',
              'Analytical Thinking',
              'Time Management',
              'UI/UX Design & Wireframing',
              'Technical Documentation',
            ].map((skill) => _buildChip(skill, isSoft: true)).toList(),
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Technical Skills',
          icon: Icons.terminal,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Python',
              'Java',
              'React',
              'Next.js',
              'Tailwind CSS',
              'Flutter',
              'Spring Boot',
              'Node.js (Express)',
              'NestJS',
              'MySQL',
              'PostgreSQL',
              'Scikit-Learn',
              'Pandas',
              'Docker',
              'Git & GitHub',
            ].map((skill) => _buildChip(skill)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsAndExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          title: 'Industry Experience',
          icon: Icons.work_history_outlined,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI & Machine Learning Intern — Primeor Solutions',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Stack: Python, Scikit-Learn, Pandas, Google Colab',
                style: TextStyle(color: Color(0xFFC4B5FD), fontSize: 12.5),
              ),
              SizedBox(height: 8),
              Text(
                '• Executed end-to-end ML workflows: Data Preprocessing, IQR Outlier Removal & EDA.\n'
                '• Trained Logistic Regression, Linear Regression & Random Forest models for profit prediction.\n'
                '• Applied K-Means Clustering for customer segmentation and business analytics.',
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.45,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Key Projects',
          icon: Icons.folder_special_outlined,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Freight Forwarding Management System (Hub Lanka)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Stack: NestJS, React, PostgreSQL, Tailwind CSS',
                style: TextStyle(color: Color(0xFFC4B5FD), fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                'Designed end-to-end architecture, SRS documentation, NestJS REST APIs, and dynamic analytics dashboards.',
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.4,
                  fontSize: 13,
                ),
              ),
              Divider(color: Colors.white12, height: 22),
              Text(
                '2. Resource Hub — Full-Stack Web Application',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Stack: React, Spring Boot, REST APIs',
                style: TextStyle(color: Color(0xFFC4B5FD), fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                'Web platform for developers and students to discover, share, and manage study materials and code snippets.',
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.4,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCertificationsAndLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          title: 'Professional Certifications',
          icon: Icons.verified_outlined,
          child: const Text(
            '• Python for Beginners & Programming — Dept. of CSE, University of Moratuwa\n'
            '• Machine Learning Using Python — Simplilearn SkillUp\n'
            '• Getting Started with ML Algorithms — Simplilearn SkillUp\n'
            '• Getting Started with Docker — Simplilearn SkillUp',
            style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 13),
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Interactive Links & Interests',
          icon: Icons.link_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Interests: Artificial Intelligence, Machine Learning, Full-Stack Web & Mobile Development, UI/UX Prototyping.',
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.45,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.code_rounded, color: _accentLight),
                title: const Text(
                  'GitHub Profile',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                subtitle: Text(
                  _githubUrl,
                  style: TextStyle(color: _accentLight, fontSize: 12.5),
                ),
                trailing: Icon(Icons.open_in_new, color: _accentLight, size: 18),
                onTap: () => _openUrl(_githubUrl),
              ),
              const Divider(color: Colors.white12, height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.work_outline_rounded, color: _accentLight),
                title: const Text(
                  'LinkedIn Profile',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                subtitle: Text(
                  'Ayanthi Jayamali',
                  style: TextStyle(color: _accentLight, fontSize: 12.5),
                ),
                trailing: Icon(Icons.open_in_new, color: _accentLight, size: 18),
                onTap: () => _openUrl(_linkedinUrl),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTappableInfoRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: _accentLight, size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white38,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChipButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: _accentPurple.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _accentPurple.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: _accentLight),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: _accentLight,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    final bool isSelected = _selectedSection == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSection = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? _accentPurple : _cardDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? _accentLight : Colors.white12,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _accentLight, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildChip(String label, {bool isSoft = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: isSoft
            ? Colors.tealAccent.withValues(alpha: 0.12)
            : _accentPurple.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSoft
              ? Colors.tealAccent.withValues(alpha: 0.4)
              : _accentPurple.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSoft ? Colors.tealAccent.shade100 : _accentLight,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}