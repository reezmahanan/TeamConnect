import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Individual Profile Screen for Member 7: Ms W D C G Jayarathna (23IT0488)
/// Developed for ITUM Mobile Communication Continuous Assessment 02 (TeamConnect).
class Member7Screen extends StatefulWidget {
  const Member7Screen({super.key});

  @override
  State<Member7Screen> createState() => _Member7ScreenState();
}

class _Member7ScreenState extends State<Member7Screen> {
  // ─── Interactive State Variables ─────────────────────────────────────────
  int _selectedTabIndex = 0;
  String _selectedSkillCategory = 'All';
  int? _expandedProjectIndex;
  bool _isLiked = false;
  int _likeCount = 48;

  // ─── Theme Palette: Royal Indigo & Rose Coral ────────────────────────────
  // Uniquely crafted for Member 7 (distinct from Teal, Deep Navy, and Forest Green)
  static const Color _primaryIndigo = Color(0xFF4338CA);
  static const Color _deepIndigo = Color(0xFF312E81);
  static const Color _vibrantRose = Color(0xFFE11D48);
  static const Color _softRose = Color(0xFFFDA4AF);
  static const Color _roseSurface = Color(0xFFFFF1F2);
  static const Color _surfaceBg = Color(0xFFF8FAFC);
  static const Color _cardBg = Colors.white;
  static const Color _textPrimary = Color(0xFF0F172A);
  static const Color _textSecondary = Color(0xFF475569);
  static const Color _textMuted = Color(0xFF94A3B8);
  static const Color _borderColor = Color(0xFFE2E8F0);

  // ─── Personal Data ───────────────────────────────────────────────────────
  static const String _name = 'Ms W D C G Jayarathna';
  static const String _preferredName = 'Gimhani Jayarathna';
  static const String _regNumber = '23IT0488';
  static const String _division = 'Division of Information Technology';
  static const String _institute = 'Institute of Technology, University of Moratuwa';
  static const String _email = 'wdcgjayarathna@gmail.com';
  static const String _location = 'Diyagama, Homagama, Sri Lanka';
  static const String _githubUrl = 'https://github.com/Gimhani-00';
  static const String _photoAssetPath = 'lib/assets/images/Gimhani.jpg';

  final List<String> _tabs = const [
    'Overview',
    'Skills',
    'Projects',
    'Qualifications',
  ];

