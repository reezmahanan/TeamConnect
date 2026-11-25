import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Member4Screen extends StatelessWidget {
  const Member4Screen({super.key});

  static const _ink = Color(0xFF1E3029);
  static const _forest = Color(0xFF285B48);
  static const _sage = Color(0xFFE4EBDD);
  static const _paper = Color(0xFFF7F5EF);
  static const _muted = Color(0xFF69766F);

  Future<void> _openLink(BuildContext context, String value) async {
    final uri = Uri.parse(value);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open this link.')),
      );
    }
  }

  void _showProfilePhoto(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        backgroundColor: _forest,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480, maxHeight: 580),
          child: SizedBox(
            width: MediaQuery.sizeOf(dialogContext).width * 0.85,
            height: MediaQuery.sizeOf(dialogContext).height * 0.75,
            child: Stack(
              children: [
                Positioned.fill(
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 4,
                    child: Image.asset(
                      'assets/inthumathy/images/profile/inthumathy.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    tooltip: 'Close photo',
                    style: IconButton.styleFrom(
                      backgroundColor: _forest.withValues(alpha: 0.85),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(dialogContext),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _paper,
        foregroundColor: _ink,
        title: const Text(
          'TeamConnect / Profile',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _hero(context),
                  const SizedBox(height: 28),
                  const _SectionHeading(
                    number: '01',
                    title: 'A little about me',
                  ),
                  const SizedBox(height: 12),
                  const _PaperCard(
                    child: Text(
                      'I am an ambitious Information Technology undergraduate '
                      'at the Institute of Technology, University of Moratuwa. '
                      'I enjoy building practical software and bring experience '
                      'in coding, database management, and 3D modelling. I am '
                      'fluent in English and Tamil, with functional Sinhala.',
                      style: TextStyle(
                        color: _muted,
                        height: 1.65,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SectionHeading(
                    number: '02',
                    title: 'Experience & education',
                  ),
                  const SizedBox(height: 12),
                  const _TimelineCard(
                    title: 'NDT in Information Technology',
                    organization:
                        'Institute of Technology, University of Moratuwa',
                    period: '2024 – Present · Education',
                    details:
                        'Studying software engineering, databases, computer '
                        'networks, and enterprise application architectures.',
                    icon: Icons.school_outlined,
                  ),
                  const SizedBox(height: 10),
                  const _TimelineCard(
                    title: 'Advanced Level & Ordinary Level Studies',
                    organization: "J/Methodist Girls' High School",
                    period: 'Secondary education',
                    details:
                        'Built a strong scientific and analytical foundation '
                        'for further studies in information technology.',
                    icon: Icons.menu_book_outlined,
                  ),
                  const SizedBox(height: 10),
                  const _TimelineCard(
                    title: 'Teacher',
                    organization: 'Study Point (PVT) LTD',
                    period: 'Professional experience',
                    details:
                        'Taught and mentored young learners and prepared course '
                        'materials, strengthening public-speaking skills.',
                    icon: Icons.cast_for_education_outlined,
                  ),
                  const SizedBox(height: 10),
                  const _TimelineCard(
                    title: 'Clerk',
                    organization: "Lawyer's Office",
                    period: 'Administrative experience',
                    details:
                        'Handled documentation, case sorting, customer '
                        'scheduling, and formal communication.',
                    icon: Icons.work_outline_rounded,
                  ),
                  const SizedBox(height: 28),
                  const _SectionHeading(
                    number: '03',
                    title: 'Tools in my toolkit',
                  ),
                  const SizedBox(height: 12),
                  const _PaperCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SkillGroup(
                          title: 'Languages',
                          skills: [
                            'Java',
                            'Python',
                            'PHP',
                            'JavaScript',
                            'HTML',
                            'CSS',
                            'SQL',
                          ],
                        ),
                        SizedBox(height: 18),
                        _SkillGroup(
                          title: 'Frameworks & tools',
                          skills: [
                            'Spring Boot',
                            'Django',
                            'React',
                            'Vite',
                            'MySQL Workbench',
                            'Blender',
                            'Photoshop',
                            'draw.io',
                            'MS Office',
                          ],
                        ),
                        SizedBox(height: 18),
                        _SkillGroup(
                          title: 'Languages I speak',
                          skills: [
                            'English · Professional',
                            'Tamil · Native',
                            'Sinhala · Functional',
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SectionHeading(number: '04', title: 'How I can help'),
                  const SizedBox(height: 12),
                  const _ServiceCard(
                    title: 'Web design & development',
                    description:
                        'Responsive user interfaces with backend integrations.',
                    technologies:
                        'React · PHP · Python · HTML · CSS · JavaScript',
                    icon: Icons.web_rounded,
                  ),
                  const SizedBox(height: 10),
                  const _ServiceCard(
                    title: 'Enterprise software',
                    description:
                        'Layered applications, backend infrastructure, and REST APIs.',
                    technologies: 'Java Spring Boot · Django REST',
                    icon: Icons.account_tree_outlined,
                  ),
                  const SizedBox(height: 10),
                  const _ServiceCard(
                    title: '3D modelling & animation',
                    description:
                        'Custom models, textures, animation, and optimized assets.',
                    technologies: 'Blender',
                    icon: Icons.view_in_ar_outlined,
                  ),
                  const SizedBox(height: 10),
                  const _ServiceCard(
                    title: 'Database design & management',
                    description:
                        'Relational schemas, SQL queries, CRUD operations, and indexing.',
                    technologies: 'MySQL · SQL',
                    icon: Icons.storage_rounded,
                  ),
                  const SizedBox(height: 28),
                  const _SectionHeading(number: '05', title: 'Selected work'),
                  const SizedBox(height: 12),
                  _ProjectCard(
                    category: 'SOLO PROJECT · WEB',
                    title: 'Little Nest',
                    imageAsset:
                        'assets/inthumathy/images/projects/Little Nest.jpeg',
                    description:
                        'A responsive website for a childcare and early learning '
                        'center. It helps parents explore childcare services, '
                        'early learning programs, daily activities, and the '
                        'center’s caring environment.',
                    tags: const [
                      'Responsive design',
                      'Childcare services',
                      'Early learning',
                    ],
                    onTap: () => _openLink(
                      context,
                      'https://github.com/Inthumathy/Little-nest.git',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ProjectCard(
                    category: 'SOLO PROJECT · WEB',
                    title: 'Student Event Management System',
                    description:
                        'A university events app with registrations, admin CRUD '
                        'dashboards, participant tracking, and statistics.',
                    tags: const ['PHP', 'MySQL', 'JavaScript', 'Bootstrap'],
                    onTap: () => _openLink(
                      context,
                      'https://github.com/Inthumathy/Student_Event_Management_System',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ProjectCard(
                    category: 'GROUP PROJECT · FULL STACK',
                    title: 'Order & Billing Management System',
                    description:
                        'A sales and inventory platform with customer records, '
                        'invoice billing, and order workflows. Contributed to '
                        'integration and team communications.',
                    tags: const ['React', 'Spring Boot', 'REST API', 'MySQL'],
                    onTap: () => _openLink(
                      context,
                      'https://github.com/Tharaka-Jayampathi/SCM_Order_-_Billing_Module',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ProjectCard(
                    category: 'GROUP PROJECT · DJANGO',
                    title: 'Online Auction & E-Commerce',
                    description:
                        'A web platform with customer accounts, product '
                        'catalogs, timed bidding, and shopping-cart checkout.',
                    tags: const ['Django', 'Python', 'SQLite', 'Bootstrap'],
                    onTap: () => _openLink(
                      context,
                      'https://github.com/dinathsv/auction_shop',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ProjectCard(
                    category: 'AI-POWERED · EMERGENCY COORDINATION',
                    title: 'ResQAI',
                    imageAsset:
                        'assets/inthumathy/images/projects/ResQ AI.jpeg',
                    description:
                        'An AI-powered emergency coordination platform that '
                        'connects users, volunteers, and administrators through '
                        'real-time alerts, emergency reporting, and intelligent '
                        'disaster response support.',
                    tags: [
                      'Emergency reporting',
                      'Real-time alerts',
                      'Disaster response',
                    ],
                    onTap: () => _openLink(
                      context,
                      'https://github.com/dinathsv/resqai-platform.git',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ProjectCard(
                    category: 'FULL-STACK · MANAGEMENT SYSTEM',
                    title: 'Hardware Store Management',
                    imageAsset:
                        'assets/inthumathy/images/projects/Hardware store.jpeg',
                    description:
                        'A full-stack hardware store management system that '
                        'simplifies product management, inventory tracking, '
                        'customer purchases, and repair service bookings through '
                        'a user-friendly web application.',
                    tags: [
                      'Product management',
                      'Inventory tracking',
                      'Customer purchases',
                      'Repair bookings',
                    ],
                    onTap: () => _openLink(
                      context,
                      'https://github.com/Inthumathy/Hardware-Store.git',
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SectionHeading(
                    number: '06',
                    title: 'Certificates & learning',
                  ),
                  const SizedBox(height: 12),
                  const _CertificateGallery(),
                  const SizedBox(height: 28),
                  _contactCard(context),
                  const SizedBox(height: 18),
                  const Center(
                    child: Text(
                      'INTHUMATHY VEERASEGARAM  ·  23IT0485',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 11,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: _forest,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'INFORMATION TECHNOLOGY · NDT',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Semantics(
                label: 'View larger profile photo',
                button: true,
                child: InkWell(
                  onTap: () => _showProfilePhoto(context),
                  borderRadius: BorderRadius.circular(22),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(
                      'assets/inthumathy/images/profile/inthumathy.jpg',
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 68,
                        height: 68,
                        alignment: Alignment.center,
                        color: _sage,
                        child: const Text(
                          'IV',
                          style: TextStyle(
                            color: _forest,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Inthumathy\nVeerasegaram',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Student developer building thoughtful, full-stack solutions.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              height: 1.5,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HeroAction(
                label: 'Email',
                icon: Icons.mail_outline_rounded,
                onTap: () =>
                    _openLink(context, 'mailto:mathyinthu613@gmail.com'),
              ),
              _HeroAction(
                label: 'LinkedIn',
                icon: Icons.open_in_new_rounded,
                onTap: () => _openLink(
                  context,
                  'https://www.linkedin.com/in/inthumathy-veerasegaram-924640240',
                ),
              ),
              _HeroAction(
                label: 'GitHub',
                icon: Icons.code_rounded,
                onTap: () =>
                    _openLink(context, 'https://github.com/Inthumathy'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _sage,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Have a project in mind?',
            style: TextStyle(
              color: _ink,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Open to collaboration, project inquiries, and new ideas.',
            style: TextStyle(color: _muted, height: 1.5),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () =>
                _openLink(context, 'mailto:mathyinthu613@gmail.com'),
            style: FilledButton.styleFrom(
              backgroundColor: _forest,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            ),
            icon: const Icon(Icons.send_rounded, size: 17),
            label: const Text('Get in touch'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.number, required this.title});

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Member4Screen._forest,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Member4Screen._ink,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaperCard extends StatelessWidget {
  const _PaperCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9E7DF)),
      ),
      child: child,
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.title,
    required this.organization,
    required this.period,
    required this.details,
    required this.icon,
  });

  final String title;
  final String organization;
  final String period;
  final String details;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Member4Screen._sage,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Member4Screen._forest, size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  period.toUpperCase(),
                  style: const TextStyle(
                    color: Member4Screen._forest,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    color: Member4Screen._ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  organization,
                  style: const TextStyle(
                    color: Member4Screen._muted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  details,
                  style: const TextStyle(
                    color: Member4Screen._muted,
                    height: 1.5,
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

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.title,
    required this.description,
    required this.technologies,
    required this.icon,
  });

  final String title;
  final String description;
  final String technologies;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Member4Screen._forest, size: 23),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Member4Screen._ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Member4Screen._muted,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  technologies,
                  style: const TextStyle(
                    color: Member4Screen._forest,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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

class _SkillGroup extends StatelessWidget {
  const _SkillGroup({required this.title, required this.skills});

  final String title;
  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Member4Screen._muted,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 9),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3EE),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(
                      color: Member4Screen._ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.category,
    required this.title,
    required this.description,
    required this.tags,
    this.imageAsset,
    this.onTap,
  });

  final String category;
  final String title;
  final String description;
  final List<String> tags;
  final String? imageAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE9E7DF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageAsset != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    imageAsset!,
                    width: double.infinity,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 14),
              ],
              Row(
                children: [
                  Expanded(
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Member4Screen._forest,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.9,
                      ),
                    ),
                  ),
                  if (onTap != null)
                    const Icon(
                      Icons.arrow_outward_rounded,
                      color: Member4Screen._forest,
                      size: 18,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Member4Screen._ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                description,
                style: const TextStyle(
                  color: Member4Screen._muted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 13),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: tags
                    .map(
                      (tag) => Text(
                        tag,
                        style: const TextStyle(
                          color: Member4Screen._forest,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CertificateGallery extends StatelessWidget {
  const _CertificateGallery();

  static const _certificates = [
    _CertificateData(
      'AI for Business Professionals',
      'assets/inthumathy/certificates/Ai for business professionals.jpeg',
    ),
    _CertificateData(
      'Web Design for Beginners',
      'assets/inthumathy/certificates/web design for beginners.jpeg',
    ),
    _CertificateData(
      'Python for Beginners',
      'assets/inthumathy/certificates/python for beginners.jpeg',
    ),
    _CertificateData(
      'Power BI for Beginners',
      'assets/inthumathy/certificates/power boi for beginners.jpeg',
    ),
    _CertificateData(
      'Minecraft Coding Games',
      'assets/inthumathy/certificates/Minecraft coding games.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 700 ? 3 : 2;
        const spacing = 12.0;
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final certificate in _certificates)
              _CertificateCard(data: certificate, width: itemWidth),
          ],
        );
      },
    );
  }
}

class _CertificateData {
  const _CertificateData(this.title, this.imageAsset);

  final String title;
  final String imageAsset;
}

class _CertificateCard extends StatelessWidget {
  const _CertificateCard({required this.data, required this.width});

  final _CertificateData data;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => showDialog<void>(
            context: context,
            builder: (context) => Dialog(
              child: InteractiveViewer(
                child: Image.asset(
                  data.imageAsset,
                  fit: BoxFit.contain,
                  width: MediaQuery.sizeOf(context).width * 0.85,
                ),
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    data.imageAsset,
                    width: double.infinity,
                    height: 112,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Member4Screen._ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroAction extends StatelessWidget {
  const _HeroAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      icon: Icon(icon, size: 16),
      label: Text(label),
    );
  }
}
