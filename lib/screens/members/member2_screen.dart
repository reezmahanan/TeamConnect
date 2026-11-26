import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// ─── Distinct Palette: Obsidian Dark + Emerald, Warm Amber & Coral ─────────
class _Palette {
  static const bg = Color(0xFF070B12);
  static const surface = Color(0xFF0E1520);
  static const card = Color(0xFF121B29);
  static const elevated = Color(0xFF192436);
  static const chip = Color(0xFF152030);

  // Primary Accent – Emerald Mint
  static const emerald = Color(0xFF10B981);
  static const emeraldLight = Color(0xFF34D399);
  static const emeraldGlow = Color(0x3310B981);

  // Secondary Accent – Warm Amber Gold
  static const amber = Color(0xFFF59E0B);

  // Tertiary Accent – Soft Rose Coral
  static const rose = Color(0xFFFB7185);

  // Neutrals
  static const white = Colors.white;
  static const textPri = Color(0xFFF1F5F9);
  static const textSec = Color(0xFF94A3B8);
  static const textMuted = Color(0xFF566882);
  static const divider = Color(0xFF1E2D42);

  // Gradients
  static const gradEmerald = LinearGradient(
    colors: [emeraldLight, Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const gradAmber = LinearGradient(
    colors: [amber, Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const gradRose = LinearGradient(
    colors: [rose, Color(0xFFA855F7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─── Main Screen ───────────────────────────────────────────────────────────
class Member2Screen extends StatefulWidget {
  const Member2Screen({super.key});

  @override
  State<Member2Screen> createState() => _Member2ScreenState();
}

class _Member2ScreenState extends State<Member2Screen> {
  int _selectedTab = 0;
  String _projectFilter = 'All';
  final Set<int> _expandedProjects = {0};
  final Set<String> _expandedMore = {'certifications', 'experience'};

  static const String _profileImage = 'lib/assets/images/wageesha.jpeg';
  static const String _email = 'kavinirathnayaka15@gmail.com';

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not open link');
      }
    } catch (_) {
      if (!mounted) return;
      _showSnack('Could not open the link.');
    }
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(const ClipboardData(text: _email));
    if (!mounted) return;
    _showSnack('Email copied to clipboard.');
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: _Palette.textPri),
          ),
          backgroundColor: _Palette.elevated,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
  }

  void _showFullPhoto() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        backgroundColor: _Palette.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480, maxHeight: 580),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              InteractiveViewer(
                minScale: 0.8,
                maxScale: 4,
                child: Image.asset(
                  _profileImage,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 100,
                        color: _Palette.emeraldLight.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: _Palette.surface.withValues(alpha: 0.9),
                    foregroundColor: _Palette.textSec,
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Palette.bg,
      appBar: AppBar(
        backgroundColor: _Palette.bg,
        foregroundColor: _Palette.textPri,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── Hero Header ──
                SliverToBoxAdapter(
                  child: _centred(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        isWide ? 32 : 16,
                        8,
                        isWide ? 32 : 16,
                        8,
                      ),
                      child: _ProfileHeader(
                        isWide: isWide,
                        imagePath: _profileImage,
                        onPhotoTap: _showFullPhoto,
                        onEmailTap: _copyEmail,
                        onLink: _openLink,
                      ),
                    ),
                  ),
                ),

                // ── Stats Row ──
                SliverToBoxAdapter(
                  child: _centred(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 32 : 16,
                        vertical: 8,
                      ),
                      child: const _StatisticsRow(),
                    ),
                  ),
                ),

                // ── Sticky Tab Bar ──
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabHeaderDelegate(
                    height: 68,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWide ? 32 : 16,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1080),
                          child: _ProfileTabs(
                            selectedIndex: _selectedTab,
                            onSelected: (i) => setState(() => _selectedTab = i),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Tab Content ──
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    isWide ? 32 : 16,
                    16,
                    isWide ? 32 : 16,
                    40,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1080),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 240),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeIn,
                          child: KeyedSubtree(
                            key: ValueKey(_selectedTab),
                            child: _buildSelectedTab(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _centred({required Widget child}) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1080),
      child: child,
    ),
  );

  Widget _buildSelectedTab() {
    switch (_selectedTab) {
      case 1:
        return const _SkillsSection();
      case 2:
        return _ProjectsSection(
          selectedFilter: _projectFilter,
          expandedProjects: _expandedProjects,
          onFilter: (f) => setState(() => _projectFilter = f),
          onExpand: (i) => setState(() {
            if (_expandedProjects.contains(i)) {
              _expandedProjects.remove(i);
            } else {
              _expandedProjects.add(i);
            }
          }),
          onLink: _openLink,
        );
      case 3:
        return _MoreSection(
          expandedSections: _expandedMore,
          onToggle: (t) => setState(() {
            if (_expandedMore.contains(t)) {
              _expandedMore.remove(t);
            } else {
              _expandedMore.add(t);
            }
          }),
          onCopyEmail: _copyEmail,
          onLink: _openLink,
        );
      default:
        return const _AboutSection();
    }
  }
}

