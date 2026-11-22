import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Member1Screen extends StatefulWidget {
  const Member1Screen({super.key});

  @override
  State<Member1Screen> createState() => _Member1ScreenState();
}

class _Member1ScreenState extends State<Member1Screen> {
  static const _background = Color(0xFF080F1E);

  int _selectedTab = 0;
  String _projectFilter = 'All';
  final Set<int> _expandedProjects = {};
  final Set<String> _expandedMore = {};

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Link could not be opened');
      }
    } catch (_) {
      if (!mounted) return;
      _showSnack('Could not open the link.');
    }
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(const ClipboardData(text: 'reezmahanan@gmail.com'));
    if (!mounted) return;
    _showSnack('Email address copied.');
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _showPhoto() {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: const Color(0xFF0B1528),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520, maxHeight: 620),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              InteractiveViewer(
                minScale: 0.8,
                maxScale: 4,
                child: Image.asset(
                  'assets/images/reezma.jpg',
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const SizedBox(
                    height: 420,
                    child: Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 120,
                        color: Color(0xFF2DD4BF),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xCC0B1528),
                    foregroundColor: Colors.white,
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
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1080),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          isWide ? 32 : 16,
                          12,
                          isWide ? 32 : 16,
                          12,
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
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1080),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWide ? 32 : 16,
                          vertical: 8,
                        ),
                        child: const _Statistics(),
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabHeaderDelegate(
                    height: 70,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWide ? 32 : 16,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1080),
                          child: _ProfileTabs(
                            selectedIndex: _selectedTab,
                            onSelected: (index) =>
                                setState(() => _selectedTab = index),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    isWide ? 32 : 16,
                    14,
                    isWide ? 32 : 16,
                    32,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1080),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          switchInCurve: Curves.easeOut,
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

  Widget _buildSelectedTab(bool isWide) {
    switch (_selectedTab) {
      case 1:
        return const _SkillsSection();
      case 2:
        return _ProjectsSection(
          isWide: isWide,
          selectedFilter: _projectFilter,
          expandedProjects: _expandedProjects,
          onFilter: (filter) => setState(() => _projectFilter = filter),
          onExpand: (index) => setState(() {
            if (_expandedProjects.contains(index)) {
              _expandedProjects.remove(index);
            } else {
              _expandedProjects.add(index);
            }
          }),
          onLink: _openLink,
        );
      case 3:
        return _MoreSection(
          expandedSections: _expandedMore,
          onToggle: (title) => setState(() {
            if (_expandedMore.contains(title)) {
              _expandedMore.remove(title);
            } else {
              _expandedMore.add(title);
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

  static const _card = Color(0xFF152238);
  static const _teal = Color(0xFF2DD4BF);
  static const _purple = Color(0xFFA78BFA);

  @override
  Widget build(BuildContext context) {
    final photo = GestureDetector(
      onTap: onPhotoTap,
      child: Tooltip(
        message: 'View profile photo',
        child: Container(
          width: 130,
          height: 130,
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_teal, _purple],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x402DD4BF),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _card,
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: Image.asset(
                'assets/images/reezma.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: _card,
                  child: Center(
                    child: Icon(Icons.person_rounded, size: 72, color: _teal),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final identity = Column(
      crossAxisAlignment: isWide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Reezma Hanan',
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
            height: 1,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Aspiring Software Engineer',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _teal,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Full-Stack Developer  •  AI/ML Enthusiast',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFB8C5D6), fontSize: 13),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 7,
          runSpacing: 7,
          children: const [
            _HeaderChip(Icons.badge_outlined, '23IT0480'),
            _HeaderChip(Icons.school_outlined, 'ITUM'),
            _HeaderChip(Icons.location_on_outlined, 'Batticaloa, Sri Lanka'),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            _SocialIcon(
              icon: Icons.code_rounded,
              tooltip: 'GitHub',
              onTap: () => onLink('https://github.com/reezmahanan'),
            ),
            _SocialIcon(
              icon: Icons.work_outline_rounded,
              tooltip: 'LinkedIn',
              onTap: () => onLink('https://www.linkedin.com/in/reezma-hanan'),
            ),
            _SocialIcon(
              icon: Icons.language_rounded,
              tooltip: 'Portfolio',
              onTap: () => onLink('https://portfolio-website-7mdi.vercel.app/'),
            ),
            _SocialIcon(
              icon: Icons.email_outlined,
              tooltip: 'Copy email',
              onTap: onEmailTap,
            ),
          ],
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 24 : 18),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: isWide
          ? Row(
              children: [
                photo,
                const SizedBox(width: 24),
                Expanded(child: identity),
              ],
            )
          : Column(children: [photo, const SizedBox(height: 16), identity]),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B45),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF2DD4BF)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF1B2B45),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class _Statistics extends StatelessWidget {
  const _Statistics();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width < 420
            ? 1
            : width < 680
            ? 3
            : 3;
        if (columns == 1) {
          return Column(
            children: const [
              _StatCard(
                '6',
                'Featured Projects',
                Icons.folder_special_outlined,
                Color(0xFF2DD4BF),
              ),
              SizedBox(height: 8),
              _StatCard(
                '15+',
                'Certifications',
                Icons.workspace_premium_outlined,
                Color(0xFFA78BFA),
              ),
              SizedBox(height: 8),
              _StatCard(
                '4',
                'Open Source Communities',
                Icons.hub_outlined,
                Color(0xFF60A5FA),
              ),
            ],
          );
        }
        return Row(
          children: const [
            Expanded(
              child: _StatCard(
                '6',
                'Featured Projects',
                Icons.folder_special_outlined,
                Color(0xFF2DD4BF),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                '15+',
                'Certifications',
                Icons.workspace_premium_outlined,
                Color(0xFFA78BFA),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                '4',
                'Open Source Communities',
                Icons.hub_outlined,
                Color(0xFF60A5FA),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.value, this.label, this.icon, this.accent);
  final String value;
  final String label;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 8 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF152238),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const SizedBox(width: 9),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 10,
                      height: 1.15,
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
    return ColoredBox(
      color: const Color(0xF0080F1E),
      child: Align(alignment: Alignment.bottomCenter, child: child),
    );
  }

  @override
  bool shouldRebuild(covariant _TabHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs({required this.selectedIndex, required this.onSelected});
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF152238),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: List.generate(_memberTabs.length, (index) {
              final tab = _memberTabs[index];
              final selected = selectedIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () => onSelected(index),
                  borderRadius: BorderRadius.circular(11),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF203452)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tab.$1,
                          size: 18,
                          color: selected
                              ? const Color(0xFF2DD4BF)
                              : const Color(0xFF94A3B8),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          tab.$2,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : const Color(0xFF94A3B8),
                            fontSize: 10,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
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
}

const _memberTabs = <(IconData, String)>[
  (Icons.person_outline_rounded, 'About'),
  (Icons.code_rounded, 'Skills'),
  (Icons.folder_special_outlined, 'Projects'),
  (Icons.grid_view_rounded, 'More'),
];

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= 760;
        final cards = [
          const _ContentCard(
            title: 'Professional Introduction',
            icon: Icons.person_outline_rounded,
            child: Text(
              'I am an Information Technology undergraduate at the Institute of Technology, University of Moratuwa (ITUM), Sri Lanka. I am passionate about full-stack software development, mobile application development, and machine learning.',
              style: TextStyle(color: Color(0xFFCBD5E1), height: 1.55),
            ),
          ),
          const _ContentCard(
            title: 'Personal Details',
            icon: Icons.badge_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(Icons.badge_outlined, 'Registration', '23IT0480'),
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
          const _ContentCard(
            title: 'Education',
            icon: Icons.school_outlined,
            child: _EducationTimeline(),
          ),
          const _ContentCard(
            title: 'Career Objective',
            icon: Icons.flag_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To become a skilled software engineer and full-stack developer by continuously learning, developing scalable software solutions, and contributing to innovative real-world projects.',
                  style: TextStyle(color: Color(0xFFCBD5E1), height: 1.55),
                ),
                SizedBox(height: 10),
                Text(
                  '"Learn continuously, build consistently, and engineer scalable solutions that matter."',
                  style: TextStyle(
                    color: Color(0xFF2DD4BF),
                    fontStyle: FontStyle.italic,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const _ContentCard(
            title: 'Soft Skills',
            icon: Icons.groups_outlined,
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
              ],
            ),
          ),
          const _ContentCard(
            title: 'Interests & Talents',
            icon: Icons.auto_awesome_outlined,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip('Full-Stack Development', Icons.language_outlined),
                _Chip('Mobile Applications', Icons.smartphone_outlined),
                _Chip('AI & Machine Learning', Icons.auto_graph_outlined),
                _Chip('Open Source', Icons.merge_outlined),
                _Chip('Creative Designing', Icons.palette_outlined),
                _Chip('UI/UX Design', Icons.design_services_outlined),
                _Chip('Cloud Computing', Icons.cloud_outlined),
                _Chip('DevOps', Icons.memory_outlined),
              ],
            ),
          ),
        ];

        if (!twoColumns) {
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 12),
                Expanded(child: cards[1]),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: cards[2]),
                const SizedBox(width: 12),
                Expanded(child: cards[3]),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: cards[4]),
                const SizedBox(width: 12),
                Expanded(child: cards[5]),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _EducationTimeline extends StatelessWidget {
  const _EducationTimeline();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: const Color(0xFF2DD4BF).withValues(alpha: 0.65),
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 14),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'National Diploma in Technology',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 5),
          Text(
            'Information Technology',
            style: TextStyle(
              color: Color(0xFF2DD4BF),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Institute of Technology, University of Moratuwa',
            style: TextStyle(color: Color(0xFF94A3B8), height: 1.4),
          ),
          SizedBox(height: 8),
          Text(
            'Currently pursuing higher education',
            style: TextStyle(color: Color(0xFFC4B5FD), fontSize: 12),
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
    const categories = <(IconData, String, List<String>)>[
      (
        Icons.code_rounded,
        'Programming Languages',
        ['Java', 'Python', 'JavaScript', 'TypeScript', 'Dart', 'PHP', 'C'],
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
      ),
      (
        Icons.dns_rounded,
        'Backend Development',
        ['Spring Boot', 'Node.js', 'Express.js', 'Laravel'],
      ),
      (
        Icons.phone_android_rounded,
        'Mobile Development',
        ['Flutter', 'Dart', 'Firebase'],
      ),
      (
        Icons.auto_awesome_rounded,
        'AI and Machine Learning',
        ['Scikit-Learn', 'LightGBM', 'Pandas', 'NumPy', 'Kaggle'],
      ),
      (Icons.storage_rounded, 'Databases', ['MySQL', 'MongoDB']),
      (
        Icons.cloud_outlined,
        'Cloud and DevOps',
        ['AWS', 'Microsoft Azure', 'Firebase', 'Docker', 'Linux'],
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
      ),
      (
        Icons.palette_outlined,
        'UI/UX and Designing',
        ['Figma', 'Adobe Photoshop', 'Adobe Illustrator', 'Canva'],
      ),
      (
        Icons.memory_outlined,
        'IoT and Hardware',
        ['Arduino', 'ATmega32', 'Tinkercad', 'ThingSpeak'],
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= 760;
        final cards = categories.map((category) {
          final title = category.$2;
          return _ExpandableCard(
            title: title,
            icon: category.$1,
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
              children: category.$3
                  .map((skill) => _Chip(skill, Icons.code_rounded))
                  .toList(),
            ),
          );
        }).toList();

        if (!twoColumns) {
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
                (card) => SizedBox(
                  width: (constraints.maxWidth - 12) / 2,
                  child: card,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

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
      result: 'Reported R² Score: 93.1%',
    ),
    _Project(
      title: 'StudyScore AI',
      subtitle: 'Performance Prediction',
      description:
          'A machine learning predictive application for house price and performance prediction using regression techniques.',
      technologies: ['Python', 'Scikit-Learn', 'NumPy', 'Streamlit'],
      category: 'AI/ML',
      icon: Icons.query_stats_rounded,
      github: 'https://github.com/reezmahanan/StudyScore-AI',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const filters = ['All', 'Web', 'Mobile', 'AI/ML'];
    final projects = _projects
        .asMap()
        .entries
        .where(
          (entry) =>
              selectedFilter == 'All' || entry.value.category == selectedFilter,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((filter) {
              final selected = selectedFilter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: selected,
                  onSelected: (_) => onFilter(filter),
                  selectedColor: const Color(0xFF203452),
                  backgroundColor: const Color(0xFF152238),
                  side: BorderSide.none,
                  labelStyle: TextStyle(
                    color: selected
                        ? const Color(0xFF2DD4BF)
                        : const Color(0xFF94A3B8),
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns = constraints.maxWidth >= 760;
            if (!twoColumns) {
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
                    (entry) => SizedBox(
                      width: (constraints.maxWidth - 12) / 2,
                      child: _ProjectCard(
                        project: entry.value,
                        index: entry.key,
                        expanded: expandedProjects.contains(entry.key),
                        onExpand: () => onExpand(entry.key),
                        onLink: onLink,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () =>
                onLink('https://github.com/reezmahanan?tab=repositories'),
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            label: const Text('View All Projects'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2DD4BF),
              side: const BorderSide(color: Color(0xFF2DD4BF)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 260 + (index * 35)),
      curve: Curves.easeOut,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: child,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF152238),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF203452),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          project.icon,
                          color: const Color(0xFF2DD4BF),
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              project.subtitle,
                              style: const TextStyle(
                                color: Color(0xFFA78BFA),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: onExpand,
                        tooltip: expanded
                            ? 'Collapse details'
                            : 'Expand details',
                        icon: Icon(
                          expanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.description,
                    style: const TextStyle(
                      color: Color(0xFFCBD5E1),
                      height: 1.45,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.technologies
                        .map((technology) => _TechnologyChip(technology))
                        .toList(),
                  ),
                  if (project.result != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A50),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        project.result!,
                        style: const TextStyle(
                          color: Color(0xFF67E8F9),
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                  if (expanded) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Category: ${project.category}',
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ProjectButton(
                        label: 'GitHub',
                        icon: Icons.code_rounded,
                        onTap: () => onLink(project.github),
                      ),
                      if (project.live != null)
                        _ProjectButton(
                          label: 'Live Demo',
                          icon: Icons.open_in_new_rounded,
                          outlined: true,
                          onTap: () => onLink(project.live!),
                        ),
                    ],
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

class _ProjectButton extends StatelessWidget {
  const _ProjectButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.outlined = false,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF2DD4BF),
          side: const BorderSide(color: Color(0xFF2DD4BF)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
    return FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF203452),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _TechnologyChip extends StatelessWidget {
  const _TechnologyChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B45),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFAFC0D4),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

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
          expanded: expandedSections.contains('certifications'),
          onTap: () => onToggle('certifications'),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CertGroup('SLIIT University', [
                'AI/ML Engineer – Stage 1',
                'AI/ML Engineer – Stage 2',
                'AI/ML Engineer – Stage 3',
              ]),
              _CertGroup('HackerRank', [
                'Frontend Developer React',
                'Node.js (Basic)',
                'Java',
                'Python',
                'SQL',
                'JavaScript',
                'CSS',
                'Angular',
              ]),
              _CertGroup('Microsoft', [
                'Introduction to Git',
                'Introduction to GitHub Copilot',
                'Describe Cloud Computing',
                'Introduction to AI Concepts',
              ]),
              _CertGroup('University of Moratuwa – CODL', [
                'Front-End Web Development',
                'Python for Beginners',
                'Web Design for Beginners',
              ]),
              _CertGroup('Simplilearn', [
                'Machine Learning Using Python',
                'Agile Scrum Foundation',
                'OOPs in Java',
                'Introduction to Cloud Computing',
                'Introduction to Cyber Security',
              ]),
              _CertGroup('Google Cloud', ['Introduction to Generative AI']),
              _CertGroup('KodeKloud', ['Docker for Absolute Beginners']),
              _CertGroup('The Linux Foundation', [
                'Cyber Security Essential (LFC108)',
              ]),
              _CertGroup('Cisco Networking Academy', ['Cyber Security']),
              _CertGroup('Great Learning Academy', [
                'UI/UX for Beginners',
                'HTML',
                'MySQL Tutorial',
                'Programming Basics',
                'Python Fundamentals',
                'Python Project for Beginners',
              ]),
              _CertGroup('Udemy', ['Hands-On Introduction to Git with GitHub']),
              _CertGroup('SoloLearn', [
                'Java',
                'SQL',
                'HTML',
                'CSS',
                'Python for Beginners',
                'Introduction to C',
                'Angular'
              ]),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Open Source Contributions',
          icon: Icons.volunteer_activism_outlined,
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
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: onCopyEmail,
                icon: const Icon(Icons.copy_rounded, size: 17),
                label: const Text('Copy Email'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2DD4BF),
                  side: const BorderSide(color: Color(0xFF2DD4BF)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ExpandableCard(
          title: 'Professional Links',
          icon: Icons.alternate_email_rounded,
          expanded: expandedSections.contains('links'),
          onTap: () => onToggle('links'),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _LinkButton(
                'GitHub',
                Icons.code_rounded,
                () => onLink('https://github.com/reezmahanan'),
              ),
              _LinkButton(
                'LinkedIn',
                Icons.work_outline_rounded,
                () => onLink('https://www.linkedin.com/in/reezma-hanan'),
              ),
              _LinkButton(
                'Portfolio',
                Icons.language_rounded,
                () => onLink('https://portfolio-website-7mdi.vercel.app/'),
              ),
              _LinkButton(
                'HackerRank',
                Icons.terminal_rounded,
                () => onLink('https://www.hackerrank.com/profile/reezmahanan'),
              ),
              _LinkButton(
                'Medium',
                Icons.article_outlined,
                () => onLink('https://medium.com/@reezmahanan'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentCard extends StatelessWidget {
  const _ContentCard({
    required this.title,
    required this.icon,
    required this.child,
  });
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF152238),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 19, color: const Color(0xFF2DD4BF)),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
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

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: const Color(0xFF2DD4BF)),
          const SizedBox(width: 9),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  height: 1.35,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: '$label\n',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: value),
                ],
              ),
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
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B45),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF2DD4BF)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFD6E1EC),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
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
  });
  final String title;
  final IconData icon;
  final bool expanded;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF152238),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(icon, size: 19, color: const Color(0xFF2DD4BF)),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF94A3B8),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: child,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _CertGroup extends StatelessWidget {
  const _CertGroup(this.organization, this.certificates);
  final String organization;
  final List<String> certificates;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B45),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            organization,
            style: const TextStyle(
              color: Color(0xFF2DD4BF),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 7),
          for (final certificate in certificates)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: Color(0xFF94A3B8))),
                  Expanded(
                    child: Text(
                      certificate,
                      style: const TextStyle(
                        color: Color(0xFFCBD5E1),
                        height: 1.35,
                        fontSize: 11,
                      ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B45),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: const Color(0xFFA78BFA).withValues(alpha: 0.8),
            width: 2,
          ),
        ),
      ),
      child: InkWell(
        onTap: url == null
            ? null
            : () async {
                await launchUrl(
                  Uri.parse(url!),
                  mode: LaunchMode.externalApplication,
                );
              },
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFA78BFA).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                code,
                style: const TextStyle(
                  color: Color(0xFFC4B5FD),
                  fontWeight: FontWeight.w800,
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
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    project,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (url != null)
              const Icon(
                Icons.open_in_new_rounded,
                size: 16,
                color: Color(0xFF2DD4BF),
              ),
          ],
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
        color: const Color(0xFF1B2B45),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_rounded,
            size: 18,
            color: Color(0xFF2DD4BF),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  height: 1.35,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: '$role — ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: project),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton(this.label, this.icon, this.onTap);
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF2DD4BF),
        side: const BorderSide(color: Color(0xFF155E75)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
