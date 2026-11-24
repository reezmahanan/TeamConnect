import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Member2Screen extends StatefulWidget {
  const Member2Screen({super.key});

  @override
  State<Member2Screen> createState() => _Member2ScreenState();
}

class _Member2ScreenState extends State<Member2Screen> {
  int _selectedTabIndex = 0;
  int? _expandedProjectIndex;

  final List<String> _tabs = ['Overview', 'Skills & Tools', 'Projects'];

  // Theme Palette - Deep Teal & Soft Mint (Distinct from Member 1)
  static const Color _primaryTeal = Color(0xFF0F766E);
  static const Color _darkTeal = Color(0xFF115E59);
  static const Color _accentMint = Color(0xFFCCFBF1);
  static const Color _surfaceBg = Color(0xFFF4F7F6);
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF475569);

  Future<void> _launchExternalUrl(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $urlString'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surfaceBg,
      body: CustomScrollView(
        slivers: [
          _buildSliverHeader(),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildQuickActionRow(),
                      const SizedBox(height: 18),
                      _buildInteractiveTabBar(),
                      const SizedBox(height: 18),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: _buildSelectedTabContent(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      expandedHeight: 270,
      pinned: true,
      backgroundColor: _primaryTeal,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        '23IT0481 • Profile',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_darkTeal, _primaryTeal, Color(0xFF14B8A6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.22),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 54,
                    backgroundColor: _accentMint,
                    backgroundImage: AssetImage('assets/images/wageesha.jpeg'),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'W. R. Kavini Wageesha Hansamali',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '23IT0481  |  NDT in Information Technology (ITUM)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildSocialChip(
          icon: Icons.code_rounded,
          label: 'GitHub',
          onTap: () => _launchExternalUrl('https://github.com/Wageesha03'),
        ),
        _buildSocialChip(
          icon: Icons.work_outline_rounded,
          label: 'LinkedIn',
          onTap: () => _launchExternalUrl(
            'https://www.linkedin.com/in/kavini-wageesha',
          ),
        ),
        _buildSocialChip(
          icon: Icons.email_outlined,
          label: 'Email Me',
          onTap: () =>
              _launchExternalUrl('mailto:kavinirathnayaka15@gmail.com'),
        ),
      ],
    );
  }

  Widget _buildSocialChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: _primaryTeal),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: _textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractiveTabBar() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final bool isSelected = _selectedTabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryTeal : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : _textSecondary,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13.5,
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
      case 1:
        return _buildSkillsTab();
      case 2:
        return _buildProjectsTab();
      case 0:
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
          title: 'About Me',
          icon: Icons.person_outline_rounded,
          child: const Text(
            'Information Technology undergraduate at the Institute of Technology, University of Moratuwa (ITUM), passionate about Software Quality Assurance, full-stack & mobile application development, and user-centered digital design. Experienced in structured test case design, API testing, and collaborative team delivery.',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Personal & Contact Details',
          icon: Icons.badge_outlined,
          child: Column(
            children: [
              _buildInfoRow(
                Icons.numbers_rounded,
                'Registration No.',
                '23IT0481',
              ),
              const Divider(height: 18),
              _buildInfoRow(
                Icons.location_on_outlined,
                'Address',
                'Polhena, Angulugaha, Galle, Sri Lanka',
              ),
              const Divider(height: 18),
              _buildInfoRow(
                Icons.alternate_email_rounded,
                'Email',
                'kavinirathnayaka15@gmail.com',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Academic Qualifications',
          icon: Icons.school_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineItem(
                title: 'National Diploma in Technology (NDT) in IT',
                subtitle:
                    'Institute of Technology, University of Moratuwa (ITUM)',
                period: '2025 – Present',
              ),
              const SizedBox(height: 14),
              _buildTimelineItem(
                title: 'G.C.E. Advanced Level – Physical Science Stream',
                subtitle:
                    'Anuladevi Balika Vidyalaya, Galle (Combined Maths, Chemistry, Physics)',
                period: '2023',
              ),
              const SizedBox(height: 14),
              _buildTimelineItem(
                title: 'Certificates in Information Technology & English',
                subtitle: 'Open University of Sri Lanka & ICBT Campus',
                period: '2023',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Special Talents & Interests',
          icon: Icons.palette_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TagChip(label: 'Graphic Design & Vector Illustration'),
              _TagChip(label: 'UI/UX Prototyping (Figma)'),
              _TagChip(label: 'Video Editing & 2D Animation'),
              _TagChip(label: 'Event Coordination & Leadership'),
              _TagChip(label: 'Fashion & Outfit Sketching'),
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
          title: 'Quality Assurance & Testing',
          icon: Icons.verified_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TagChip(label: 'Manual Testing', isHighlighted: true),
              _TagChip(label: 'Test Case Design', isHighlighted: true),
              _TagChip(label: 'Bug Tracking (Jira)', isHighlighted: true),
              _TagChip(label: 'API Testing (Postman)', isHighlighted: true),
              _TagChip(label: 'Selenium & Playwright'),
              _TagChip(label: 'Regression & Functional Testing'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Programming & Development',
          icon: Icons.terminal_rounded,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TagChip(label: 'Flutter & Dart'),
              _TagChip(label: 'Java & Spring Boot'),
              _TagChip(label: 'React & NestJS'),
              _TagChip(label: 'Python & R'),
              _TagChip(label: 'PostgreSQL & MySQL'),
              _TagChip(label: 'Git & GitHub'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Soft Skills',
          icon: Icons.groups_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TagChip(label: 'Team Collaboration'),
              _TagChip(label: 'Analytical Problem Solving'),
              _TagChip(label: 'Attention to Detail'),
              _TagChip(label: 'Time Management'),
              _TagChip(label: 'Clear Documentation'),
              _TagChip(label: 'Adaptability'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Certifications & Experience',
          icon: Icons.workspace_premium_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineItem(
                title: 'Professional Trainee (6 Months)',
                subtitle: 'People’s Bank – Banking Operations & Documentation',
                period: 'Completed',
              ),
              const SizedBox(height: 12),
              _buildTimelineItem(
                title: 'Python for Beginners & Intro to SQA',
                subtitle: 'CODL, University of Moratuwa',
                period: '2026',
              ),
              const SizedBox(height: 12),
              _buildTimelineItem(
                title: 'Microsoft Certified: Azure Fundamentals (AZ-900)',
                subtitle: 'Microsoft Learn Curriculum',
                period: '2026',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsTab() {
    const List projects = [
      {
        'title': 'TeamConnect – Group Profile App',
        'tech': 'Flutter • Dart • Firebase Auth',
        'summary':
            'Collaborative mobile group profile app featuring Firebase authentication, responsive member directory, and custom interactive profile views.',
      },
      {
        'title': 'Hub Lanka Freight Forwarding System',
        'tech': 'React • NestJS • Prisma • PostgreSQL',
        'summary':
            'Full-stack freight forwarding management platform. Authored 100+ manual test cases, executed functional/regression testing, and logged defects.',
      },
      {
        'title': 'Supply Chain Inventory Management System',
        'tech': 'Spring Boot • React • MySQL',
        'summary':
            'Inventory tracking module supporting product image uploads, stock monitoring, and dynamic multi-criteria search filtering.',
      },
      {
        'title': 'Web-Based Career Suggestion System',
        'tech': 'PHP • JavaScript • MySQL',
        'summary':
            'Student guidance web platform recommending academic and career pathways based on user skills and subject preferences.',
      },
    ];

    return Column(
      key: const ValueKey('projects'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(projects.length, (index) {
        final project = projects[index];
        final bool isExpanded = _expandedProjectIndex == index;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            elevation: 1,
            shadowColor: Colors.black12,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                setState(() {
                  _expandedProjectIndex = isExpanded ? null : index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _accentMint,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.folder_special_outlined,
                            color: _primaryTeal,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project['title']!,
                                style: const TextStyle(
                                  color: _textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                project['tech']!,
                                style: const TextStyle(
                                  color: _primaryTeal,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5,
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
                    if (isExpanded) ...[
                      const Divider(height: 22),
                      Text(
                        project['summary']!,
                        style: const TextStyle(
                          color: _textSecondary,
                          fontSize: 13.5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ],
                ),
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _primaryTeal, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 19, color: _primaryTeal),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required String period,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: _primaryTeal,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                period,
                style: const TextStyle(
                  color: _primaryTeal,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final bool isHighlighted;

  const _TagChip({
    required this.label,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isHighlighted
            ? const Color(0xFFCCFBF1)
            : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted
              ? const Color(0xFF5EEAD4)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isHighlighted
              ? const Color(0xFF115E59)
              : const Color(0xFF334155),
          fontSize: 12.5,
          fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }
}