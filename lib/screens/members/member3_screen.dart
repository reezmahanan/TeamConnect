import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Member3Screen extends StatefulWidget {
  const Member3Screen({super.key});

  @override
  State<Member3Screen> createState() => _Member3ScreenState();
}

class _Member3ScreenState extends State<Member3Screen> {
  int _selectedTabIndex = 0;
  int? _expandedProjectIndex;

  // Color Palette - Deep Slate & Emerald/Teal Accent
  static const Color _bgColor = Color(0xFF0F172A);
  static const Color _cardColor = Color(0xFF1E293B);
  static const Color _accentColor = Color(0xFF14B8A6);
  static const Color _accentSoft = Color(0xFF2DD4BF);
  static const Color _textPrimary = Color(0xFFF8FAFC);
  static const Color _textSecondary = Color(0xFF94A3B8);
  static const Color _borderColor = Color(0xFF334155);

  final List<String> _softSkills = const [
    'Communication Skills',
    'Teamwork & Collaboration',
    'Adaptability',
    'Attention to Detail',
    'Quick Learning',
    'Quick Understanding',
    'Organizing & Planning',
    'Ability to Learn New Technologies',
    'Time Management',
  ];

  final List<Map<String, dynamic>> _techSkillGroups = const [
    {
      'title': 'Quality Assurance & Testing',
      'icon': Icons.verified_outlined,
      'skills': [
        'Manual Testing',
        'Test Case Design',
        'Playwright (Python)',
        'Postman (API)',
        'Jira',
        'UI/UX Evaluation',
      ],
    },
    {
      'title': 'Development & Design',
      'icon': Icons.code_rounded,
      'skills': [
        'React.js',
        'Java Spring Boot',
        'Flutter & Dart',
        'Tailwind CSS',
        'MySQL',
        'Figma',
        'Git & GitHub',
      ],
    },
  ];

