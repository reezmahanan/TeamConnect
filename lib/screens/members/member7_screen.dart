import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Individual Profile Screen for Member 7: Ms W D C G Jayarathna (23IT0488)
/// Tailored with authentic career profile: Network Engineer (Intern) & IT Diploma Student at ITUM.
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
  int _likeCount = 52;

  // ─── Theme Palette: Network Tech Indigo & Rose Coral ─────────────────────
  static const Color _primaryIndigo = Color(0xFF4338CA);
  static const Color _deepIndigo = Color(0xFF1E1B4B);
  static const Color _vibrantRose = Color(0xFFE11D48);
  static const Color _softRose = Color(0xFFFDA4AF);
  static const Color _roseSurface = Color(0xFFFFF1F2);
  static const Color _surfaceBg = Color(0xFFF8FAFC);
  static const Color _cardBg = Colors.white;
  static const Color _textPrimary = Color(0xFF0F172A);
  static const Color _textSecondary = Color(0xFF475569);
  static const Color _textMuted = Color(0xFF94A3B8);
  static const Color _borderColor = Color(0xFFE2E8F0);

  // ─── Personal & Career Data (From Official Resume) ───────────────────────
  static const String _name = 'Ms W D C G Jayarathna';
  static const String _preferredName = 'Gimhani Jayarathna';
  static const String _regNumber = '23IT0488';
  static const String _roleTitle = 'Network Engineer (Intern)';
  static const String _division = 'Division of Information Technology';
  static const String _institute = 'Institute of Technology, University of Moratuwa (ITUM)';
  static const String _email = 'wdcgjayarathna@gmail.com';
  static const String _phone = '+94 74 112 9244';
  static const String _location = 'Anuradhapura, Sri Lanka';
  static const String _linkedinUrl = 'https://linkedin.com/in/Gimhani-Jayarathna';
  static const String _githubUrl = 'https://github.com/Gimhani-00';
  static const String _photoAssetPath = 'lib/assets/images/Gimhani.jpg';

  static const String _summary =
      'IT Diploma student at ITUM, University of Moratuwa, certified in Cisco CCNA '
      '(Introduction to Networks; Switching, Routing, and Wireless Essentials) and currently '
      'completing ENSA. Proficient in dual-stack (IPv4/IPv6) configuration, VLAN segmentation, '
      'and hardware troubleshooting, seeking a Network Engineer Internship to support reliable '
      'enterprise network operations.';

  final List<String> _tabs = const [
    'Overview',
    'Experience',
    'Skills',
    'Projects',
    'Education & Certs',
  ];

  // ─── Helper Actions ──────────────────────────────────────────────────────
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
                          _roleTitle,
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
                constraints: const BoxConstraints(maxWidth: 880),
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

  // ─── Sliver App Bar ──────────────────────────────────────────────────────
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 290,
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
          tooltip: 'Share Contact',
          icon: const Icon(Icons.share_rounded),
          onPressed: () => _copyToClipboard('$_name | $_email | $_phone', 'Contact Info'),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_deepIndigo, _primaryIndigo, Color(0xFF4F46E5), _vibrantRose],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.45, 0.78, 1.0],
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
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 18,
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
                const SizedBox(height: 10),
                const Text(
                  _preferredName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: const Text(
                    '$_roleTitle  •  ITUM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '$_name  •  $_regNumber',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Quick Actions & Highlights ──────────────────────────────────────────
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
                  icon: Icons.router_rounded,
                  label: 'Domain',
                  value: 'Networking',
                  color: _primaryIndigo,
                ),
              ),
              Container(width: 1, height: 42, color: _borderColor),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.verified_rounded,
                  label: 'Cisco CCNA',
                  value: 'Certified',
                  color: _vibrantRose,
                ),
              ),
              Container(width: 1, height: 42, color: _borderColor),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.business_center_rounded,
                  label: 'Experience',
                  value: 'Metropolitan',
                  color: const Color(0xFF0D9488),
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
                label: 'Email',
                primary: true,
                onPressed: () => _launchUrlHelper('mailto:$_email'),
              ),
              _buildActionButton(
                icon: Icons.phone_outlined,
                label: 'Call',
                primary: false,
                onPressed: () => _launchUrlHelper('tel:$_phone'),
              ),
              _buildActionButton(
                icon: Icons.link_rounded,
                label: 'LinkedIn',
                primary: false,
                onPressed: () => _launchUrlHelper(_linkedinUrl),
              ),
              _buildActionButton(
                icon: Icons.code_rounded,
                label: 'GitHub',
                primary: false,
                onPressed: () => _launchUrlHelper(_githubUrl),
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
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
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
          final isNarrow = constraints.maxWidth < 600;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedTabIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: isNarrow ? 14 : 18,
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
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? _primaryIndigo : _textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
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
        return _buildExperienceTab();
      case 2:
        return _buildSkillsTab();
      case 3:
        return _buildProjectsTab();
      case 4:
        return _buildEducationAndCertsTab();
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
        // Professional Summary Card
        _buildSectionCard(
          title: 'Professional Summary',
          icon: Icons.person_outline_rounded,
          accentColor: _primaryIndigo,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                _summary,
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.6,
                  color: _textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTagBadge('Cisco CCNA Certified', _primaryIndigo),
                  _buildTagBadge('IPv4 / IPv6 Dual-Stack', _vibrantRose),
                  _buildTagBadge('VLAN Segmentation', const Color(0xFF0D9488)),
                  _buildTagBadge('Hardware Troubleshooting', const Color(0xFFEA580C)),
                  _buildTagBadge('TeamConnect Member 7', const Color(0xFF6366F1)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Contact Information
        _buildSectionCard(
          title: 'Contact & Student Identification',
          icon: Icons.contact_page_outlined,
          accentColor: _vibrantRose,
          child: Column(
            children: [
              _buildInfoRow(
                icon: Icons.badge_outlined,
                title: 'Full Name',
                value: _name,
              ),
              const Divider(color: _borderColor, height: 18),
              _buildInfoRow(
                icon: Icons.tag_rounded,
                title: 'Registration No.',
                value: _regNumber,
              ),
              const Divider(color: _borderColor, height: 18),
              _buildInfoRow(
                icon: Icons.apartment_rounded,
                title: 'Institute',
                value: _institute,
              ),
              const Divider(color: _borderColor, height: 18),
              _buildInfoRow(
                icon: Icons.email_outlined,
                title: 'Email Address',
                value: _email,
                isAction: true,
                onTap: () => _launchUrlHelper('mailto:$_email'),
              ),
              const Divider(color: _borderColor, height: 18),
              _buildInfoRow(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                value: _phone,
                isAction: true,
                onTap: () => _launchUrlHelper('tel:$_phone'),
              ),
              const Divider(color: _borderColor, height: 18),
              _buildInfoRow(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: _location,
              ),
              const Divider(color: _borderColor, height: 18),
              _buildInfoRow(
                icon: Icons.link_rounded,
                title: 'LinkedIn',
                value: 'linkedin.com/in/Gimhani-Jayarathna',
                isAction: true,
                onTap: () => _launchUrlHelper(_linkedinUrl),
              ),
              const Divider(color: _borderColor, height: 18),
              _buildInfoRow(
                icon: Icons.code_rounded,
                title: 'GitHub',
                value: 'github.com/Gimhani-00',
                isAction: true,
                onTap: () => _launchUrlHelper(_githubUrl),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB 2: EXPERIENCE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildExperienceTab() {
    return Column(
      key: const ValueKey('tab_experience'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          title: 'Work Experience',
          icon: Icons.business_center_rounded,
          accentColor: const Color(0xFF0D9488),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _surfaceBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D9488).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.apartment_rounded,
                        color: Color(0xFF0D9488),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Metropolitan Technologies (Pvt) Ltd',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: _textPrimary,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'IT Intern  •  2024',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0D9488),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Colombo, Sri Lanka',
                            style: TextStyle(
                              fontSize: 12,
                              color: _textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(color: _borderColor),
                const SizedBox(height: 10),
                const Text(
                  'Key Responsibilities & Contributions:',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                _buildBulletPoint(
                  'Handled comprehensive hardware and software installations, operating system provisioning, and routine health checks for enterprise laptops and desktop computers.',
                ),
                const SizedBox(height: 6),
                _buildBulletPoint(
                  'Diagnosed and resolved critical hardware failures, component replacements, driver conflicts, and peripheral connectivity issues.',
                ),
                const SizedBox(height: 6),
                _buildBulletPoint(
                  'Prepared formal IT requirement technical specifications, documentation, and bills of materials for competitive tenders and procurement quotations.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB 3: SKILLS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSkillsTab() {
    final categories = [
      'All',
      'Core Networking',
      'Protocols & Services',
      'Tools & Platforms',
      'Soft Skills',
    ];

    final allSkills = [
      // Core Networking
      _SkillData('Routing & Switching', 'Core Networking', 0.92, Icons.alt_route_rounded, _primaryIndigo),
      _SkillData('IPv4 & IPv6 Dual-Stack Addressing', 'Core Networking', 0.90, Icons.lan_rounded, _primaryIndigo),
      _SkillData('Subnetting (CIDR/VLSM/FLSM)', 'Core Networking', 0.95, Icons.calculate_rounded, _primaryIndigo),
      _SkillData('VLAN Segmentation & Trunking', 'Core Networking', 0.90, Icons.hub_rounded, _primaryIndigo),
      _SkillData('Inter-VLAN Routing (802.1Q)', 'Core Networking', 0.88, Icons.settings_ethernet_rounded, _primaryIndigo),

      // Protocols & Services
      _SkillData('TCP/IP Protocol Suite & OSI Model', 'Protocols & Services', 0.94, Icons.layers_rounded, _vibrantRose),
      _SkillData('DHCP & DNS Configuration', 'Protocols & Services', 0.90, Icons.dns_rounded, _vibrantRose),
      _SkillData('NAT (Network Address Translation)', 'Protocols & Services', 0.88, Icons.swap_horiz_rounded, _vibrantRose),
      _SkillData('ICMPv4 / ICMPv6 Diagnostics', 'Protocols & Services', 0.92, Icons.network_ping_rounded, _vibrantRose),
      _SkillData('SSHv2 Remote Access & Hardening', 'Protocols & Services', 0.88, Icons.security_rounded, _vibrantRose),
      _SkillData('HTTP / HTTPS Application Layer', 'Protocols & Services', 0.85, Icons.lock_outline_rounded, _vibrantRose),

      // Tools & Platforms
      _SkillData('Cisco Packet Tracer', 'Tools & Platforms', 0.95, Icons.hub_outlined, const Color(0xFF0284C7)),
      _SkillData('Cisco IOS CLI Configuration', 'Tools & Platforms', 0.90, Icons.terminal_rounded, const Color(0xFF0284C7)),
      _SkillData('VS Code & Dev Tools', 'Tools & Platforms', 0.88, Icons.laptop_chromebook_rounded, const Color(0xFF0284C7)),
      _SkillData('Git & GitHub Version Control', 'Tools & Platforms', 0.85, Icons.code_rounded, const Color(0xFF0284C7)),
      _SkillData('Postman API Testing', 'Tools & Platforms', 0.80, Icons.send_rounded, const Color(0xFF0284C7)),
      _SkillData('Flutter & Mobile UI', 'Tools & Platforms', 0.82, Icons.phone_android_rounded, const Color(0xFF0284C7)),

      // Soft Skills
      _SkillData('Fault Isolation & Diagnostics', 'Soft Skills', 0.95, Icons.troubleshoot_rounded, const Color(0xFF0D9488)),
      _SkillData('Technical Documentation', 'Soft Skills', 0.90, Icons.description_rounded, const Color(0xFF0D9488)),
      _SkillData('Incident Troubleshooting', 'Soft Skills', 0.92, Icons.warning_amber_rounded, const Color(0xFF0D9488)),
      _SkillData('Team Collaboration', 'Soft Skills', 0.92, Icons.groups_rounded, const Color(0xFF0D9488)),
    ];

    final filteredSkills = _selectedSkillCategory == 'All'
        ? allSkills
        : allSkills.where((s) => s.category == _selectedSkillCategory).toList();

    return Column(
      key: const ValueKey('tab_skills'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Category Filter
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
                    'Filter Technical Domain',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    final isSelected = _selectedSkillCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
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
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : _textSecondary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? _primaryIndigo : _borderColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

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
  // TAB 4: PROJECTS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildProjectsTab() {
    final projects = [
      _ProjectData(
        title: 'Enterprise Dual-Stack Campus Network Architecture with DMZ Segmentation',
        role: 'Network Infrastructure Architect',
        duration: 'Major Technical Project',
        description:
            'A comprehensive multi-subnet enterprise network architecture built with IPv4 & IPv6 dual-stack addressing, secure departmental isolation, and perimeter DMZ defense.',
        technologies: ['Cisco Packet Tracer', 'Cisco IOS CLI', '802.1Q VLANs', 'ACLs', 'SSHv2', 'IPv4/IPv6'],
        highlights: [
          'Dual-Stack Design & Routing: Architected and simulated a multi-subnet IPv4/IPv6 campus topology implementing 802.1Q inter-VLAN trunking and Router-on-a-Stick routing for secure departmental segmentation.',
          'Perimeter Security & DMZ: Built an isolated DMZ perimeter housing enterprise servers; deployed Standard and Extended ACLs to restrict unauthorized internal and external traffic.',
          'Device Hardening & Verification: Hardened network infrastructure using SSHv2 remote access and encrypted privilege passwords; verified end-to-end packet delivery and path redundancy using ICMP diagnostic tools.',
        ],
        githubRepo: _githubUrl,
      ),
      _ProjectData(
        title: 'TeamConnect – Mobile Group Profile Application',
        role: 'Member 7 Profile & UI Module Developer',
        duration: 'November 2026',
        description:
            'Collaborative cross-platform mobile profile app developed with Flutter and Firebase Authentication for nine NDT IT students at ITUM (CA02).',
        technologies: ['Flutter', 'Dart', 'Firebase Auth', 'Material 3', 'StatefulWidget'],
        highlights: [
          'Designed and implemented individual Member 7 profile screen with custom interactive tabs and theme system.',
          'Created responsive SliverAppBar with interactive favorites counter, contact triggers, and zoomable profile viewer.',
          'Structured clean code adhering strictly to dart format and flutter analyze guidelines.',
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
            'Tap project to expand key architecture and implementation details.',
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
                              index == 0 ? Icons.hub_rounded : Icons.phone_android_rounded,
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
                                    fontSize: 14.5,
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
                          'Implementation Highlights:',
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
                            label: const Text('View GitHub / Repos'),
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
  // TAB 5: EDUCATION, CERTIFICATIONS & REFERENCES
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildEducationAndCertsTab() {
    return Column(
      key: const ValueKey('tab_education'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Education
        _buildSectionCard(
          title: 'Education',
          icon: Icons.school_rounded,
          accentColor: _primaryIndigo,
          child: Column(
            children: [
              _buildEducationItem(
                institution: 'Institute of Technology, University of Moratuwa (ITUM)',
                qualification: 'Diploma in Information Technology',
                period: '2025 – Present',
                status: 'Undergraduate',
                isCurrent: true,
              ),
              const SizedBox(height: 14),
              _buildEducationItem(
                institution: 'Industrial Development Board (IDB)',
                qualification: 'Certificate in Computer Hardware and Networking',
                period: '2024',
                status: 'Completed',
                isCurrent: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Cisco & Industry Certifications
        _buildSectionCard(
          title: 'Industry Certifications',
          icon: Icons.workspace_premium_rounded,
          accentColor: _vibrantRose,
          child: Column(
            children: [
              _buildCertItem(
                title: 'CCNA: Enterprise Networking, Security, & Automation (ENSA)',
                issuer: 'Cisco Networking Academy (UoM)',
                year: 'In Progress',
                inProgress: true,
              ),
              const SizedBox(height: 10),
              _buildCertItem(
                title: 'CCNA: Switching, Routing, & Wireless Essentials (SRWE)',
                issuer: 'Cisco Networking Academy (UoM)',
                year: '2026',
              ),
              const SizedBox(height: 10),
              _buildCertItem(
                title: 'CCNA: Introduction to Networks (ITN)',
                issuer: 'Cisco Networking Academy (UoM)',
                year: '2026',
              ),
              const SizedBox(height: 10),
              _buildCertItem(
                title: 'Computer Hardware & Network Administration',
                issuer: 'Industrial Development Board (IDB)',
                year: '2024',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Academic References
        _buildSectionCard(
          title: 'References',
          icon: Icons.contact_emergency_rounded,
          accentColor: const Color(0xFF0D9488),
          child: Column(
            children: [
              _buildReferenceCard(
                name: 'Mrs. Tharukshi Adasuriya',
                title: 'Lecturer - Probationary',
                organization: 'Institute of Technology, University of Moratuwa',
                phone: '+94 77 1902981',
                email: 'tharukshin@itum.mrt.ac.lk',
              ),
              const SizedBox(height: 12),
              _buildReferenceCard(
                name: 'Mr. Madhura Anuranga',
                title: 'Deputy General Manager – Enterprise Solutions Sales',
                organization: 'Gestetner of Ceylon (Pvt) Ltd',
                phone: '+94 71 984 8436',
                email: 'madhuraanuranga@gmail.com',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Shared UI Helpers ───────────────────────────────────────────────────
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

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.arrow_right_rounded, size: 20, color: Color(0xFF0D9488)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: _textSecondary,
            ),
          ),
        ),
      ],
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
              width: 120,
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
    bool inProgress = false,
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
          Icon(
            inProgress ? Icons.hourglass_top_rounded : Icons.verified_rounded,
            size: 20,
            color: inProgress ? const Color(0xFFD97706) : _vibrantRose,
          ),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: inProgress
                  ? const Color(0xFFFEF3C7)
                  : _vibrantRose.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              year,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: inProgress ? const Color(0xFFB45309) : _vibrantRose,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceCard({
    required String name,
    required String title,
    required String organization,
    required String phone,
    required String email,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFF0D9488).withValues(alpha: 0.15),
                child: const Icon(Icons.person_rounded, size: 18, color: Color(0xFF0D9488)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: _textPrimary,
                      ),
                    ),
                    Text(
                      '$title • $organization',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: () => _launchUrlHelper('tel:$phone'),
                child: Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 14, color: _primaryIndigo),
                    const SizedBox(width: 4),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _primaryIndigo,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InkWell(
                  onTap: () => _launchUrlHelper('mailto:$email'),
                  child: Row(
                    children: [
                      const Icon(Icons.email_outlined, size: 14, color: _primaryIndigo),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          email,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: _primaryIndigo,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
          'Division of Information Technology | ITUM 2026',
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
