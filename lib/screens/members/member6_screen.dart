import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Member6Screen extends StatefulWidget {
  const Member6Screen({super.key});

  @override
  State<Member6Screen> createState() => _Member6ScreenState();
}

class _Member6ScreenState extends State<Member6Screen> {
  // ─── Theme Palette (Royal Indigo & Rose Accent) ──────────────────────────
  static const Color _primary = Color(0xFF4F46E5); // Indigo
  static const Color _primaryDark = Color(0xFF3730A3);
  static const Color _primaryLight = Color(0xFFEEF2FF);
  static const Color _accentRose = Color(0xFFF43F5E); // Rose
  static const Color _bgScreen = Color(0xFFF8FAFC);
  static const Color _surfaceCard = Colors.white;
  static const Color _textMain = Color(0xFF0F172A);
  static const Color _textSub = Color(0xFF475569);
  static const Color _textMuted = Color(0xFF94A3B8);
  static const Color _borderSubtle = Color(0xFFE2E8F0);

  // ─── State Variables (StatefulWidget & setState) ────────────────────────
  int _selectedTabIndex = 0;
  int _appreciationCount = 24;
  bool _hasAppreciated = false;
  int? _expandedEduIndex;
  int? _expandedProjectIndex;

  // ─── URL Launcher & Clipboard Helpers ───────────────────────────────────
  Future<void> _openExternalLink(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _showToast('Could not open link: $urlString');
      }
    } catch (_) {
      _showToast('Could not open external link');
    }
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    _showToast('$label copied to clipboard!');
  }

  void _showToast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _primaryDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─── Full Profile Image Dialog ──────────────────────────────────────────
  void _showFullProfileImage() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/jayampathi/images/profile/profile.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 280,
                  height: 320,
                  color: _primaryLight,
                  child: const Icon(Icons.person, size: 100, color: _primary),
                ),
              ),
            ),
            const SizedBox(height: 12),
            IconButton(
              onPressed: () => Navigator.pop(ctx),
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Full Project Image Dialog ──────────────────────────────────────────
  void _showFullProjectImage(String imagePath, String title) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF2E2A72),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(ctx),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Container(
                color: Colors.black,
                constraints: const BoxConstraints(maxHeight: 500),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      height: 200,
                      color: _primaryLight,
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 48, color: _primary),
                      ),
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

  // ─── Build Method ───────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgScreen,
      appBar: AppBar(
        title: const Text(
          'Member Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E2A72),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            tooltip: 'Appreciate Profile',
            icon: Icon(
              _hasAppreciated ? Icons.favorite : Icons.favorite_border,
              color: _hasAppreciated ? _accentRose : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _hasAppreciated = !_hasAppreciated;
                _appreciationCount += _hasAppreciated ? 1 : -1;
              });
              _showToast(
                _hasAppreciated
                    ? 'Thank you for your appreciation! ❤️'
                    : 'Appreciation removed',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeroHeader(),
            const SizedBox(height: 16),
            _buildCustomTabBar(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildTabContent(),
            ),
            const SizedBox(height: 32),
            _buildFooterAppreciationCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ─── Hero Header ────────────────────────────────────────────────────────
  Widget _buildHeroHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E2A72), // Rich Royal Indigo
            Color(0xFF3730A3), // Deep Indigo
            Color(0xFF4338CA), // Royal Indigo
            Color(0xFF4F46E5), // Vibrant Indigo
            Color(0xFF6366F1), // Soft Indigo Accent
          ],
          stops: [0.0, 0.25, 0.50, 0.75, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E2A72).withValues(alpha: 0.30),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // White Ambient Radial Glow behind Avatar
          Positioned(
            top: -10,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.35),
                    Colors.white.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          Column(
            children: [
              // Avatar
              GestureDetector(
                onTap: _showFullProfileImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.22),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/jayampathi/images/profile/profile.jpg',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 120,
                            height: 120,
                            color: _primaryLight,
                            child: const Icon(Icons.person, size: 60, color: _primary),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: _accentRose,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Name
              const Text(
                'G W Tharaka Jayampathi',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.3,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Badges
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 6,
                children: [
                  _buildBadge(
                    icon: Icons.badge_outlined,
                    text: '23IT0487',
                  ),
                  _buildBadge(
                    icon: Icons.school_outlined,
                    text: 'NDT IT – ITUM',
                  ),
                  _buildBadge(
                    icon: Icons.emoji_events_outlined,
                    text: 'University Athlete 🏅',
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Quick Action Header Buttons
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 6,
                children: [
                  _buildHeaderButton(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    onTap: () => _openExternalLink('mailto:jayampathitharaka@gmail.com'),
                  ),
                  _buildHeaderButton(
                    icon: Icons.phone_outlined,
                    label: 'Call',
                    onTap: () => _openExternalLink('tel:+94771959646'),
                  ),
                  _buildHeaderButton(
                    icon: Icons.link,
                    label: 'LinkedIn',
                    onTap: () => _openExternalLink(
                      'https://www.linkedin.com/in/tharaka-jayampathi-38375235b',
                    ),
                  ),
                  _buildHeaderButton(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: () => _openExternalLink('https://github.com/Tharaka-Jayampathi'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF312E81), size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF312E81),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEEF2FF), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF3730A3), size: 15),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF3730A3),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Custom Segmented Tab Bar ───────────────────────────────────────────
  Widget _buildCustomTabBar() {
    final tabs = [
      {'title': 'About & Experience', 'icon': Icons.person_outline},
      {'title': 'Skills & Education', 'icon': Icons.school_outlined},
      {'title': 'Projects & Activities', 'icon': Icons.stars_outlined},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(5),
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
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                decoration: BoxDecoration(
                  color: isSelected ? _primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: _primary.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[index]['icon'] as IconData,
                      size: 17,
                      color: isSelected ? Colors.white : const Color(0xFF1E293B),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        tabs[index]['title'] as String,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF1E293B),
                          letterSpacing: 0.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── Tab Content Switcher ───────────────────────────────────────────────
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildAboutAndExperienceTab();
      case 1:
        return _buildSkillsAndEducationTab();
      case 2:
        return _buildProjectsAndAchievementsTab();
      default:
        return const SizedBox.shrink();
    }
  }

  // ═════════════════════════════════════════════════════════════════════════
  // TAB 1: About, Contact, Professional Experience & References
  // ═════════════════════════════════════════════════════════════════════════
  Widget _buildAboutAndExperienceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Professional Summary (From CV)
        _buildSectionCard(
          title: 'Professional Summary',
          icon: Icons.lightbulb_outline,
          child: const Text(
            'Enthusiastic Information Technology Undergraduate at the Institute of Technology, '
            'University of Moratuwa (ITUM), dedicated to building scalable web applications and intuitive software solutions. '
            'Demonstrated competence across frontend engineering (React.js, JavaScript), asynchronous API integrations, '
            'backend microservices (Python, FastAPI), and hardware-software interfacing.\n\n'
            'Certified in Python by the Department of Computer Science & Engineering, University of Moratuwa and '
            'Data Science by Cisco Networking Academy. University athlete recognized for discipline, perseverance, and '
            'cross-functional teamwork, seeking a Software Engineer Intern role to contribute high-quality code and learn within an agile engineering team.',
            style: TextStyle(
              fontSize: 13,
              color: _textSub,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Personal & Contact Information (From CV)
        _buildSectionCard(
          title: 'Personal & Contact Details',
          icon: Icons.contact_page_outlined,
          child: Column(
            children: [
              _buildDetailRow(
                icon: Icons.person_outline,
                label: 'Full Name',
                value: 'G. W. Tharaka Jayampathi',
              ),
              const Divider(height: 20, color: _borderSubtle),
              _buildDetailRow(
                icon: Icons.badge_outlined,
                label: 'Registration Number',
                value: '23IT0487',
                onCopy: () => _copyToClipboard('23IT0487', 'Registration Number'),
              ),
              const Divider(height: 20, color: _borderSubtle),
              _buildDetailRow(
                icon: Icons.email_outlined,
                label: 'Email Address',
                value: 'jayampathitharaka@gmail.com',
                onCopy: () => _copyToClipboard('jayampathitharaka@gmail.com', 'Email Address'),
                onTap: () => _openExternalLink('mailto:jayampathitharaka@gmail.com'),
              ),
              const Divider(height: 20, color: _borderSubtle),
              _buildDetailRow(
                icon: Icons.phone_outlined,
                label: 'Phone Number',
                value: '+94 771959646',
                onCopy: () => _copyToClipboard('+94771959646', 'Phone Number'),
                onTap: () => _openExternalLink('tel:+94771959646'),
              ),
              const Divider(height: 20, color: _borderSubtle),
              _buildDetailRow(
                icon: Icons.location_on_outlined,
                label: 'Address / Location',
                value: 'Karandeniya, Sri Lanka',
                onCopy: () => _copyToClipboard('Karandeniya, Sri Lanka', 'Address'),
              ),
              const Divider(height: 20, color: _borderSubtle),
              _buildDetailRow(
                icon: Icons.account_balance_outlined,
                label: 'Institute',
                value: 'Institute of Technology, University of Moratuwa (ITUM)',
              ),
              const Divider(height: 20, color: _borderSubtle),
              _buildDetailRow(
                icon: Icons.computer_outlined,
                label: 'Academic Division',
                value: 'Division of Information Technology',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Professional Experience (From CV)
        _buildSectionCard(
          title: 'Professional Experience',
          icon: Icons.work_outline_rounded,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _bgScreen,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'ICT Technician',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _textMain,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _primaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '2023 – 2024',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Zonal Education Office • Ambalangoda, Sri Lanka',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _primary,
                  ),
                ),
                const SizedBox(height: 10),
                _buildBulletPoint(
                  'Diagnosed and resolved hardware and software issues across departmental workstations, performing root-cause analysis to ensure uninterrupted operations.',
                ),
                _buildBulletPoint(
                  'Maintained IT infrastructure, administered routine system upgrades, and executed data verification protocols to safeguard institutional records.',
                ),
                _buildBulletPoint(
                  'Supported administrative personnel with technical diagnostics, database queries, and system maintenance.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),


        // Social / Professional Links
        _buildSectionCard(
          title: 'Profiles & External Links',
          icon: Icons.link_rounded,
          child: Row(
            children: [
              Expanded(
                child: _buildSocialCard(
                  icon: Icons.code,
                  title: 'GitHub',
                  subtitle: '@Tharaka-Jayampathi',
                  color: const Color(0xFF24292E),
                  onTap: () => _openExternalLink('https://github.com/Tharaka-Jayampathi'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialCard(
                  icon: Icons.business_center_outlined,
                  title: 'LinkedIn',
                  subtitle: 'Tharaka Jayampathi',
                  color: const Color(0xFF0A66C2),
                  onTap: () => _openExternalLink('https://www.linkedin.com/in/tharaka-jayampathi-38375235b'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════════════════
  // TAB 2: Skills, Education & Certifications
  // ═════════════════════════════════════════════════════════════════════════
  Widget _buildSkillsAndEducationTab() {
    final education = [
      {
        'title': 'National Diploma in Technology (NDT) in IT',
        'institution': 'Institute of Technology, University of Moratuwa (ITUM)',
        'duration': '2025 – Present (Undergraduate)',
        'description':
            'Relevant Coursework: Data Structures & Algorithms, Object-Oriented Programming, '
            'Database Management Systems, Software Engineering Concepts, Mobile Communication.',
        'icon': Icons.school,
      },
      {
        'title': 'ICT Technician (NVQ 4)',
        'institution': 'Technical College Balapitiya',
        'duration': '2024',
        'description':
            'Comprehensive technical vocational qualification covering computer hardware, networking, system deployment, and troubleshooting.',
        'icon': Icons.precision_manufacturing_outlined,
      },
      {
        'title': 'G.C.E. Advanced Level',
        'institution': 'Sri Devananda College, Ambalangoda',
        'duration': '2023',
        'description':
            'Successfully completed Advanced Level examinations qualifying for technological higher education.',
        'icon': Icons.menu_book,
      },
    ];

    final certifications = [
      {
        'title': 'Python for Beginners',
        'issuer': 'Dept. of Computer Science & Engineering, University of Moratuwa',
        'date': 'Feb 2026',
        'icon': Icons.code_rounded,
      },
      {
        'title': 'Introduction to Data Science',
        'issuer': 'Cisco Networking Academy',
        'date': 'Nov 2025',
        'icon': Icons.insights_rounded,
      },
      {
        'title': 'ICT Certificate Course',
        'issuer': 'Open University of Sri Lanka (OUSL)',
        'date': 'Certified',
        'icon': Icons.computer_rounded,
      },
      {
        'title': 'Foundation Diploma in English',
        'issuer': 'Eurasian Campus',
        'date': 'Certified',
        'icon': Icons.language_rounded,
      },
    ];

    final softSkills = [
      'Analytical Problem Solving',
      'Quick Learning',
      'Team Collaboration',
      'Clear Communication',
      'Time Management',
      'Discipline & Perseverance',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Education Timeline (From CV)
        _buildSectionCard(
          title: 'Education',
          icon: Icons.history_edu_outlined,
          child: Column(
            children: List.generate(education.length, (index) {
              final edu = education[index];
              final isExpanded = _expandedEduIndex == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isExpanded ? _primaryLight.withValues(alpha: 0.5) : _bgScreen,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isExpanded ? _primary.withValues(alpha: 0.4) : _borderSubtle,
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedEduIndex = expanded ? index : null;
                      });
                    },
                    leading: CircleAvatar(
                      backgroundColor: _primary.withValues(alpha: 0.15),
                      child: Icon(edu['icon'] as IconData, color: _primary, size: 20),
                    ),
                    title: Text(
                      edu['title'] as String,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: _textMain,
                      ),
                    ),
                    subtitle: Text(
                      '${edu['institution']}\n${edu['duration']}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _textSub,
                        height: 1.3,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Text(
                          edu['description'] as String,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: _textSub,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        // Licenses & Professional Certifications (From CV)
        _buildSectionCard(
          title: 'Licenses & Professional Certifications',
          icon: Icons.workspace_premium_outlined,
          child: Column(
            children: certifications.map((cert) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _bgScreen,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _borderSubtle),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: _primary.withValues(alpha: 0.12),
                      child: Icon(cert['icon'] as IconData, color: _primary, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cert['title'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _textMain,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            cert['issuer'] as String,
                            style: const TextStyle(fontSize: 11.5, color: _textSub),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        cert['date'] as String,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: _primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Technical Skills Matrix (Categorized directly from CV)
        _buildSectionCard(
          title: 'Technical Skills Matrix',
          icon: Icons.terminal_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkillCategory(
                category: 'Programming Languages',
                skills: ['JavaScript', 'Python', 'C', 'HTML5', 'CSS3', 'SQL'],
                chipColor: const Color(0xFF6366F1),
              ),
              const SizedBox(height: 12),
              _buildSkillCategory(
                category: 'Frontend Development',
                skills: [
                  'React.js',
                  'Responsive Web Design',
                  'DOM Manipulation',
                  'Asynchronous Programming (Promises, async/await)',
                  'Cross-Browser Compatibility',
                  'Flutter & Dart',
                ],
                chipColor: const Color(0xFF0EA5E9),
              ),
              const SizedBox(height: 12),
              _buildSkillCategory(
                category: 'Backend & Microservices',
                skills: [
                  'FastAPI',
                  'Uvicorn',
                  'Pydantic',
                  'RESTful API Architecture',
                  'JSON Data Pipelines',
                ],
                chipColor: const Color(0xFF10B981),
              ),
              const SizedBox(height: 12),
              _buildSkillCategory(
                category: 'Embedded Systems & IoT',
                skills: [
                  'Embedded C Programming',
                  'Microchip Studio',
                  'Proteus Design Suite',
                  'Microcontroller Interfacing',
                  'Circuit Simulation',
                ],
                chipColor: const Color(0xFFF59E0B),
              ),
              const SizedBox(height: 12),
              _buildSkillCategory(
                category: 'Developer Tools & Environments',
                skills: ['Git', 'GitHub', 'VS Code', 'Chrome DevTools', 'Postman', 'Figma'],
                chipColor: const Color(0xFF8B5CF6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Soft Skills (From CV)
        _buildSectionCard(
          title: 'Soft Skills & Competencies',
          icon: Icons.diversity_3_outlined,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: softSkills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _primary.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 15, color: _primary),
                    const SizedBox(width: 6),
                    Text(
                      skill,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryDark,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ═════════════════════════════════════════════════════════════════════════
  // TAB 3: Projects Experience & Extracurricular Achievements (From CV)
  // ═════════════════════════════════════════════════════════════════════════
  Widget _buildProjectsAndAchievementsTab() {
    final cvProjects = [
      {
        'title': 'Asvanna – Agricultural Market Intelligence & Zero-Waste Platform',
        'role': 'UI/UX Designer, Web Developer & QA Tester',
        'tools': 'JavaScript, React.js, HTML5, CSS3, Figma, Chrome DevTools',
        'methods': 'UI/UX Architecture, Frontend Web Development, Component Reusability, Responsive Design',
        'points': [
          'Spearheaded core UI/UX architecture in Figma from wireframing to high-fidelity prototypes, creating an intuitive journey for an agricultural market platform.',
          'Developed modular, accessible frontend components in React.js, integrating dynamic state management and client-side form validations.',
          'Executed comprehensive Quality Assurance testing across responsive viewports, identifying regressions and optimizing load performance.',
        ],
        'link': 'https://github.com/asvanna123/asvanna123',
        'icon': Icons.eco_outlined,
        'image': 'assets/jayampathi/images/project/asvanna.jpg',
      },
      {
        'title': 'AI Feedback Sentiment Analysis Microservice',
        'role': 'Backend & API Developer',
        'tools': 'Python, NLTK (VADER), FastAPI, Pydantic, Uvicorn, RESTful API',
        'methods': 'REST API Design, Microservice Architecture, Asynchronous Execution, JSON Schema Validation',
        'points': [
          'Engineered an asynchronous NLP microservice in Python to process textual customer reviews and compute compound polarity sentiment metrics.',
          'Architected high-speed RESTful API endpoints using FastAPI and Pydantic validation schemas, enabling seamless backend integration and low-latency inference.',
        ],
        'link': 'https://github.com/Tharaka-Jayampathi',
        'icon': Icons.rate_review_rounded,
        'image': 'assets/jayampathi/images/project/ai-sentiment-analysis.jpg',
      },
      {
        'title': 'TeamConnect – Mobile Group Profile Application',
        'role': 'Mobile App Developer (Member 6)',
        'tools': 'Flutter, Dart, Firebase Authentication, Material 3 Design',
        'methods': 'Mobile UI/UX Architecture, State Management, Responsive Design, Firebase Auth',
        'points': [
          'Developed responsive cross-platform group profile application for NDT IT students at ITUM under Mobile Communication CA02.',
          'Engineered unique individual member screen with custom reactive components, copy-to-clipboard integration, and full-screen dialog features.',
        ],
        'link': 'https://github.com/reezmahanan/TeamConnect',
        'icon': Icons.phone_android_rounded,
        'image': 'assets/jayampathi/images/project/TeamConnect.png',
      },
      {
        'title': 'Real-Time Weather Dashboard',
        'role': 'Web Developer',
        'tools': 'JavaScript, RESTful APIs, JSON, HTML5, CSS3',
        'methods': 'Web Application, External API Integration, Asynchronous Programming (Fetch, Promises)',
        'points': [
          'Built an interactive weather dashboard consuming third-party RESTful APIs to dynamically display real-time meteorological metrics.',
          'Utilized asynchronous JavaScript (async/await) with robust error handling for API rate limits and network latency without page reloads.',
        ],
        'link': 'https://github.com/Tharaka-Jayampathi',
        'icon': Icons.cloud_sync_rounded,
        'image': 'assets/jayampathi/images/project/weather-dashboard.jpg',
      },
      {
        'title': 'Order and Billing Management System',
        'role': 'Frontend & Logic Developer',
        'tools': 'JavaScript, HTML5, CSS3, DOM Manipulation',
        'methods': 'Frontend Development, Transaction Logic, DOM Optimization, Tabular Data Management',
        'points': [
          'Developed an order and billing management application utilizing vanilla JavaScript to streamline daily transactions and inventory tracking.',
          'Implemented dynamic calculation engines to automatically compute cart sub-totals, tiered discounts, and net taxes across batched orders.',
        ],
        'link': 'https://github.com/Tharaka-Jayampathi',
        'icon': Icons.receipt_long_rounded,
        'image': 'assets/jayampathi/images/project/Order and Billing.png',
      },
      {
        'title': 'Smart Home Automation System',
        'role': 'Embedded Systems & Hardware Developer',
        'tools': 'C, Microchip Studio, Proteus Design Suite, Microcontrollers',
        'methods': 'Embedded C Programming, Circuit Simulation, Hardware-Software Interfacing, IoT',
        'points': [
          'Engineered a smart home automation prototype utilizing C programming and microcontrollers for real-time hardware-software interfacing.',
          'Simulated and verified complete circuit architectures using Proteus Design Suite before physical implementation, ensuring fault-tolerant execution.',
        ],
        'link': 'https://github.com/Tharaka-Jayampathi',
        'icon': Icons.home_max_rounded,
        'image': 'assets/jayampathi/images/project/smart-home-automation.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Experience Cards (Directly matching CV Page 2)
        _buildSectionCard(
          title: 'Project Experience',
          icon: Icons.code_rounded,
          child: Column(
            children: List.generate(cvProjects.length, (index) {
              final proj = cvProjects[index];
              final isExpanded = _expandedProjectIndex == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isExpanded ? _primaryLight.withValues(alpha: 0.3) : _bgScreen,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isExpanded ? _primary.withValues(alpha: 0.4) : _borderSubtle,
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedProjectIndex = expanded ? index : null;
                      });
                    },
                    leading: GestureDetector(
                      onTap: proj['image'] != null
                          ? () => _showFullProjectImage(
                                proj['image'] as String,
                                proj['title'] as String,
                              )
                          : null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 44,
                          height: 44,
                          color: _primary.withValues(alpha: 0.1),
                          child: proj['image'] != null
                              ? Image.asset(
                                  proj['image'] as String,
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Center(
                                    child: Icon(proj['icon'] as IconData, color: _primary, size: 20),
                                  ),
                                )
                              : Center(
                                  child: Icon(proj['icon'] as IconData, color: _primary, size: 20),
                                ),
                        ),
                      ),
                    ),
                    title: Text(
                      proj['title'] as String,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: _textMain,
                      ),
                    ),
                    subtitle: Text(
                      'Role: ${proj['role']}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Languages & Tools: ${proj['tools']}',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: _textMain,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Core & Methods: ${proj['methods']}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: _textSub,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...((proj['points'] as List<String>).map((point) {
                              return _buildBulletPoint(point);
                            })),
                            if (proj['link'] != null) ...[
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => _openExternalLink(proj['link'] as String),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _primary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: _primary.withValues(alpha: 0.25)),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.open_in_new, size: 14, color: _primary),
                                      SizedBox(width: 6),
                                      Text(
                                        'View Project Repository',
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: _primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        // Extracurricular Achievements (From CV Page 2)
        _buildSectionCard(
          title: 'Extracurricular Achievements',
          icon: Icons.emoji_events_outlined,
          child: Column(
            children: [
              // Sports
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _bgScreen,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _borderSubtle),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _accentRose.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.sports_score_rounded, color: _accentRose, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sports & Athletics – University of Moratuwa',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _textMain,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Represented the University of Moratuwa in Women\'s Athletics at the Sri Lankan University Games 2025 (SLUG 2025). Exhibited elite dedication, resilience, and high-performance teamwork.',
                            style: TextStyle(
                              fontSize: 12,
                              color: _textSub,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ZeroPlastic Movement
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _bgScreen,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _borderSubtle),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.park_outlined, color: Color(0xFF10B981), size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ZeroPlastic Movement & ZeroPlastic NDT Club',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _textMain,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '• Organizing Committee Member (Pure Path\'26): Received an Official Letter of Appreciation for leading campus-wide environmental stewardship initiatives and logistics.\n'
                            '• Participant (ZeroPlastic TRAIL\'26): Contributed to nationwide sustainability and environmental impact campaigns.',
                            style: TextStyle(
                              fontSize: 12,
                              color: _textSub,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Reusable UI Helpers ────────────────────────────────────────────────
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return _HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: _primary, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: _textMain,
                  ),
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

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onCopy,
    VoidCallback? onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _primary, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: _textMuted,
                ),
              ),
              const SizedBox(height: 3),
              InkWell(
                onTap: onTap ?? onCopy,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: onTap != null ? _primary : _textMain,
                    decoration: onTap != null ? TextDecoration.underline : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (onCopy != null)
          IconButton(
            icon: const Icon(Icons.copy_rounded, size: 16, color: _textMuted),
            tooltip: 'Copy',
            onPressed: onCopy,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(4),
          ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: _primary, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: _textSub, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSkillCategory({
    required String category,
    required List<String> skills,
    required Color chipColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: _textMain,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: skills.map((s) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: chipColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: chipColor.withValues(alpha: 0.25)),
              ),
              child: Text(
                s,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: chipColor.withValues(alpha: 0.95),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return _HoverCard(
      onTap: onTap,
      borderRadius: 14,
      padding: const EdgeInsets.all(12),
      backgroundColor: _bgScreen,
      liftDistance: 3,
      border: Border.all(color: _borderSubtle),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _textMain),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10.5, color: _textSub),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Footer Appreciation Card ──────────────────────────────────────────
  Widget _buildFooterAppreciationCard() {
    final String labelText = _hasAppreciated
        ? 'Appreciated ($_appreciationCount)'
        : 'Appreciate Profile ($_appreciationCount)';

    return _HoverCard(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      liftDistance: 3,
      backgroundColor: Colors.transparent,
      border: Border.all(color: _primary.withValues(alpha: 0.2)),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_primaryLight, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Text(
              'Appreciate Member Profile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _textMain,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Thank you for viewing Tharaka Jayampathi’s profile. '
              'Leave a reaction to support my work in Continuous Assessment 02!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: _textSub,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _hasAppreciated ? _accentRose : _primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
              ),
              onPressed: () {
                setState(() {
                  _hasAppreciated = !_hasAppreciated;
                  if (_hasAppreciated) {
                    _appreciationCount++;
                  } else {
                    _appreciationCount--;
                  }
                });
                _showToast(
                  _hasAppreciated
                      ? 'Thank you for your appreciation! ❤️'
                      : 'Appreciation removed',
                );
              },
              icon: Icon(
                _hasAppreciated ? Icons.favorite : Icons.favorite_border,
                size: 18,
              ),
              label: Text(
                labelText,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Smooth Interactive Hover Card Widget ─────────────────────────────────
class _HoverCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Border? border;
  final VoidCallback? onTap;
  final double liftDistance;

  const _HoverCard({
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(18),
    this.margin,
    this.backgroundColor = Colors.white,
    this.border,
    this.onTap,
    this.liftDistance = 4.0,
  });

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -widget.liftDistance, 0.0))
              : Matrix4.identity(),
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: widget.border ??
                Border.all(
                  color: _isHovered
                      ? const Color(0xFF4F46E5).withValues(alpha: 0.35)
                      : const Color(0xFFE2E8F0),
                  width: _isHovered ? 1.4 : 1.0,
                ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF4F46E5).withValues(alpha: 0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