  final List<Map<String, dynamic>> _projects = const [
    {
      'title': 'SecureTrack SL',
      'role': 'Full-Stack Developer & QA Tester',
      'tech': 'React.js • Java Spring Boot • IoT',
      'description':
          'Real-time IoT container monitoring system. Built the Customs Inspector Dashboard module and authored 100+ functional, non-functional, positive, negative, and UI/UX test cases.',
    },
    {
      'title': 'SkillBridge LK',
      'role': 'Full-Stack Developer',
      'tech': 'HTML • Tailwind CSS • Spring Boot • MySQL',
      'description':
          'A full-stack web marketplace platform connecting Sri Lankan skilled workers with clients through streamlined service discovery and booking workflows.',
    },
    {
      'title': 'Jira Bug Bot',
      'role': 'QA Automation Developer',
      'tech': 'Python • Playwright • Jira REST API',
      'description':
          'Automated UI testing and bug reporting tool that captures failures and logs structured defect tickets directly into Jira.',
    },
    {
      'title': 'SCM-IMS (Inventory Management)',
      'role': 'Full-Stack Contributor',
      'tech': 'React.js • Java Spring Boot',
      'description':
          'Implemented end-to-end product update and delete functionality across the frontend and backend for a collaborative inventory management system.',
    },
  ];

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
        backgroundColor: _bgColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: _textPrimary),
        title: const Text(
          '23IT0482 • Profile',
          style: TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: 20),
                  _buildSocialLinksRow(),
                  const SizedBox(height: 24),
                  _buildTabSelector(),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _buildSelectedTabContent(),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF0F292E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [_accentColor, _accentSoft],
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'lib/assets/images/23IT0482.jpg.jpeg',
                width: 112,
                height: 112,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 112,
                    height: 112,
                    color: _cardColor,
                    alignment: Alignment.center,
                    child: const Text(
                      'BH',
                      style: TextStyle(
                        color: _accentSoft,
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
            'H. M. C. Bhagya Herath',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Aspiring QA Engineer & Full-Stack Developer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _accentSoft,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(20, 184, 166, 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromRGBO(20, 184, 166, 0.4),
              ),
            ),
            child: const Text(
              'Reg No: 23IT0482  •  NDT IT (ITUM)',
              style: TextStyle(
                color: _accentSoft,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinksRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildActionButton(
          icon: Icons.business_center_outlined,
          label: 'LinkedIn',
          onTap: () => _launchExternalUrl(
            'https://www.linkedin.com/in/bhagya-herath2002',
          ),
        ),
        _buildActionButton(
          icon: Icons.code_rounded,
          label: 'GitHub',
          onTap: () => _launchExternalUrl('https://github.com/bhagyaherath-558'),
        ),
        _buildActionButton(
          icon: Icons.language_rounded,
          label: 'Portfolio',
          onTap: () => _launchExternalUrl('https://my-portfolio-qde2.vercel.app'),
        ),
        _buildActionButton(
          icon: Icons.email_outlined,
          label: 'Email',
          onTap: () => _launchExternalUrl('mailto:bhagyaherath558@gmail.com'),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: _accentSoft, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    final tabs = ['Overview', 'Skills & Talents', 'Projects'];
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? _accentColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? _bgColor : _textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSelectedTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildSkillsTab();
      case 2:
        return _buildProjectsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      key: const ValueKey('overview'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          title: 'Personal Information',
          icon: Icons.person_outline_rounded,
          child: Column(
            children: const [
              _InfoRow(
                icon: Icons.badge_outlined,
                label: 'Full Name',
                value: 'Herath Mudiyanselage Chathumini Bhagya Herath',
              ),
              Divider(color: _borderColor, height: 24),
              _InfoRow(
                icon: Icons.numbers_rounded,
                label: 'Registration No',
                value: '23IT0482',
              ),
              Divider(color: _borderColor, height: 24),
              _InfoRow(
                icon: Icons.location_on_outlined,
                label: 'Address',
                value: 'Rikillagaskada, Nuwara Eliya',
              ),
              Divider(color: _borderColor, height: 24),
              _InfoRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: 'bhagyaherath558@gmail.com',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionCard(
          title: 'Academic Qualifications & Certifications',
          icon: Icons.school_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _QualificationItem(
                title: 'National Diploma in Technology (NDT) – IT',
                subtitle: 'Institute of Technology, University of Moratuwa (ITUM)',
                badge: 'Final Year Undergraduate',
              ),
              SizedBox(height: 14),
              _QualificationItem(
                title: 'ISTQB Certified Tester Foundation Level (CTFL) v4.0',
                subtitle: 'Sri Lanka Software Testing Board (SLSTB)',
                badge: 'Software QA',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsTab() {
    return Column(
      key: const ValueKey('skills'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          title: 'Soft Skills & Special Talents',
          icon: Icons.auto_awesome_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _softSkills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(20, 184, 166, 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromRGBO(20, 184, 166, 0.35),
                  ),
                ),
                child: Text(
                  skill,
                  style: const TextStyle(
                    color: _accentSoft,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        ..._techSkillGroups.map((group) {
          final skills = group['skills'] as List<String>;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildSectionCard(
              title: group['title'] as String,
              icon: group['icon'] as IconData,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Text(
                      skill,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 13,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildProjectsTab() {
    return Column(
      key: const ValueKey('projects'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(_projects.length, (index) {
        final project = _projects[index];
        final isExpanded = _expandedProjectIndex == index;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              setState(() {
                _expandedProjectIndex = isExpanded ? null : index;
              });
            },
            borderRadius: BorderRadius.circular(18),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isExpanded ? _accentColor : _borderColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project['title']!,
                              style: const TextStyle(
                                color: _textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project['role']!,
                              style: const TextStyle(
                                color: _accentSoft,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: _textSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project['tech']!,
                    style: const TextStyle(
                      color: _textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  if (isExpanded) ...[
                    const Divider(color: _borderColor, height: 24),
                    Text(
                      project['description']!,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 13.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
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
              Icon(icon, color: _accentSoft, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF94A3B8), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFFF8FAFC),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QualificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;

  const _QualificationItem({
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFF8FAFC),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(20, 184, 166, 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Color(0xFF2DD4BF),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