// ─── Profile Header ────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.isWide,
    required this.imagePath,
    required this.onPhotoTap,
    required this.onEmailTap,
    required this.onLink,
  });

  final bool isWide;
  final String imagePath;
  final VoidCallback onPhotoTap;
  final VoidCallback onEmailTap;
  final Future<void> Function(String) onLink;

  @override
  Widget build(BuildContext context) {
    final avatar = _Avatar(imagePath: imagePath, onTap: onPhotoTap);
    final info = _ProfileInfo(
      isWide: isWide,
      onLink: onLink,
      onEmailTap: onEmailTap,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 28 : 20),
      decoration: BoxDecoration(
        color: _Palette.card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: _Palette.emeraldLight.withValues(alpha: 0.14),
        ),
        boxShadow: [
          BoxShadow(
            color: _Palette.emerald.withValues(alpha: 0.06),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar,
                const SizedBox(width: 28),
                Expanded(child: info),
              ],
            )
          : Column(children: [avatar, const SizedBox(height: 20), info]),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.imagePath, required this.onTap});
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: 'Tap to zoom photo',
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 136,
              height: 136,
              padding: const EdgeInsets.all(3.5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    _Palette.emeraldLight,
                    _Palette.amber,
                    _Palette.emerald,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _Palette.emeraldGlow,
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _Palette.surface,
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: _Palette.surface,
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 68,
                          color: _Palette.emeraldLight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _Palette.amber,
                shape: BoxShape.circle,
                border: Border.all(color: _Palette.card, width: 3),
              ),
              child: const Icon(
                Icons.zoom_in_rounded,
                size: 12,
                color: _Palette.bg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({
    required this.isWide,
    required this.onLink,
    required this.onEmailTap,
  });

  final bool isWide;
  final Future<void> Function(String) onLink;
  final VoidCallback onEmailTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isWide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [_Palette.white, Color(0xFFA7F3D0)],
          ).createShader(bounds),
          child: Text(
            'Kavini Wageesha',
            textAlign: isWide ? TextAlign.start : TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              height: 1.05,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'W. R. Kavini Wageesha Hansamali',
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: const TextStyle(
            color: _Palette.textSec,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: isWide ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: isWide
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Container(
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_Palette.emeraldLight, _Palette.amber],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Software Quality Assurance & Full-Stack Enthusiast',
                textAlign: isWide ? TextAlign.start : TextAlign.center,
                style: const TextStyle(
                  color: _Palette.emeraldLight,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: const [
            _InfoPill(
              Icons.fingerprint_rounded,
              '23IT0481',
              _Palette.emeraldLight,
            ),
            _InfoPill(Icons.school_rounded, 'ITUM', _Palette.amber),
            _InfoPill(
              Icons.location_on_rounded,
              'Galle, Sri Lanka',
              _Palette.rose,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            _SocialBtn(
              icon: Icons.code_rounded,
              label: 'GitHub',
              accent: _Palette.emeraldLight,
              onTap: () => onLink('https://github.com/Wageesha03'),
            ),
            _SocialBtn(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              accent: _Palette.amber,
              onTap: () =>
                  onLink('https://www.linkedin.com/in/kavini-wageesha'),
            ),
            _SocialBtn(
              icon: Icons.copy_rounded,
              label: 'Copy Email',
              accent: _Palette.rose,
              onTap: onEmailTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialBtn extends StatelessWidget {
  const _SocialBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withValues(alpha: 0.24)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: accent),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Statistics Row ────────────────────────────────────────────────────────
class _StatisticsRow extends StatelessWidget {
  const _StatisticsRow();

  @override
  Widget build(BuildContext context) {
    const stats = [
      (
        '100+',
        'Test Cases\nAuthored',
        Icons.fact_check_rounded,
        _Palette.gradEmerald,
      ),
      (
        '5+',
        'Software & IoT\nProjects',
        Icons.folder_special_rounded,
        _Palette.gradAmber,
      ),
      (
        '6 Mos',
        'Banking Ops\nExperience',
        Icons.account_balance_rounded,
        _Palette.gradRose,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 540;
        if (narrow) {
          return Column(
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                _StatCard(stats[i].$1, stats[i].$2, stats[i].$3, stats[i].$4),
                if (i < stats.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }
        return Row(
          children: [
            for (var i = 0; i < stats.length; i++) ...[
              Expanded(
                child: _StatCard(
                  stats[i].$1,
                  stats[i].$2,
                  stats[i].$3,
                  stats[i].$4,
                ),
              ),
              if (i < stats.length - 1) const SizedBox(width: 10),
            ],
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.value, this.label, this.icon, this.gradient);
  final String value;
  final String label;
  final IconData icon;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 12 * (1 - v)),
          child: child,
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 86),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _Palette.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (b) => gradient.createShader(b),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (b) => gradient.createShader(b),
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _Palette.textSec,
                      fontSize: 10.5,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sticky Tab Bar ────────────────────────────────────────────────────────
class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  _TabHeaderDelegate({required this.height, required this.child});
  final double height;
  final Widget child;

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: _Palette.bg.withValues(alpha: 0.96),
      alignment: Alignment.bottomCenter,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _TabHeaderDelegate o) =>
      o.child != child || o.height != height;
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs({required this.selectedIndex, required this.onSelected});
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _tabs = [
    (Icons.person_outline_rounded, 'About'),
    (Icons.code_rounded, 'Skills'),
    (Icons.folder_special_outlined, 'Projects'),
    (Icons.grid_view_rounded, 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _Palette.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final tab = _tabs[i];
          final sel = selectedIndex == i;
          return Expanded(
            child: InkWell(
              onTap: () => onSelected(i),
              borderRadius: BorderRadius.circular(13),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  gradient: sel ? _Palette.gradEmerald : null,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: sel
                      ? [
                          BoxShadow(
                            color: _Palette.emerald.withValues(alpha: 0.28),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tab.$1,
                      size: 17,
                      color: sel ? _Palette.bg : _Palette.textMuted,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tab.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        color: sel ? _Palette.bg : _Palette.textMuted,
                        fontSize: 10.5,
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w600,
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
}

// ─── About Section ─────────────────────────────────────────────────────────
class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final two = constraints.maxWidth >= 760;
        final cards = [
          const _InfoCard(
            title: 'Professional Introduction',
            icon: Icons.person_outline_rounded,
            accent: _Palette.emeraldLight,
            child: Text(
              'I am an Information Technology undergraduate at the Institute of Technology, '
              'University of Moratuwa (ITUM), with strong interests in Software Quality Assurance, '
              'test automation, full-stack web engineering, and mobile application development. '
              'I enjoy designing thorough test cases, uncovering edge-case defects, and building '
              'reliable, user-centered software solutions.',
              style: TextStyle(
                color: _Palette.textSec,
                height: 1.6,
                fontSize: 13,
              ),
            ),
          ),
          const _InfoCard(
            title: 'Personal Details',
            icon: Icons.badge_outlined,
            accent: _Palette.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(
                  Icons.fingerprint_rounded,
                  'Registration Number',
                  '23IT0481',
                ),
                _DetailRow(
                  Icons.email_outlined,
                  'Email Address',
                  'kavinirathnayaka15@gmail.com',
                ),
                _DetailRow(
                  Icons.location_on_outlined,
                  'Address',
                  'Polhena, Angulugaha, Galle, Sri Lanka',
                ),
              ],
            ),
          ),
          const _InfoCard(
            title: 'Academic Qualifications',
            icon: Icons.school_outlined,
            accent: _Palette.emeraldLight,
            child: _EducationTimeline(),
          ),
          const _InfoCard(
            title: 'Career Objective',
            icon: Icons.flag_outlined,
            accent: _Palette.rose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To excel as a Software Quality Assurance & Software Engineer by ensuring '
                  'high-quality, defect-free digital products while continuously mastering '
                  'modern test automation and cloud technologies.',
                  style: TextStyle(
                    color: _Palette.textSec,
                    height: 1.6,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 12),
                _QuoteBanner(
                  '"Quality is never an accident; it is always the result of intelligent effort and attention to detail."',
                ),
              ],
            ),
          ),
          const _InfoCard(
            title: 'Soft Skills',
            icon: Icons.groups_outlined,
            accent: _Palette.amber,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip('Attention to Detail', Icons.search_rounded),
                _Chip('Analytical Problem Solving', Icons.psychology_outlined),
                _Chip('Team Collaboration', Icons.diversity_3_outlined),
                _Chip('Clear Documentation', Icons.description_outlined),
                _Chip('Time Management', Icons.schedule_outlined),
                _Chip('Adaptability', Icons.autorenew_rounded),
              ],
            ),
          ),
          const _InfoCard(
            title: 'Special Talents & Interests',
            icon: Icons.auto_awesome_outlined,
            accent: _Palette.rose,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip('Graphic Design & Illustration', Icons.palette_outlined),
                _Chip(
                  'UI/UX Prototyping (Figma)',
                  Icons.design_services_outlined,
                ),
                _Chip('Video Editing & Animation', Icons.movie_edit),
                _Chip('Event Coordination', Icons.emoji_events_outlined),
                _Chip('Custom Outfit Sketching', Icons.brush_outlined),
              ],
            ),
          ),
        ];

        if (!two) {
          return Column(
            children: [
              for (var i = 0; i < cards.length; i++) ...[
                cards[i],
                if (i != cards.length - 1) const SizedBox(height: 12),
              ],
            ],
          );
        }

        return Column(
          children: [
            for (var row = 0; row < (cards.length / 2).ceil(); row++) ...[
              if (row > 0) const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[row * 2]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: row * 2 + 1 < cards.length
                        ? cards[row * 2 + 1]
                        : const SizedBox(),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}

class _QuoteBanner extends StatelessWidget {
  const _QuoteBanner(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _Palette.emerald.withValues(alpha: 0.1),
            _Palette.amber.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.emeraldLight.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _Palette.emeraldLight,
          fontStyle: FontStyle.italic,
          height: 1.5,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _EducationTimeline extends StatelessWidget {
  const _EducationTimeline();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _EducationItem(
          period: '2025 – PRESENT',
          title: 'National Diploma in Technology (NDT) in IT',
          institution:
              'Institute of Technology, University of Moratuwa (ITUM), Sri Lanka',
          location: 'Diyagama, Homagama, Sri Lanka',
          detail: 'Focus: Software Quality Assurance, Full-Stack & Mobile Apps',
          accent: _Palette.emeraldLight,
        ),
        SizedBox(height: 10),
        _EducationItem(
          period: '2023',
          title: 'GCE Advanced Level – Physical Science Stream',
          institution: 'Anuladevi Balika Vidyalaya',
          location: 'Galle, Sri Lanka',
          detail: 'Combined Mathematics (B), Chemistry (C), Physics (S)',
          accent: _Palette.amber,
        ),
        SizedBox(height: 10),
        _EducationItem(
          period: '2023',
          title: 'Certificates in Information Technology & English',
          institution: 'Open University of Sri Lanka & ICBT Campus',
          location: 'Sri Lanka',
          detail: 'Computing Fundamentals & Professional Communication',
          accent: _Palette.rose,
        ),
      ],
    );
  }
}

class _EducationItem extends StatelessWidget {
  const _EducationItem({
    required this.period,
    required this.title,
    required this.institution,
    required this.location,
    required this.accent,
    this.detail,
  });

  final String period;
  final String title;
  final String institution;
  final String location;
  final Color accent;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _Palette.elevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.school_rounded, color: accent, size: 20),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  period,
                  style: TextStyle(
                    color: accent,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: _Palette.textPri,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  institution,
                  style: const TextStyle(
                    color: _Palette.textSec,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: _Palette.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          color: _Palette.textMuted,
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                  ],
                ),
                if (detail != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    detail!,
                    style: TextStyle(
                      color: accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Skills Section ────────────────────────────────────────────────────────
class _SkillsSection extends StatefulWidget {
  const _SkillsSection();

  @override
  State<_SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<_SkillsSection> {
  final Set<String> _expanded = {
    'Software Quality Assurance',
    'Programming & Development',
  };

  @override
  Widget build(BuildContext context) {
    const categories = [
      (
        Icons.verified_outlined,
        'Software Quality Assurance',
        [
          'Manual Testing',
          'Test Case Design',
          'Bug Tracking (Jira)',
          'API Testing (Postman)',
          'Selenium',
          'Playwright',
          'Regression Testing',
          'Cross-Browser UI Validation',
        ],
        _Palette.gradEmerald,
      ),
      (
        Icons.code_rounded,
        'Programming & Development',
        [
          'Java',
          'Spring Boot',
          'Dart',
          'Flutter',
          'React',
          'NestJS',
          'Python',
          'PHP',
          'JavaScript',
          'C',
        ],
        _Palette.gradAmber,
      ),
      (
        Icons.storage_rounded,
        'Databases & Cloud',
        [
          'PostgreSQL',
          'MySQL',
          'Prisma ORM',
          'Firebase',
          'Microsoft Azure',
          'Docker',
        ],
        _Palette.gradRose,
      ),
      (
        Icons.palette_outlined,
        'UI/UX, Design & Analytics',
        [
          'Figma',
          'Adobe Illustrator',
          'Adobe Photoshop',
          'Canva',
          'CapCut',
          'WordPress & Elementor',
          'Power BI',
          'RStudio',
        ],
        _Palette.gradEmerald,
      ),
      (
        Icons.build_circle_outlined,
        'Developer & Testing Tools',
        [
          'Git',
          'GitHub',
          'VS Code',
          'IntelliJ IDEA',
          'Android Studio',
          'Postman',
          'DBeaver',
          'Proteus',
        ],
        _Palette.gradAmber,
      ),
      (
        Icons.memory_outlined,
        'IoT & Embedded Systems',
        ['ATmega32', 'Embedded C', 'Sensor Interfacing', 'Proteus Simulation'],
        _Palette.gradRose,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final two = constraints.maxWidth >= 760;
        final cards = categories.map((cat) {
          final title = cat.$2;
          return _ExpandableCard(
            title: title,
            icon: cat.$1,
            gradient: cat.$4,
            expanded: _expanded.contains(title),
            onTap: () => setState(() {
              if (_expanded.contains(title)) {
                _expanded.remove(title);
              } else {
                _expanded.add(title);
              }
            }),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: cat.$3
                  .map((s) => _Chip(s, Icons.check_circle_outline_rounded))
                  .toList(),
            ),
          );
        }).toList();

        if (!two) {
          return Column(
            children: [
              for (var i = 0; i < cards.length; i++) ...[
                cards[i],
                if (i != cards.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards
              .map(
                (c) => SizedBox(
                  width: ((constraints.maxWidth - 12) / 2).floorToDouble(),
                  child: c,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ─── Projects Section ──────────────────────────────────────────────────────
class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({
    required this.selectedFilter,
    required this.expandedProjects,
    required this.onFilter,
    required this.onExpand,
    required this.onLink,
  });

  final String selectedFilter;
  final Set<int> expandedProjects;
  final ValueChanged<String> onFilter;
  final ValueChanged<int> onExpand;
  final Future<void> Function(String) onLink;

  static const _projects = [
    _Project(
      title: 'Hub Lanka Freight Forwarding System',
      subtitle: 'QA Testing & Full-Stack Management Platform',
      description:
          'Authored 100+ structured manual test cases, logged functional and validation defects, and contributed to backend and UI workflows for freight operations.',
      technologies: ['React', 'NestJS', 'Prisma', 'PostgreSQL', 'Manual QA'],
      category: 'QA & Web',
      icon: Icons.local_shipping_rounded,
      github: 'https://github.com/Wageesha03',
      highlight: '100+ Test Cases Executed',
    ),
    _Project(
      title: 'TeamConnect',
      subtitle: 'Flutter Group Profile Mobile Application',
      description:
          'Responsive Flutter and Firebase Authentication mobile application displaying group member directories and custom interactive individual profiles.',
      technologies: ['Flutter', 'Dart', 'Firebase Auth', 'Material 3'],
      category: 'Mobile',
      icon: Icons.groups_rounded,
      github: 'https://github.com/reezmahanan/TeamConnect',
    ),
    _Project(
      title: 'Supply Chain Inventory Management',
      subtitle: 'Full-Stack Stock & Product Tracking System',
      description:
          'Implemented product image upload pipelines and dynamic multi-criteria search and filtering features for real-time inventory management.',
      technologies: ['Java', 'Spring Boot', 'React', 'MySQL', 'Docker'],
      category: 'QA & Web',
      icon: Icons.inventory_2_rounded,
      github: 'https://github.com/Wageesha03',
    ),
    _Project(
      title: 'Career Suggestion Web System',
      subtitle: 'Student Pathway Recommendation & UI Validation',
      description:
          'Developed a web-based career recommendation platform with structured manual test scenarios and cross-browser UI validation.',
      technologies: ['PHP', 'JavaScript', 'CSS', 'MySQL'],
      category: 'QA & Web',
      icon: Icons.explore_rounded,
      github: 'https://github.com/Wageesha03',
    ),
    _Project(
      title: 'Smart Home & Server Room IoT',
      subtitle: 'ATmega32 Microcontroller Automation Prototype',
      description:
          'Designed and simulated an embedded automation system integrating temperature, gas, light, water level, and PIR sensors with LCD telemetry.',
      technologies: ['C', 'ATmega32', 'Proteus', 'Embedded Sensors'],
      category: 'IoT',
      icon: Icons.memory_rounded,
      github: 'https://github.com/Wageesha03',
    ),
  ];

  static const _categoryColors = {
    'QA & Web': _Palette.emeraldLight,
    'Mobile': _Palette.amber,
    'IoT': _Palette.rose,
  };

  @override
  Widget build(BuildContext context) {
    const filters = ['All', 'QA & Web', 'Mobile', 'IoT'];
    final filtered = _projects
        .asMap()
        .entries
        .where(
          (e) => selectedFilter == 'All' || e.value.category == selectedFilter,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) {
              final sel = selectedFilter == f;
              final color = _categoryColors[f] ?? _Palette.emeraldLight;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onFilter(f),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: sel
                          ? color.withValues(alpha: 0.16)
                          : _Palette.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: sel
                            ? color.withValues(alpha: 0.5)
                            : _Palette.divider,
                      ),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        color: sel ? color : _Palette.textMuted,
                        fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final two = constraints.maxWidth >= 760;
            if (!two) {
              return Column(
                children: [
                  for (var i = 0; i < filtered.length; i++) ...[
                    _ProjectCard(
                      project: filtered[i].value,
                      index: filtered[i].key,
                      expanded: expandedProjects.contains(filtered[i].key),
                      onExpand: () => onExpand(filtered[i].key),
                      onLink: onLink,
                    ),
                    if (i != filtered.length - 1) const SizedBox(height: 12),
                  ],
                ],
              );
            }
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: filtered
                  .map(
                    (e) => SizedBox(
                      width: ((constraints.maxWidth - 12) / 2).floorToDouble(),
                      child: _ProjectCard(
                        project: e.value,
                        index: e.key,
                        expanded: expandedProjects.contains(e.key),
                        onExpand: () => onExpand(e.key),
                        onLink: onLink,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 14),
        _GradientButton(
          label: 'Explore GitHub Profile (Wageesha03)',
          icon: Icons.open_in_new_rounded,
          onTap: () => onLink('https://github.com/Wageesha03'),
        ),
      ],
    );
  }
}

class _Project {
  const _Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.technologies,
    required this.category,
    required this.icon,
    required this.github,
    this.highlight,
  });

  final String title;
  final String subtitle;
  final String description;
  final List<String> technologies;
  final String category;
  final IconData icon;
  final String github;
  final String? highlight;
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.expanded,
    required this.onExpand,
    required this.onLink,
  });

  final _Project project;
  final int index;
  final bool expanded;
  final VoidCallback onExpand;
  final Future<void> Function(String) onLink;

  static const _catColors = {
    'QA & Web': _Palette.emeraldLight,
    'Mobile': _Palette.amber,
    'IoT': _Palette.rose,
  };

  @override
  Widget build(BuildContext context) {
    final accent = _catColors[project.category] ?? _Palette.emeraldLight;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 280 + index * 40),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 12 * (1 - v)),
          child: child,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accent.withValues(alpha: 0.16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: accent.withValues(alpha: 0.25)),
                  ),
                  child: Icon(project.icon, color: accent, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: const TextStyle(
                          color: _Palette.textPri,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        project.subtitle,
                        style: TextStyle(
                          color: accent,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    project.category,
                    style: TextStyle(
                      color: accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project.description,
              style: const TextStyle(
                color: _Palette.textSec,
                height: 1.5,
                fontSize: 12.5,
              ),
            ),
            if (project.highlight != null) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _Palette.emerald.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _Palette.emeraldLight.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: _Palette.emeraldLight,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        project.highlight!,
                        style: const TextStyle(
                          color: _Palette.emeraldLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (expanded) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.technologies
                    .map((t) => _TechBadge(t))
                    .toList(),
              ),
            ],
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  GestureDetector(
                    onTap: () => onLink(project.github),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: _Palette.elevated,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _Palette.divider),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.code_rounded,
                            size: 14,
                            color: _Palette.textSec,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'GitHub',
                            style: TextStyle(
                              color: _Palette.textSec,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onExpand,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            expanded ? 'Hide Stack' : 'View Stack',
                            style: const TextStyle(
                              color: _Palette.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            expanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: _Palette.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  const _TechBadge(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: _Palette.elevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _Palette.divider),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _Palette.textSec,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _Palette.emeraldLight.withValues(alpha: 0.35),
          ),
          gradient: LinearGradient(
            colors: [
              _Palette.emerald.withValues(alpha: 0.12),
              _Palette.amber.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: _Palette.emeraldLight),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _Palette.emeraldLight,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── More Section ──────────────────────────────────────────────────────────
class _MoreSection extends StatelessWidget {
  const _MoreSection({
    required this.expandedSections,
    required this.onToggle,
    required this.onCopyEmail,
    required this.onLink,
  });

  final Set<String> expandedSections;
  final ValueChanged<String> onToggle;
  final VoidCallback onCopyEmail;
  final Future<void> Function(String) onLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ExpandableCard(
          title: 'Work & Internship Experience',
          icon: Icons.business_center_outlined,
          gradient: _Palette.gradEmerald,
          expanded: expandedSections.contains('experience'),
          onTap: () => onToggle('experience'),
          child: const Column(
            children: [
              _RoleItem(
                badge: '2026',
                title: 'Java Programming Intern (Selected)',
                subtitle: 'CodeAlpha • Object-Oriented Java Development',
                accent: _Palette.emeraldLight,
              ),
              _RoleItem(
                badge: '6 MOS',
                title: 'Banking Operations Trainee',
                subtitle:
                    'People’s Bank • Daily Banking Workflows & Documentation',
                accent: _Palette.amber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Professional Certifications',
          icon: Icons.workspace_premium_outlined,
          gradient: _Palette.gradAmber,
          expanded: expandedSections.contains('certifications'),
          onTap: () => onToggle('certifications'),
          child: const Column(
            children: [
              _RoleItem(
                badge: 'UOM',
                title: 'Introduction to Software Quality Assurance',
                subtitle: 'Centre for Open & Distance Learning (CODL), UOM',
                accent: _Palette.emeraldLight,
              ),
              _RoleItem(
                badge: 'UOM',
                title: 'Python for Beginners',
                subtitle: 'Centre for Open & Distance Learning (CODL), UOM',
                accent: _Palette.amber,
              ),
              _RoleItem(
                badge: 'AZURE',
                title: 'Microsoft Certified: Azure Fundamentals (AZ-900)',
                subtitle: 'Microsoft Learn Cloud Curriculum',
                accent: _Palette.rose,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Contact & Social Links',
          icon: Icons.alternate_email_rounded,
          gradient: _Palette.gradRose,
          expanded: expandedSections.contains('links'),
          onTap: () => onToggle('links'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DetailRow(
                Icons.email_outlined,
                'Email',
                'kavinirathnayaka15@gmail.com',
              ),
              const _DetailRow(
                Icons.location_on_outlined,
                'Address',
                'Polhena, Angulugaha, Galle, Sri Lanka',
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SocialBtn(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    accent: _Palette.emeraldLight,
                    onTap: () => onLink('https://github.com/Wageesha03'),
                  ),
                  _SocialBtn(
                    icon: Icons.work_outline_rounded,
                    label: 'LinkedIn',
                    accent: _Palette.amber,
                    onTap: () =>
                        onLink('https://www.linkedin.com/in/kavini-wageesha'),
                  ),
                  _SocialBtn(
                    icon: Icons.copy_rounded,
                    label: 'Copy Email',
                    accent: _Palette.rose,
                    onTap: onCopyEmail,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Shared Reusable Widgets ───────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.child,
    this.accent = _Palette.emeraldLight,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _Palette.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 17, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _Palette.textPri,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
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
}

class _ExpandableCard extends StatelessWidget {
  const _ExpandableCard({
    required this.title,
    required this.icon,
    required this.expanded,
    required this.onTap,
    required this.child,
    this.gradient = _Palette.gradEmerald,
  });

  final String title;
  final IconData icon;
  final bool expanded;
  final VoidCallback onTap;
  final Widget child;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _Palette.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _Palette.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (b) => gradient.createShader(b),
                    child: Icon(icon, size: 20, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: _Palette.textPri,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: _Palette.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            child: expanded
                ? Column(
                    children: [
                      const Divider(color: _Palette.divider, height: 1),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                        child: child,
                      ),
                    ],
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _Palette.emerald.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: _Palette.emeraldLight),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _Palette.textPri,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: _Palette.textSec,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.label, this.icon);
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _Palette.chip,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _Palette.emeraldLight),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: _Palette.textSec,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleItem extends StatelessWidget {
  const _RoleItem({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String badge;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _Palette.elevated,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              badge,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w900,
                fontSize: 10.5,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _Palette.textPri,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: _Palette.textSec, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