  // ─── External URL Launcher Helper ────────────────────────────────────────
  Future<void> _launchUrlHelper(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _showSnackBar('Could not launch: $url');
      }
    } catch (_) {
      _showSnackBar('Unable to open link');
    }
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('$label copied to clipboard!');
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: _deepIndigo,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─── Photo Preview Dialog ────────────────────────────────────────────────
  void _openPhotoDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 420, maxHeight: 520),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: InteractiveViewer(
                minScale: 0.8,
                maxScale: 3.5,
                child: Image.asset(
                  _photoAssetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: _deepIndigo,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 56,
                          backgroundColor: _vibrantRose,
                          child: Text(
                            'GJ',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          _preferredName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          _regNumber,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surfaceBg,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildQuickActionCard(),
                      const SizedBox(height: 20),
                      _buildInteractiveTabs(),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        child: _buildCurrentTabContent(),
                      ),
                      const SizedBox(height: 36),
                      _buildFooter(),
                      const SizedBox(height: 16),
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

  // ─── Sliver App Bar with Gradient Header ─────────────────────────────────
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      elevation: 0,
      backgroundColor: _deepIndigo,
      foregroundColor: Colors.white,
      title: const Text(
        'Profile • 23IT0488',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      actions: [
        IconButton(
          tooltip: _isLiked ? 'Liked' : 'Like Profile',
          icon: Icon(
            _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: _isLiked ? _vibrantRose : Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isLiked = !_isLiked;
              _likeCount += _isLiked ? 1 : -1;
            });
            _showSnackBar(_isLiked ? 'Profile saved to favorites!' : 'Unfavorited');
          },
        ),
        IconButton(
          tooltip: 'Copy Email',
          icon: const Icon(Icons.share_rounded),
          onPressed: () => _copyToClipboard(_email, 'Email address'),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_deepIndigo, _primaryIndigo, Color(0xFF6366F1), _vibrantRose],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.45, 0.75, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _openPhotoDialog,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.white24,
                          child: ClipOval(
                            child: Image.asset(
                              _photoAssetPath,
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: _deepIndigo,
                                alignment: Alignment.center,
                                child: const Text(
                                  'GJ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: _vibrantRose,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.zoom_in_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  _name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: const Text(
                    '$_regNumber  •  NDT Information Technology',
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

  // ─── Quick Actions & Bio Highlight Card ──────────────────────────────────
  Widget _buildQuickActionCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: _primaryIndigo.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.school_rounded,
                  label: 'Institute',
                  value: 'ITUM',
                  color: _primaryIndigo,
                ),
              ),
              Container(width: 1, height: 42, color: _borderColor),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.code_rounded,
                  label: 'Specialty',
                  value: 'Flutter & UI',
                  color: _vibrantRose,
                ),
              ),
              Container(width: 1, height: 42, color: _borderColor),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.favorite_rounded,
                  label: 'Appreciations',
                  value: '$_likeCount',
                  color: Colors.amber.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: _borderColor),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _buildActionButton(
                icon: Icons.email_outlined,
                label: 'Email Me',
                primary: true,
                onPressed: () => _launchUrlHelper('mailto:$_email'),
              ),
              _buildActionButton(
                icon: Icons.code_rounded,
                label: 'GitHub Profile',
                primary: false,
                onPressed: () => _launchUrlHelper(_githubUrl),
              ),
              _buildActionButton(
                icon: Icons.content_copy_rounded,
                label: 'Copy Reg No',
                primary: false,
                onPressed: () => _copyToClipboard(_regNumber, 'Registration Number'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: _textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool primary,
    required VoidCallback onPressed,
  }) {
    if (primary) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryIndigo,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      );
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryIndigo,
        side: const BorderSide(color: Color(0xFFC7D2FE)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  // ─── Interactive Tab Bar ─────────────────────────────────────────────────
  Widget _buildInteractiveTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 450;
          return Row(
            children: List.generate(_tabs.length, (index) {
              final isSelected = _selectedTabIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      vertical: isNarrow ? 9 : 11,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? _cardBg : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      _tabs[index],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isNarrow ? 11.5 : 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        color: isSelected ? _primaryIndigo : _textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  // ─── Tab Content Switcher ────────────────────────────────────────────────
  Widget _buildCurrentTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildSkillsTab();
      case 2:
        return _buildProjectsTab();
      case 3:
        return _buildQualificationsTab();
      default:
        return const SizedBox.shrink();
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB 1: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildOverviewTab() {
    return Column(
      key: const ValueKey('tab_overview'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // About Section
        _buildSectionCard(
          title: 'About Me',
          icon: Icons.person_outline_rounded,
          accentColor: _primaryIndigo,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'I am an enthusiastic Information Technology undergraduate at the Institute of Technology, '
                'University of Moratuwa (ITUM). Passionate about mobile application engineering, UI/UX '
                'design, and crafting intuitive, responsive user experiences with Flutter and modern software practices.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: _textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTagBadge('NDT IT Student', _primaryIndigo),
                  _buildTagBadge('Flutter Developer', _vibrantRose),
                  _buildTagBadge('UI/UX Enthusiast', const Color(0xFF0D9488)),
                  _buildTagBadge('Collaborative Team Member', const Color(0xFFEA580C)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Personal Contact & Academic Details Card
        _buildSectionCard(
          title: 'Personal & Academic Details',
          icon: Icons.contact_page_outlined,
          accentColor: _vibrantRose,
          child: Column(
            children: [
              _buildInfoRow(
                icon: Icons.badge_outlined,
                title: 'Full Name',
                value: _name,
              ),
              const Divider(color: _borderColor, height: 20),
              _buildInfoRow(
                icon: Icons.tag_rounded,
                title: 'Registration Number',
                value: _regNumber,
              ),
              const Divider(color: _borderColor, height: 20),
              _buildInfoRow(
                icon: Icons.apartment_rounded,
                title: 'Division',
                value: _division,
              ),
              const Divider(color: _borderColor, height: 20),
              _buildInfoRow(
                icon: Icons.account_balance_rounded,
                title: 'Institute',
                value: _institute,
              ),
              const Divider(color: _borderColor, height: 20),
              _buildInfoRow(
                icon: Icons.email_outlined,
                title: 'Email Address',
                value: _email,
                isAction: true,
                onTap: () => _launchUrlHelper('mailto:$_email'),
              ),
              const Divider(color: _borderColor, height: 20),
              _buildInfoRow(
                icon: Icons.location_on_outlined,
                title: 'Address / Location',
                value: _location,
              ),
              const Divider(color: _borderColor, height: 20),
              _buildInfoRow(
                icon: Icons.link_rounded,
                title: 'GitHub Profile',
                value: _githubUrl,
                isAction: true,
                onTap: () => _launchUrlHelper(_githubUrl),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Special Talents Section
        _buildSectionCard(
          title: 'Special Talents & Strengths',
          icon: Icons.auto_awesome_rounded,
          accentColor: Colors.amber.shade700,
          child: Column(
            children: [
              _buildTalentItem(
                icon: Icons.design_services_rounded,
                title: 'UI/UX & Interactive Design',
                description:
                    'Skilled in designing intuitive wireframes, responsive UI prototypes in Figma, and translating design concepts into pixel-perfect Flutter widgets.',
                color: _vibrantRose,
              ),
              const SizedBox(height: 12),
              _buildTalentItem(
                icon: Icons.palette_outlined,
                title: 'Creative Presentation & Visual Structuring',
                description:
                    'Strong flair for typography, harmonious color schemes, and aesthetic information hierarchy in mobile applications and documentation.',
                color: _primaryIndigo,
              ),
              const SizedBox(height: 12),
              _buildTalentItem(
                icon: Icons.groups_rounded,
                title: 'Collaborative Problem Resolution',
                description:
                    'Exceptional team communication, constructive code review capabilities, and active contributions towards shared group milestones.',
                color: const Color(0xFF0D9488),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB 2: SKILLS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSkillsTab() {
    final categories = ['All', 'Technical', 'Soft Skills', 'Tools'];

    final allSkills = [
      _SkillData('Flutter & Dart', 'Technical', 0.88, Icons.phone_android_rounded, _primaryIndigo),
      _SkillData('Java (OOP & Core)', 'Technical', 0.80, Icons.coffee_rounded, const Color(0xFFD97706)),
      _SkillData('Python Programming', 'Technical', 0.78, Icons.terminal_rounded, const Color(0xFF0284C7)),
      _SkillData('HTML5 / CSS3 & Web', 'Technical', 0.85, Icons.html_rounded, const Color(0xFFEA580C)),
      _SkillData('SQL & Relational DBs', 'Technical', 0.75, Icons.storage_rounded, const Color(0xFF475569)),
      _SkillData('Firebase Authentication', 'Technical', 0.82, Icons.local_fire_department_rounded, _vibrantRose),
      _SkillData('Effective Communication', 'Soft Skills', 0.92, Icons.record_voice_over_rounded, const Color(0xFF0D9488)),
      _SkillData('Team Leadership & Synergy', 'Soft Skills', 0.90, Icons.groups_rounded, _primaryIndigo),
      _SkillData('Problem Solving', 'Soft Skills', 0.86, Icons.psychology_rounded, _vibrantRose),
      _SkillData('Time Management', 'Soft Skills', 0.88, Icons.timer_outlined, Colors.amber.shade800),
      _SkillData('Adaptability', 'Soft Skills', 0.90, Icons.sync_alt_rounded, const Color(0xFF6366F1)),
      _SkillData('Git & GitHub Version Control', 'Tools', 0.85, Icons.alt_route_rounded, const Color(0xFF1E293B)),
      _SkillData('Figma UI/UX Prototyping', 'Tools', 0.88, Icons.polyline_rounded, const Color(0xFF9333EA)),
      _SkillData('VS Code & Android Studio', 'Tools', 0.90, Icons.laptop_chromebook_rounded, const Color(0xFF2563EB)),
    ];

    final filteredSkills = _selectedSkillCategory == 'All'
        ? allSkills
        : allSkills.where((s) => s.category == _selectedSkillCategory).toList();

    return Column(
      key: const ValueKey('tab_skills'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Category Filter Chips (Interactive State Demonstration)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.filter_list_rounded, size: 18, color: _primaryIndigo),
                  SizedBox(width: 8),
                  Text(
                    'Filter Category',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((cat) {
                  final isSelected = _selectedSkillCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedSkillCategory = cat;
                        });
                      }
                    },
                    selectedColor: _primaryIndigo,
                    backgroundColor: _surfaceBg,
                    labelStyle: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : _textSecondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? _primaryIndigo : _borderColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Skill list
        _buildSectionCard(
          title: '$_selectedSkillCategory Skills (${filteredSkills.length})',
          icon: Icons.assessment_outlined,
          accentColor: _primaryIndigo,
          child: Column(
            children: filteredSkills.map((skill) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: skill.color.withValues(alpha: 0.12),
                          child: Icon(skill.icon, size: 16, color: skill.color),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            skill.name,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: skill.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${(skill.proficiency * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: skill.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: skill.proficiency,
                        minHeight: 7,
                        backgroundColor: const Color(0xFFF1F5F9),
                        valueColor: AlwaysStoppedAnimation<Color>(skill.color),
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

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB 3: PROJECTS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildProjectsTab() {
    final projects = [
      _ProjectData(
        title: 'TeamConnect – Group Profile Application',
        role: 'Member 7 Profile & UI Component Developer',
        duration: 'November 2026',
        description:
            'A responsive cross-platform Flutter application for nine NDT IT students at ITUM featuring Firebase Authentication, member directory navigation, and personalized member profile experiences.',
        technologies: ['Flutter', 'Dart', 'Firebase Auth', 'Material 3', 'StatefulWidget'],
        highlights: [
          'Engineered individual Member 7 profile screen with custom interactive state architecture.',
          'Built responsive SliverAppBar header with real-time like metrics and zoomable profile viewer.',
          'Implemented category-based dynamic skill filtering using StatefulWidget and setState().',
          'Enforced clean code quality adhering strictly to dart format and flutter analyze guidelines.',
        ],
        githubRepo: _githubUrl,
      ),
      _ProjectData(
        title: 'TaskPulse – Smart Task & Workflow Manager',
        role: 'Lead Mobile Developer',
        duration: 'August 2026',
        description:
            'A high-performance personal task planner enabling students to manage academic assignments, organize deadlines by priority, and track daily progress.',
        technologies: ['Flutter', 'Dart', 'SQLite', 'Local Notifications', 'Figma'],
        highlights: [
          'Implemented local offline-first persistence with SQLite and state management.',
          'Created scheduled deadline notification triggers for upcoming coursework milestones.',
          'Designed complete user experience journey and interactive components in Figma.',
        ],
        githubRepo: _githubUrl,
      ),
      _ProjectData(
        title: 'CampusConnect – Student Resource Portal',
        role: 'Frontend & UI Developer',
        duration: 'May 2026',
        description:
            'A centralized student portal interface for academic announcements, lecture timetable views, and downloadable study resources.',
        technologies: ['Flutter Web', 'REST APIs', 'Cloud Firestore', 'Git'],
        highlights: [
          'Developed responsive multi-column layouts adapting seamlessly from mobile to desktop browsers.',
          'Integrated Firestore real-time notice feeds with search and category tags.',
          'Coordinated version control branching and pull requests on GitHub.',
        ],
        githubRepo: _githubUrl,
      ),
    ];

    return Column(
      key: const ValueKey('tab_projects'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Tap any project to view architecture highlights & key contributions.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        ...List.generate(projects.length, (index) {
          final project = projects[index];
          final isExpanded = _expandedProjectIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isExpanded ? _primaryIndigo : _borderColor,
                width: isExpanded ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isExpanded
                      ? _primaryIndigo.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  setState(() {
                    _expandedProjectIndex = isExpanded ? null : index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isExpanded
                                  ? _primaryIndigo
                                  : _primaryIndigo.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.folder_special_rounded,
                              color: isExpanded ? Colors.white : _primaryIndigo,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: _textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${project.role}  •  ${project.duration}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
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
                      const SizedBox(height: 12),
                      Text(
                        project.description,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: _textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: project.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: _roseSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _softRose.withValues(alpha: 0.5)),
                            ),
                            child: Text(
                              tech,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _vibrantRose,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 14),
                        const Divider(color: _borderColor),
                        const SizedBox(height: 10),
                        const Text(
                          'Key Contributions & Architecture:',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: _textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...project.highlights.map((h) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 15,
                                    color: _primaryIndigo,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      h,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        height: 1.4,
                                        color: _textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => _launchUrlHelper(project.githubRepo),
                            icon: const Icon(Icons.open_in_new_rounded, size: 15),
                            label: const Text('View on GitHub'),
                            style: TextButton.styleFrom(
                              foregroundColor: _primaryIndigo,
                              textStyle: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB 4: QUALIFICATIONS & ABOUT
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildQualificationsTab() {
    return Column(
      key: const ValueKey('tab_qualifications'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Academic Education Timeline Card
        _buildSectionCard(
          title: 'Academic Qualifications',
          icon: Icons.school_rounded,
          accentColor: _primaryIndigo,
          child: Column(
            children: [
              _buildEducationItem(
                institution: 'Institute of Technology, University of Moratuwa (ITUM)',
                qualification: 'National Diploma in Technology (NDT) in Information Technology',
                period: '2023 – Present',
                status: 'Undergraduate',
                isCurrent: true,
              ),
              const SizedBox(height: 16),
              _buildEducationItem(
                institution: 'Ministry of Education, Sri Lanka',
                qualification: 'G.C.E. Advanced Level (A/L) Examination',
                period: 'Physical Science / Technology Stream',
                status: 'Completed',
                isCurrent: false,
              ),
              const SizedBox(height: 16),
              _buildEducationItem(
                institution: 'Ministry of Education, Sri Lanka',
                qualification: 'G.C.E. Ordinary Level (O/L) Examination',
                period: 'Passed with Distinction Results',
                status: 'Completed',
                isCurrent: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Professional Certifications
        _buildSectionCard(
          title: 'Certifications & Training',
          icon: Icons.workspace_premium_rounded,
          accentColor: _vibrantRose,
          child: Column(
            children: [
              _buildCertItem(
                title: 'Python Programming Essentials',
                issuer: 'Online Learning Initiative',
                year: '2025',
              ),
              const SizedBox(height: 10),
              _buildCertItem(
                title: 'UI/UX Design Fundamentals with Figma',
                issuer: 'Digital Skills Showcase',
                year: '2025',
              ),
              const SizedBox(height: 10),
              _buildCertItem(
                title: 'Version Control with Git and GitHub',
                issuer: 'ITUM Practical Workshop',
                year: '2024',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Hobbies and Interests Card
        _buildSectionCard(
          title: 'Hobbies & Personal Interests',
          icon: Icons.interests_rounded,
          accentColor: const Color(0xFF0D9488),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInterestChip(Icons.smartphone_rounded, 'Mobile App Building'),
              _buildInterestChip(Icons.brush_rounded, 'UI/UX Prototyping'),
              _buildInterestChip(Icons.menu_book_rounded, 'Reading Tech Articles'),
              _buildInterestChip(Icons.sports_tennis_rounded, 'Badminton'),
              _buildInterestChip(Icons.travel_explore_rounded, 'Exploring Open-Source'),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Shared UI Component Builders ─────────────────────────────────────────
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color accentColor,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                    letterSpacing: -0.2,
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

  Widget _buildTagBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool isAction = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: _primaryIndigo),
            const SizedBox(width: 12),
            SizedBox(
              width: 140,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: _textSecondary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isAction ? _primaryIndigo : _textPrimary,
                  decoration: isAction ? TextDecoration.underline : null,
                ),
              ),
            ),
            if (isAction) ...[
              const SizedBox(width: 4),
              const Icon(Icons.open_in_new_rounded, size: 14, color: _primaryIndigo),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTalentItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem({
    required String institution,
    required String qualification,
    required String period,
    required String status,
    required bool isCurrent,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCurrent ? _primaryIndigo.withValues(alpha: 0.4) : _borderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCurrent ? _primaryIndigo : Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.school, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  qualification,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  institution,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isCurrent
                  ? _primaryIndigo.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                color: isCurrent ? _primaryIndigo : _textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertItem({
    required String title,
    required String issuer,
    required String year,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surfaceBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_rounded, size: 20, color: _vibrantRose),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                Text(
                  issuer,
                  style: const TextStyle(fontSize: 11.5, color: _textSecondary),
                ),
              ],
            ),
          ),
          Text(
            year,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: _textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: _primaryIndigo),
      label: Text(label),
      backgroundColor: _surfaceBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: _borderColor),
      ),
      labelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _textPrimary,
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Text(
          'TeamConnect • CA02 Group Profile Application',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'National Diploma in Technology (NDT) | ITUM 2026',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

// ─── Data Helper Models ──────────────────────────────────────────────────────
class _SkillData {
  _SkillData(this.name, this.category, this.proficiency, this.icon, this.color);
  final String name;
  final String category;
  final double proficiency;
  final IconData icon;
  final Color color;
}

class _ProjectData {
  _ProjectData({
    required this.title,
    required this.role,
    required this.duration,
    required this.description,
    required this.technologies,
    required this.highlights,
    required this.githubRepo,
  });

  final String title;
  final String role;
  final String duration;
  final String description;
  final List<String> technologies;
  final List<String> highlights;
  final String githubRepo;
}
