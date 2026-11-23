import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

// ─── Palette ───────────────────────────────────────────────────────────────
class _P {
  // Backgrounds
  static const bg = Color(0xFF060C18);
  static const surface = Color(0xFF0D1829);
  static const card = Color(0xFF101F36);
  static const elevated = Color(0xFF19283F);
  static const chip = Color(0xFF162035);

  // Accent – electric cyan-teal
  static const cyan = Color(0xFF22D3EE);
  static const cyanGlow = Color(0x3322D3EE);

  // Accent – violet
  static const violet = Color(0xFF818CF8);

  // Accent – emerald (secondary)
  static const emerald = Color(0xFF34D399);

  // Neutrals
  static const white = Colors.white;
  static const textPri = Color(0xFFE8F0FE);
  static const textSec = Color(0xFF8FA3BF);
  static const textMuted = Color(0xFF4E6480);
  static const divider = Color(0xFF1A2D47);

  // Gradient shortcuts
  static const gradCyan = LinearGradient(
    colors: [cyan, Color(0xFF818CF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const gradViolet = LinearGradient(
    colors: [Color(0xFF818CF8), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const gradEmerald = LinearGradient(
    colors: [Color(0xFF34D399), Color(0xFF22D3EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─── Main Screen ───────────────────────────────────────────────────────────
class Member1Screen extends StatefulWidget {
  const Member1Screen({super.key});

  @override
  State<Member1Screen> createState() => _Member1ScreenState();
}

class _Member1ScreenState extends State<Member1Screen> {
  int _selectedTab = 0;
  String _projectFilter = 'All';
  final Set<int> _expandedProjects = {};
  final Set<String> _expandedMore = {};

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
    await Clipboard.setData(const ClipboardData(text: 'reezmahanan@gmail.com'));
    if (!mounted) return;
    _showSnack('Email copied to clipboard.');
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: _P.textPri)),
          backgroundColor: _P.elevated,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
  }

  void _showPhoto() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        backgroundColor: _P.surface,
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
                  'assets/reezma/images/profile/reezma.jpg',
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => SizedBox(
                    height: 400,
                    child: Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 100,
                        color: _P.cyan.withValues(alpha: 0.6),
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
                    backgroundColor: _P.surface.withValues(alpha: 0.9),
                    foregroundColor: _P.textSec,
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
      backgroundColor: _P.bg,
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
                    isWide: isWide,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        isWide ? 32 : 16,
                        16,
                        isWide ? 32 : 16,
                        8,
                      ),
                      child: _ProfileHeader(
                        isWide: isWide,
                        onPhotoTap: _showPhoto,
                        onEmailTap: _copyEmail,
                        onLink: _openLink,
                      ),
                    ),
                  ),
                ),

                // ── Stats Row ──
                SliverToBoxAdapter(
                  child: _centred(
                    isWide: isWide,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 32 : 16,
                        vertical: 8,
                      ),
                      child: const _Statistics(),
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
                            child: _buildSelectedTab(isWide),
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

  Widget _centred({required bool isWide, required Widget child}) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1080),
      child: child,
    ),
  );

  Widget _buildSelectedTab(bool isWide) {
    switch (_selectedTab) {
      case 1:
        return const _SkillsSection();
      case 2:
        return _ProjectsSection(
          isWide: isWide,
          selectedFilter: _projectFilter,
          expandedProjects: _expandedProjects,
          onFilter: (f) => setState(() => _projectFilter = f),
          onExpand: (i) => setState(() {
            _expandedProjects.contains(i)
                ? _expandedProjects.remove(i)
                : _expandedProjects.add(i);
          }),
          onLink: _openLink,
        );
      case 3:
        return _MoreSection(
          expandedSections: _expandedMore,
          onToggle: (t) => setState(() {
            _expandedMore.contains(t)
                ? _expandedMore.remove(t)
                : _expandedMore.add(t);
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
    required this.onPhotoTap,
    required this.onEmailTap,
    required this.onLink,
  });

  final bool isWide;
  final VoidCallback onPhotoTap;
  final VoidCallback onEmailTap;
  final Future<void> Function(String) onLink;

  @override
  Widget build(BuildContext context) {
    final avatar = _Avatar(onTap: onPhotoTap);
    final info = _ProfileInfo(
      isWide: isWide,
      onLink: onLink,
      onEmailTap: onEmailTap,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 28 : 20),
      decoration: BoxDecoration(
        color: _P.card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _P.cyan.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: _P.cyan.withValues(alpha: 0.04),
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
  const _Avatar({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: 'View full photo',
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 136,
              height: 136,
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: _P.gradCyan,
                boxShadow: [
                  BoxShadow(
                    color: _P.cyanGlow,
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _P.surface,
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Image.asset(
                    'assets/reezma/images/profile/reezma.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: _P.surface,
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 68,
                          color: _P.cyan,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Online badge
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: _P.emerald,
                shape: BoxShape.circle,
                border: Border.all(color: _P.card, width: 3),
                boxShadow: const [
                  BoxShadow(color: Color(0x5034D399), blurRadius: 8),
                ],
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
        // Name with gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [_P.white, Color(0xFFB8D4FF)],
          ).createShader(bounds),
          child: Text(
            'Reezma Hanan',
            textAlign: isWide ? TextAlign.start : TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
            ),
          ),
        ),
        const SizedBox(height: 6),
        // Title with cyan accent
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
                  colors: [_P.cyan, _P.violet],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Full-Stack & AI / ML Engineer',
              style: TextStyle(
                color: _P.cyan,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Full-Stack Developer  ·  AI/ML Enthusiast',
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: const TextStyle(
            color: _P.textSec,
            fontSize: 13,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: const [
            _InfoPill(Icons.fingerprint_rounded, '23IT0480', _P.cyan),
            _InfoPill(Icons.school_rounded, 'ITUM', _P.violet),
            _InfoPill(
              Icons.location_on_rounded,
              'Batticaloa, Sri Lanka',
              _P.emerald,
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
              onTap: () => onLink('https://github.com/reezmahanan'),
            ),
            _SocialBtn(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              onTap: () => onLink('https://www.linkedin.com/in/reezma-hanan'),
            ),
            _SocialBtn(
              icon: Icons.language_rounded,
              label: 'Portfolio',
              onTap: () => onLink('https://portfolio-website-7mdi.vercel.app/'),
            ),
            _SocialBtn(
              icon: Icons.email_outlined,
              label: 'Email',
              onTap: onEmailTap,
              accent: _P.violet,
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
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color.withValues(alpha: 0.9),
              fontSize: 11,
              fontWeight: FontWeight.w600,
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
    this.accent = _P.cyan,
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
            color: accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withValues(alpha: 0.18)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: accent),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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
class _Statistics extends StatelessWidget {
  const _Statistics();

  @override
  Widget build(BuildContext context) {
    const stats = <(String, String, IconData, LinearGradient)>[
      ('6', 'Featured\nProjects', Icons.folder_special_rounded, _P.gradEmerald),
      ('20+', 'Certifications', Icons.workspace_premium_rounded, _P.gradCyan),
      ('5', 'Open Source\nPrograms', Icons.hub_rounded, _P.gradViolet),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 420;
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
        height: 86,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: _P.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _P.cyan.withValues(alpha: 0.07)),
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
                  color: Colors.white.withValues(alpha: 0.06),
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
                      color: _P.textSec,
                      fontSize: 10,
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

// ─── Tab Bar ───────────────────────────────────────────────────────────────
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
      color: _P.bg.withValues(alpha: 0.95),
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

  static const _tabs = <(IconData, String)>[
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
        color: _P.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _P.cyan.withValues(alpha: 0.08)),
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
                  gradient: sel ? _P.gradCyan : null,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: sel
                      ? [
                          BoxShadow(
                            color: _P.cyan.withValues(alpha: 0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(tab.$1, size: 17, color: sel ? _P.bg : _P.textMuted),
                    const SizedBox(height: 2),
                    Text(
                      tab.$2,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: sel ? _P.bg : _P.textMuted,
                        fontSize: 10,
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
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
            accent: _P.cyan,
            child: Text(
              'I am an Information Technology undergraduate at the Institute of Technology, '
              'University of Moratuwa (ITUM), with strong interests in full-stack software '
              'engineering, REST API architecture, Flutter development, Firebase, and machine '
              'learning. I enjoy turning ideas into practical, responsive applications and '
              'continuously improving through real-world projects and open-source collaboration.',
              style: TextStyle(color: _P.textSec, height: 1.6, fontSize: 13),
            ),
          ),
          const _InfoCard(
            title: 'Personal Details',
            icon: Icons.badge_outlined,
            accent: _P.violet,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(
                  Icons.fingerprint_rounded,
                  'Registration',
                  '23IT0480',
                ),
                _DetailRow(
                  Icons.email_outlined,
                  'Email',
                  'reezmahanan@gmail.com',
                ),
                _DetailRow(
                  Icons.location_on_outlined,
                  'Address',
                  'Oddamavadi, Batticaloa, Sri Lanka',
                ),
              ],
            ),
          ),
          const _InfoCard(
            title: 'Education',
            icon: Icons.school_outlined,
            accent: _P.emerald,
            child: _EducationTimeline(),
          ),
          const _InfoCard(
            title: 'Career Objective',
            icon: Icons.flag_outlined,
            accent: _P.cyan,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To become a skilled software engineer and full-stack developer by continuously '
                  'learning, developing scalable software solutions, and contributing to innovative real-world projects.',
                  style: TextStyle(
                    color: _P.textSec,
                    height: 1.6,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 12),
                _QuoteBanner(
                  '"Learn continuously, build consistently, and engineer scalable solutions that matter."',
                ),
              ],
            ),
          ),
          const _InfoCard(
            title: 'Soft Skills',
            icon: Icons.groups_outlined,
            accent: _P.violet,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip('Team Leadership', Icons.emoji_events_outlined),
                _Chip('Problem Solving', Icons.psychology_outlined),
                _Chip('Team Collaboration', Icons.diversity_3_outlined),
                _Chip('Project Coordination', Icons.account_tree_outlined),
                _Chip('Effective Communication', Icons.chat_bubble_outline),
                _Chip('Time Management', Icons.schedule_outlined),
                _Chip('Critical Thinking', Icons.lightbulb_outline),
              ],
            ),
          ),
          const _InfoCard(
            title: 'Interests & Talents',
            icon: Icons.auto_awesome_outlined,
            accent: _P.emerald,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip('Full-Stack Development', Icons.language_outlined),
                _Chip('AI & Machine Learning', Icons.auto_graph_outlined),
                _Chip('Creative Designing', Icons.palette_outlined),
                _Chip('UI/UX Design', Icons.design_services_outlined),
                _Chip('Open Source Contribution', Icons.hub_outlined),
                _Chip('DevOps', Icons.memory_outlined),
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
            _P.cyan.withValues(alpha: 0.08),
            _P.violet.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _P.cyan.withValues(alpha: 0.15)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _P.cyan,
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
    return Column(
      children: const [
        _EducationItem(
          period: 'OCT 2024 – PRESENT',
          title: 'National Diploma in Information Technology (NDT IT)',
          institution:
              'Institute of Technology, University of Moratuwa (ITUM), Sri Lanka',
          location: 'Diyagama, Homagama, Sri Lanka',
          detail: 'Latest Semester GPA: 3.72',
          logo:
              'assets/reezma/images/profile/Institute of Technolgy UOM Logo.jpg',
          accent: _P.emerald,
        ),
        SizedBox(height: 10),
        _EducationItem(
          period: '2018 – 2020',
          title: 'GCE Advanced Level – Physical Science Stream',
          institution: 'BT/BC Oddamavadi Central College',
          location: 'Batticaloa, Sri Lanka',
          logo: 'assets/reezma/images/profile/Odd.central College Logo.jpg',
          accent: _P.cyan,
        ),
        SizedBox(height: 10),
        _EducationItem(
          period: '2007 – 2018',
          title: 'GCE Ordinary Level',
          institution: 'BT/BC Oddamavadi Fathima Balika Maha Vidyalaya',
          location: 'Batticaloa, Sri Lanka',
          detail: "Result: 8 A's and B's",
          logo: 'assets/reezma/images/profile/Odd.Fathima Balika Logo.jpg',
          accent: _P.violet,
        ),
      ],
    );
  }
}

// ─── Skills Section ────────────────────────────────────────────────────────
class _EducationItem extends StatelessWidget {
  const _EducationItem({
    required this.period,
    required this.title,
    required this.institution,
    required this.location,
    required this.logo,
    required this.accent,
    this.detail,
    this.description,
  });

  final String period;
  final String title;
  final String institution;
  final String location;
  final String logo;
  final Color accent;
  final String? detail;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _P.elevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              logo,
              width: 46,
              height: 46,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 46,
                height: 46,
                color: _P.chip,
                alignment: Alignment.center,
                child: Icon(Icons.school_rounded, color: accent),
              ),
            ),
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
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    color: _P.textPri,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  institution,
                  style: const TextStyle(
                    color: _P.textSec,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: _P.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          color: _P.textMuted,
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
                if (detail != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    detail!,
                    style: TextStyle(
                      color: accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
                if (description != null) ...[
                  const SizedBox(height: 7),
                  Text(
                    description!,
                    style: const TextStyle(
                      color: _P.textSec,
                      fontSize: 10,
                      height: 1.45,
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

class _SkillsSection extends StatefulWidget {
  const _SkillsSection();

  @override
  State<_SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<_SkillsSection> {
  final Set<String> _expanded = {'Programming Languages'};

  @override
  Widget build(BuildContext context) {
    const categories = <(IconData, String, List<String>, LinearGradient)>[
      (
        Icons.code_rounded,
        'Programming Languages',
        ['Java', 'Python', 'JavaScript', 'TypeScript', 'Dart', 'PHP', 'C'],
        _P.gradCyan,
      ),
      (
        Icons.web_rounded,
        'Frontend Development',
        [
          'React.js',
          'Next.js',
          'Angular',
          'HTML5',
          'CSS3',
          'Bootstrap',
          'Tailwind CSS',
        ],
        _P.gradEmerald,
      ),
      (
        Icons.dns_rounded,
        'Backend Development',
        ['Spring Boot', 'Node.js', 'Express.js', 'Laravel'],
        _P.gradViolet,
      ),
      (
        Icons.phone_android_rounded,
        'Mobile Development',
        ['Flutter', 'Dart', 'Firebase'],
        _P.gradCyan,
      ),
      (
        Icons.auto_awesome_rounded,
        'AI and Machine Learning',
        ['Scikit-Learn', 'LightGBM', 'Pandas', 'NumPy', 'Kaggle'],
        _P.gradViolet,
      ),
      (
        Icons.storage_rounded,
        'Databases',
        ['MySQL', 'MongoDB'],
        _P.gradEmerald,
      ),
      (
        Icons.cloud_outlined,
        'Cloud and DevOps',
        ['AWS', 'Microsoft Azure', 'Firebase', 'Docker', 'Linux'],
        _P.gradCyan,
      ),
      (
        Icons.build_circle_outlined,
        'Developer Tools',
        [
          'Git',
          'GitHub',
          'npm',
          'Postman',
          'IntelliJ IDEA',
          'VS Code',
          'Selenium',
          'Google Colab',
        ],
        _P.gradViolet,
      ),
      (
        Icons.palette_outlined,
        'UI/UX and Designing',
        ['Figma', 'Adobe Photoshop', 'Adobe Illustrator', 'Canva'],
        _P.gradEmerald,
      ),
      (
        Icons.memory_outlined,
        'IoT and Hardware',
        ['Arduino', 'ATmega32', 'Tinkercad', 'ThingSpeak'],
        _P.gradCyan,
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
              _expanded.contains(title)
                  ? _expanded.remove(title)
                  : _expanded.add(title);
            }),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: cat.$3
                  .map((s) => _Chip(s, Icons.circle, size: 14))
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
                (c) =>
                    SizedBox(width: (constraints.maxWidth - 12) / 2, child: c),
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
    required this.isWide,
    required this.selectedFilter,
    required this.expandedProjects,
    required this.onFilter,
    required this.onExpand,
    required this.onLink,
  });

  final bool isWide;
  final String selectedFilter;
  final Set<int> expandedProjects;
  final ValueChanged<String> onFilter;
  final ValueChanged<int> onExpand;
  final Future<void> Function(String) onLink;

  static const _projects = <_Project>[
    _Project(
      title: 'EduNexus',
      subtitle: 'Student Management System',
      description:
          'A full-stack academic management system with attendance tracking, GPA calculation, role-based authentication and AI academic risk prediction.',
      technologies: ['React', 'Spring Boot', 'MySQL', 'Material UI'],
      category: 'Web',
      icon: Icons.school_rounded,
      github: 'https://github.com/reezmahanan/Student-Management-System',
      image: 'assets/reezma/images/projects/edunexus.png',
    ),
    _Project(
      title: 'LibriQ',
      subtitle: 'University Library Management System',
      description:
          'A trilingual library management system with book circulation, role-based access and automated late fine calculations.',
      technologies: [
        'React',
        'Node.js',
        'Express.js',
        'MongoDB',
        'Tailwind CSS',
      ],
      category: 'Web',
      icon: Icons.local_library_rounded,
      github: 'https://github.com/reezmahanan/LibriQ',
      image: 'assets/reezma/images/projects/LibriQ.png',
    ),
    _Project(
      title: 'ReEz AI',
      subtitle: 'Flutter AI Chatbot',
      description:
          'A cross-platform AI chatbot with Gemini AI integration, Firebase authentication, streaming responses and persistent chat history.',
      technologies: ['Flutter', 'Dart', 'Gemini AI', 'Firebase', 'Firestore'],
      category: 'Mobile',
      icon: Icons.smart_toy_rounded,
      github: 'https://github.com/reezmahanan/Flutter-AI-Chatbot-Application',
      image: 'assets/reezma/images/projects/reez_ai.webp',
      live: 'https://reezma-ai-chat-2026.web.app/',
    ),
    _Project(
      title: 'STYLEO Ceylon',
      subtitle: 'E-Commerce System',
      description:
          'A full-stack apparel shopping platform with transactional checkout, REST APIs and courier tracking.',
      technologies: ['JavaScript', 'Node.js', 'Express.js', 'MySQL'],
      category: 'Web',
      icon: Icons.shopping_bag_rounded,
      github: 'https://github.com/reezmahanan/STYLEO-Ceylon',
      image: 'assets/reezma/images/projects/styleo.png',
      live: 'https://project-01-nu-ruddy.vercel.app/',
    ),
    _Project(
      title: 'Electricity Consumption Prediction',
      subtitle: 'Machine Learning Forecasting',
      description:
          'A machine learning forecasting system using Sri Lankan residential smart meter data.',
      technologies: ['Python', 'LightGBM', 'Scikit-Learn', 'Pandas'],
      category: 'AI/ML',
      icon: Icons.bolt_rounded,
      github:
          'https://github.com/reezmahanan/Electricity-Consumption-Prediction',
      image: 'assets/reezma/images/projects/electricity.png',
      result: 'R² Score: 93.1%',
    ),
    _Project(
      title: 'StudyScore AI',
      subtitle: 'Performance Prediction',
      description:
          'A machine learning predictive application for performance prediction using regression techniques.',
      technologies: ['Python', 'Scikit-Learn', 'NumPy', 'Streamlit'],
      category: 'AI/ML',
      icon: Icons.query_stats_rounded,
      github: 'https://github.com/reezmahanan/StudyScore-AI',
    ),
  ];

  static const _categoryColors = <String, Color>{
    'Web': _P.cyan,
    'Mobile': _P.emerald,
    'AI/ML': _P.violet,
  };

  @override
  Widget build(BuildContext context) {
    const filters = ['All', 'Web', 'Mobile', 'AI/ML'];
    final projects = _projects
        .asMap()
        .entries
        .where(
          (e) => selectedFilter == 'All' || e.value.category == selectedFilter,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) {
              final sel = selectedFilter == f;
              final color = _categoryColors[f] ?? _P.cyan;
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
                      color: sel ? color.withValues(alpha: 0.15) : _P.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: sel ? color.withValues(alpha: 0.5) : _P.divider,
                      ),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        color: sel ? color : _P.textMuted,
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
                  for (var i = 0; i < projects.length; i++) ...[
                    _ProjectCard(
                      project: projects[i].value,
                      index: projects[i].key,
                      expanded: expandedProjects.contains(projects[i].key),
                      onExpand: () => onExpand(projects[i].key),
                      onLink: onLink,
                    ),
                    if (i != projects.length - 1) const SizedBox(height: 12),
                  ],
                ],
              );
            }
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: projects
                  .map(
                    (e) => SizedBox(
                      width: (constraints.maxWidth - 12) / 2,
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
          label: 'View All Projects on GitHub',
          icon: Icons.open_in_new_rounded,
          onTap: () =>
              onLink('https://github.com/reezmahanan?tab=repositories'),
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
    this.image,
    this.live,
    this.result,
  });
  final String title;
  final String subtitle;
  final String description;
  final List<String> technologies;
  final String category;
  final IconData icon;
  final String github;
  final String? image;
  final String? live;
  final String? result;
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

  static const _catColors = <String, Color>{
    'Web': _P.cyan,
    'Mobile': _P.emerald,
    'AI/ML': _P.violet,
  };

  @override
  Widget build(BuildContext context) {
    final accent = _catColors[project.category] ?? _P.cyan;

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
        decoration: BoxDecoration(
          color: _P.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accent.withValues(alpha: 0.1)),
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: project.image == null
                    ? _ProjectImageFallback(
                        title: project.title,
                        icon: project.icon,
                        accent: accent,
                      )
                    : Image.asset(
                        project.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _ProjectImageFallback(
                          title: project.title,
                          icon: project.icon,
                          accent: accent,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: accent.withValues(alpha: 0.2),
                          ),
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
                                color: _P.textPri,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              project.subtitle,
                              style: TextStyle(
                                color: accent.withValues(alpha: 0.85),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          project.category,
                          style: TextStyle(
                            color: accent,
                            fontSize: 9,
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
                      color: _P.textSec,
                      height: 1.5,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.technologies
                        .map((t) => _TechChip(t))
                        .toList(),
                  ),
                  if (project.result != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _P.emerald.withValues(alpha: 0.1),
                            _P.cyan.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _P.emerald.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.insights_rounded,
                            size: 14,
                            color: _P.emerald,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            project.result!,
                            style: const TextStyle(
                              color: _P.emerald,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _ProjBtn(
                        label: 'GitHub',
                        icon: Icons.code_rounded,
                        color: _P.textSec,
                        onTap: () => onLink(project.github),
                      ),
                      if (project.live != null) ...[
                        const SizedBox(width: 8),
                        _ProjBtn(
                          label: 'Live Demo',
                          icon: Icons.open_in_new_rounded,
                          color: accent,
                          filled: true,
                          onTap: () => onLink(project.live!),
                        ),
                      ],
                      const Spacer(),
                      InkWell(
                        onTap: onExpand,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            expanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 20,
                            color: _P.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (expanded) ...[
                    const SizedBox(height: 10),
                    const Divider(color: _P.divider, height: 1),
                    const SizedBox(height: 10),
                    Text(
                      'Category: ${project.category}',
                      style: const TextStyle(color: _P.textMuted, fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjBtn extends StatelessWidget {
  const _ProjBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.filled = false,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final isGitHub = label == 'GitHub';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: filled ? color.withValues(alpha: 0.12) : _P.elevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: filled ? color.withValues(alpha: 0.3) : _P.divider,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isGitHub)
              _TechLogo(asset: 'assets/reezma/svgs/github.svg', size: 14)
            else
              Icon(icon, size: 14, color: filled ? color : _P.textSec),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: filled ? color : _P.textSec,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final logo = _technologyAsset(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: _P.elevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _P.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (logo != null) ...[
            _TechLogo(asset: logo, size: 13),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: const TextStyle(
              color: _P.textSec,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

String? _technologyAsset(String name) {
  const assets = <String, String>{
    'Java': 'java',
    'Python': 'python',
    'JavaScript': 'javascript',
    'TypeScript': 'typescript',
    'Dart': 'dart',
    'React': 'react',
    'React.js': 'react',
    'Next.js': 'nextjs',
    'Angular': 'angular',
    'Spring Boot': 'springboot',
    'Node.js': 'nodejs',
    'Express.js': 'express',
    'Laravel': 'laravel',
    'Flutter': 'flutter',
    'Firebase': 'firebase',
    'Firestore': 'firebase',
    'MySQL': 'mysql',
    'MongoDB': 'mongodb',
    'Docker': 'docker',
    'Git': 'git',
    'GitHub': 'github',
    'HTML5': 'html5',
    'CSS3': 'css',
    'CSS': 'css',
    'Tailwind CSS': 'tailwindcss',
    'Bootstrap': 'bootstrap',
    'Figma': 'figma',
    'PHP': 'php',
    'C': 'c',
    'Scikit-Learn': 'scikitlearn',
    'LightGBM': 'lightgbm',
    'Pandas': 'pandas',
    'NumPy': 'numpy',
    'Kaggle': 'kaggle',
    'AWS': 'aws',
    'Microsoft Azure': 'azure',
    'Linux': 'linux',
    'npm': 'npm',
    'Postman': 'postman',
    'IntelliJ IDEA': 'intellij',
    'VS Code': 'vscode',
    'Selenium': 'selenium',
    'Google Colab': 'colab',
    'Adobe Photoshop': 'photoshop',
    'Adobe Illustrator': 'illustrator',
    'Canva': 'canva',
    'Arduino': 'arduino',
    'ATmega32': 'atmega32',
    'Tinkercad': 'tinkercad',
    'ThingSpeak': 'thingspeak',
    'Streamlit': 'streamlit',
  };
  final slug = assets[name];
  return slug == null ? null : 'assets/reezma/svgs/$slug.svg';
}

class _TechLogo extends StatelessWidget {
  const _TechLogo({required this.asset, required this.size});
  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

class _ProjectImageFallback extends StatelessWidget {
  const _ProjectImageFallback({
    required this.title,
    required this.icon,
    required this.accent,
  });
  final String title;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.24),
            _P.violet.withValues(alpha: 0.10),
            _P.surface,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            bottom: -28,
            child: Icon(icon, size: 150, color: accent.withValues(alpha: 0.10)),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: accent.withValues(alpha: 0.28)),
                  ),
                  child: Icon(icon, color: accent, size: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: _P.textPri,
                    fontSize: 18,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _P.cyan.withValues(alpha: 0.3)),
          gradient: LinearGradient(
            colors: [
              _P.cyan.withValues(alpha: 0.08),
              _P.violet.withValues(alpha: 0.08),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: _P.cyan),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: _P.cyan,
                fontWeight: FontWeight.w700,
                fontSize: 13,
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
          title: 'Professional Certifications',
          icon: Icons.workspace_premium_outlined,
          gradient: _P.gradCyan,
          expanded: expandedSections.contains('certifications'),
          onTap: () => onToggle('certifications'),
          child: const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CertificateAsset(
                'AIML Engineer stage 1.png',
                'AI/ML Engineer — Stage 1',
              ),
              _CertificateAsset(
                'ai ml engineer stage 2.png',
                'AI/ML Engineer — Stage 2',
              ),
              _CertificateAsset(
                'ai ml engineer stage 3.png',
                'AI/ML Engineer — Stage 3',
              ),
              _CertificateAsset(
                'FrontendDeveloper (React).png',
                'HackerRank — React',
              ),
              _CertificateAsset('Node.js(Basic).png', 'HackerRank — Node.js'),
              _CertificateAsset('java basic.png', 'HackerRank — Java'),
              _CertificateAsset('sql basic.png', 'HackerRank — SQL'),
              _CertificateAsset('css basic.png', 'HackerRank — CSS'),
              _CertificateAsset(
                'Introduction to git.png',
                'Introduction to Git',
              ),
              _CertificateAsset(
                'introduction to github co pilot.png',
                'GitHub Copilot',
              ),
              _CertificateAsset(
                'describe cloud computing.png',
                'Microsoft — Cloud Computing',
              ),
              _CertificateAsset(
                'introduction to ai concepts.png',
                'Microsoft — AI Concepts',
              ),
              _CertificateAsset(
                'front end web develoment.png',
                'Front-End Web Development',
              ),
              _CertificateAsset(
                'Python for beginners.png',
                'Python for Beginners',
              ),
              _CertificateAsset(
                'web design for beginners.png',
                'Web Design for Beginners',
              ),
              _CertificateAsset(
                'Machile Learning using python.png',
                'Machine Learning Using Python',
              ),
              _CertificateAsset(
                'agile scrum fountation.png',
                'Agile Scrum Foundation',
              ),
              _CertificateAsset('oops in java.png', 'OOP in Java'),
              _CertificateAsset(
                'introduction to cloud computing.png',
                'Introduction to Cloud Computing',
              ),
              _CertificateAsset(
                'introduction to cyber security.png',
                'Introduction to Cyber Security',
              ),
              _CertificateAsset(
                'introduction to genarative AI badge.png',
                'Introduction to Generative AI',
              ),
              _CertificateAsset(
                'docker for beginners.png',
                'Docker for Beginners',
              ),
              _CertificateAsset(
                'cyber security essentials.png',
                'Cyber Security Essentials',
              ),
              _CertificateAsset(
                'introductio to cybersecurity-cisco.png',
                'Cisco Cyber Security',
              ),
              _CertificateAsset(
                'ui ux for beginners.png',
                'UI/UX for Beginners',
              ),
              _CertificateAsset('introduction to html.png', 'HTML'),
              _CertificateAsset('my sql tutorial.png', 'MySQL Tutorial'),
              _CertificateAsset('programing basics.png', 'Programming Basics'),
              _CertificateAsset(
                'Pythonfuntamentals for beginners.png',
                'Python Fundamentals',
              ),
              _CertificateAsset(
                'python project for beginners.png',
                'Python Project for Beginners',
              ),
              _CertificateAsset(
                'introductiom to git with github.png',
                'Git and GitHub',
              ),
              _CertificateAsset(
                'cisco introduction to cyber security badge.png',
                'Cisco — Cyber Security Badge',
              ),
              _CertificateAsset(
                'cyber securty essential badges.png',
                'Cyber Security Essential Badges',
              ),
              _CertificateAsset(
                'frontend development-html.png',
                'Front-End Development — HTML',
              ),
              _CertificateAsset(
                'github for beginners badge.png',
                'GitHub for Beginners Badge',
              ),
              _CertificateAsset(
                'indrouction to python.png',
                'Introduction to Python',
              ),
              _CertificateAsset(
                'introduction to css.png',
                'Introduction to CSS',
              ),
              _CertificateAsset(
                'introduction to java.png',
                'Introduction to Java',
              ),
              _CertificateAsset(
                'introduction to sql.png',
                'Introduction to SQL',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Open Source Contributions',
          icon: Icons.volunteer_activism_outlined,
          gradient: _P.gradViolet,
          expanded: expandedSections.contains('opensource'),
          onTap: () => onToggle('opensource'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TimelineItem(
                'SWOC',
                'Social Winter of Code',
                'SafeHaven',
                'https://github.com/archangel2006/SafeHaven',
              ),
              const _TimelineItem(
                'OSCG',
                'Open Source Connect Global',
                'Blockchain Evidence',
                'https://github.com/Gooichand/blockchain-evidence',
              ),
              const _TimelineItem(
                'SSOC',
                'Social Summer of Code',
                'E-commerce',
                'https://github.com/AnthropicBots/E-commerce.git',
              ),
              const _TimelineItem(
                'GSSOC',
                'GirlScript Summer of Code',
                'EaseMotion CSS',
                'https://github.com/SAPTARSHI-coder/EaseMotion-css.git',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Leadership Experience',
          icon: Icons.leaderboard_outlined,
          gradient: _P.gradEmerald,
          expanded: expandedSections.contains('leadership'),
          onTap: () => onToggle('leadership'),
          child: const Column(
            children: [
              _LeadershipItem(
                'Lead Architecture',
                'SCM Inventory Management System',
              ),
              _LeadershipItem('Team Lead', 'Book Nest'),
              _LeadershipItem('Team Leader', 'Smart Home Automation'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Contact Information',
          icon: Icons.contact_page_outlined,
          gradient: _P.gradCyan,
          expanded: expandedSections.contains('contact'),
          onTap: () => onToggle('contact'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DetailRow(
                Icons.email_outlined,
                'Email',
                'reezmahanan@gmail.com',
              ),
              const _DetailRow(
                Icons.location_on_outlined,
                'Location',
                'Oddamavadi, Batticaloa, Sri Lanka',
              ),
              const _DetailRow(
                Icons.phone_outlined,
                'Phone',
                '+94 74 121 8316',
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: onCopyEmail,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: _P.cyan.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _P.cyan.withValues(alpha: 0.25)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.copy_rounded, size: 15, color: _P.cyan),
                      SizedBox(width: 7),
                      Text(
                        'Copy Email',
                        style: TextStyle(
                          color: _P.cyan,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Professional Links',
          icon: Icons.alternate_email_rounded,
          gradient: _P.gradViolet,
          expanded: expandedSections.contains('links'),
          onTap: () => onToggle('links'),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _LinkBtn(
                'GitHub',
                Icons.code_rounded,
                () => onLink('https://github.com/reezmahanan'),
                _P.textSec,
              ),
              _LinkBtn(
                'LinkedIn',
                Icons.work_outline_rounded,
                () => onLink('https://www.linkedin.com/in/reezma-hanan'),
                _P.cyan,
              ),
              _LinkBtn(
                'Portfolio',
                Icons.language_rounded,
                () => onLink('https://portfolio-website-7mdi.vercel.app/'),
                _P.emerald,
              ),
              _LinkBtn(
                'HackerRank',
                Icons.terminal_rounded,
                () => onLink('https://www.hackerrank.com/profile/reezmahanan'),
                _P.violet,
              ),
              _LinkBtn(
                'Medium',
                Icons.article_outlined,
                () => onLink('https://medium.com/@reezmahanan'),
                _P.textSec,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Shared Components ─────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.child,
    this.accent = _P.cyan,
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
        color: _P.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.08)),
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
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 17, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _P.textPri,
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
    this.gradient = _P.gradCyan,
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
        color: _P.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _P.cyan.withValues(alpha: 0.07)),
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
                        color: _P.textPri,
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
                      color: _P.textMuted,
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
                      const Divider(color: _P.divider, height: 1),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                        child: child,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
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
              color: _P.cyan.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: _P.cyan),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _P.textPri,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: _P.textSec,
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
  const _Chip(this.label, this.icon, {this.size = 14});
  final String label;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final logo = _technologyAsset(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _P.chip,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _P.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (logo != null)
            _TechLogo(asset: logo, size: size)
          else
            Icon(icon, size: size, color: _P.cyan.withValues(alpha: 0.8)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _P.textSec,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CertificateAsset extends StatelessWidget {
  const _CertificateAsset(this.fileName, this.label);
  final String fileName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: InkWell(
        onTap: () => showDialog<void>(
          context: context,
          barrierColor: Colors.black87,
          builder: (_) => Dialog(
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: _P.surface,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900, maxHeight: 700),
              child: InteractiveViewer(
                minScale: 0.8,
                maxScale: 5,
                child: Image.asset(
                  'assets/reezma/certificates/$fileName',
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const SizedBox(
                    height: 240,
                    child: Center(
                      child: Icon(
                        Icons.workspace_premium_outlined,
                        size: 64,
                        color: _P.cyan,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _P.elevated,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _P.divider),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/reezma/certificates/$fileName',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: _P.chip,
                      child: Center(
                        child: Icon(
                          Icons.workspace_premium_outlined,
                          color: _P.cyan,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _P.textSec,
                  fontSize: 10,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem(this.code, this.organization, this.project, this.url);
  final String code;
  final String organization;
  final String project;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _P.elevated,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: _P.violet.withValues(alpha: 0.6), width: 3),
        ),
      ),
      child: InkWell(
        onTap: url == null
            ? null
            : () async => launchUrl(
                Uri.parse(url!),
                mode: LaunchMode.externalApplication,
              ),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _P.violet.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _P.violet.withValues(alpha: 0.2)),
                ),
                alignment: Alignment.center,
                child: Text(
                  code,
                  style: const TextStyle(
                    color: _P.violet,
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      organization,
                      style: const TextStyle(
                        color: _P.textPri,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      project,
                      style: const TextStyle(color: _P.textSec, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (url != null)
                const Icon(
                  Icons.open_in_new_rounded,
                  size: 15,
                  color: _P.textMuted,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeadershipItem extends StatelessWidget {
  const _LeadershipItem(this.role, this.project);
  final String role;
  final String project;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _P.elevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _P.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: _P.emerald.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.verified_rounded,
              size: 17,
              color: _P.emerald,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, height: 1.4),
                children: [
                  TextSpan(
                    text: '$role — ',
                    style: const TextStyle(
                      color: _P.textPri,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: project,
                    style: const TextStyle(color: _P.textSec),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkBtn extends StatelessWidget {
  const _LinkBtn(this.label, this.icon, this.onTap, this.color);
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
