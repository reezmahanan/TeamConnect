import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Member1Screen extends StatefulWidget {
  const Member1Screen({super.key});

  @override
  State<Member1Screen> createState() => _Member1ScreenState();
}

class _Member1ScreenState extends State<Member1Screen> {
  bool _isFavourite = false;
  bool _showProjects = true;
  bool _showSkills = true;
  bool _showCertifications = false;
  bool _showOpenSource = false;

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open the link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFF07151B),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: isWide ? 330 : 270,
            backgroundColor: const Color(0xFF08232C),
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                tooltip: 'Favourite',
                onPressed: () => setState(() => _isFavourite = !_isFavourite),
                icon: Icon(
                  _isFavourite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: _isFavourite ? const Color(0xFF5EEAD4) : Colors.white,
                ),
              ),
              const SizedBox(width: 6),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF082F36),
                      Color(0xFF0A5A62),
                      Color(0xFF07151B),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 920),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          isWide ? 44 : 24,
                          20,
                          isWide ? 18 : 12,
                        ),
                        child: isWide
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _ProfilePhoto(),
                                  const SizedBox(width: 28),
                                  const Expanded(
                                    child: _ProfileHeaderText(centered: false),
                                  ),
                                ],
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _ProfilePhoto(size: 96),
                                  SizedBox(height: 10),
                                  _ProfileHeaderText(centered: true),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              isWide ? 32 : 16,
              18,
              isWide ? 32 : 16,
              32,
            ),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF155E75), Color(0xFF164E63)],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFF1E6474)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _HeaderStat('18', 'Projects'),
                            _HeaderStat('30+', 'Certificates'),
                            _HeaderStat('5', 'Communities'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        icon: Icons.person_outline_rounded,
                        title: 'About Me',
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I am an Information Technology undergraduate at the Institute of Technology, University of Moratuwa (ITUM), Sri Lanka. I am passionate about full-stack software development, mobile application development, and machine learning.',
                              style: TextStyle(
                                color: Color(0xFFCADCE1),
                                height: 1.55,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'I enjoy building practical software solutions, exploring emerging technologies, contributing to open-source projects, and collaborating with development teams.',
                              style: TextStyle(
                                color: Color(0xFFCADCE1),
                                height: 1.55,
                              ),
                            ),
                            SizedBox(height: 14),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _MiniTag(
                                  Icons.location_on_outlined,
                                  'Oddamavadi, Batticaloa',
                                ),
                                _MiniTag(
                                  Icons.school_outlined,
                                  'ITUM • Information Technology',
                                ),
                                _MiniTag(
                                  Icons.email_outlined,
                                  'reezmahanan@gmail.com',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        icon: Icons.school_outlined,
                        title: 'Education',
                        child: const _EducationCard(),
                      ),
                      const SizedBox(height: 14),
                      _ExpandableSection(
                        icon: Icons.integration_instructions_outlined,
                        title: 'Technical Skills',
                        expanded: _showSkills,
                        onTap: () => setState(() => _showSkills = !_showSkills),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SkillCategory(
                              'Programming',
                              'Java, Python, JavaScript, TypeScript, Dart, PHP, C',
                              Icons.code_rounded,
                            ),
                            _SkillCategory(
                              'Frontend',
                              'React.js, Next.js, Angular, HTML5, CSS3, Bootstrap, Tailwind CSS',
                              Icons.web_rounded,
                            ),
                            _SkillCategory(
                              'Backend',
                              'Spring Boot, Node.js, Express.js, Laravel',
                              Icons.dns_rounded,
                            ),
                            _SkillCategory(
                              'Mobile & Database',
                              'Flutter, Dart, Firebase, MySQL, MongoDB',
                              Icons.phone_android_rounded,
                            ),
                            _SkillCategory(
                              'AI & Data',
                              'Scikit-Learn, LightGBM, Pandas, NumPy, Kaggle',
                              Icons.auto_awesome_rounded,
                            ),
                            _SkillCategory(
                              'Cloud & DevOps',
                              'AWS, Microsoft Azure, Firebase, Docker, Linux',
                              Icons.cloud_outlined,
                            ),
                            _SkillCategory(
                              'Tools & IoT',
                              'Git, GitHub, Postman, VS Code, IntelliJ, Selenium, Arduino, ATmega32',
                              Icons.build_circle_outlined,
                            ),
                            _SkillCategory(
                              'UI/UX & Design',
                              'Figma, Adobe Photoshop, Adobe Illustrator, Canva',
                              Icons.palette_outlined,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        icon: Icons.groups_outlined,
                        title: 'Soft Skills',
                        child: const Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _SkillChip('Team Leadership', Icons.emoji_events),
                            _SkillChip(
                              'Problem Solving',
                              Icons.psychology_outlined,
                            ),
                            _SkillChip('Team Collaboration', Icons.diversity_3),
                            _SkillChip(
                              'Project Coordination',
                              Icons.account_tree,
                            ),
                            _SkillChip(
                              'Effective Communication',
                              Icons.chat_bubble,
                            ),
                            _SkillChip('Time Management', Icons.schedule),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        icon: Icons.auto_awesome_outlined,
                        title: 'Interests & Leadership',
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _SkillChip(
                                  'Full-Stack Development',
                                  Icons.language,
                                ),
                                _SkillChip(
                                  'Mobile Development',
                                  Icons.smartphone,
                                ),
                                _SkillChip('AI & ML', Icons.auto_graph),
                                _SkillChip(
                                  'Open Source',
                                  Icons.open_in_browser,
                                ),
                                _SkillChip('Creative Design', Icons.palette),
                                _SkillChip('UI/UX Design', Icons.draw),
                                _SkillChip('Cloud Computing', Icons.cloud),
                                _SkillChip('IoT & Hardware', Icons.memory),
                              ],
                            ),
                            SizedBox(height: 14),
                            _LeadershipRow(
                              'Lead Architecture',
                              'SCM Inventory Management System',
                            ),
                            _LeadershipRow('Team Lead', 'Book Nest'),
                            _LeadershipRow(
                              'Team Leader',
                              'Smart Home Automation',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _ExpandableSection(
                        icon: Icons.folder_special_outlined,
                        title: 'Featured Projects',
                        expanded: _showProjects,
                        onTap: () =>
                            setState(() => _showProjects = !_showProjects),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ProjectTile(
                              'EduNexus',
                              'Student Management System',
                              'A full-stack academic management system with attendance tracking, GPA calculation, role-based authentication and AI academic risk prediction.',
                              'React • Spring Boot • MySQL • Material UI',
                              'https://github.com/reezmahanan/Student-Management-System',
                              onLink: _openLink,
                            ),
                            _ProjectTile(
                              'LibriQ',
                              'University Library Management',
                              'A trilingual library management system with book circulation, role-based access and automated late fine calculations.',
                              'React • Node.js • Express.js • MongoDB • Tailwind CSS',
                              'https://github.com/reezmahanan/LibriQ',
                              onLink: _openLink,
                            ),
                            _ProjectTile(
                              'ReEz AI',
                              'Flutter AI Chatbot',
                              'A cross-platform AI chatbot with Gemini AI integration, Firebase authentication, streaming responses and persistent chat history.',
                              'Flutter • Dart • Gemini AI • Firebase • Firestore',
                              'https://github.com/reezmahanan/Flutter-AI-Chatbot-Application',
                              liveUrl: 'https://reezma-ai-chat-2026.web.app/',
                              onLink: _openLink,
                            ),
                            _ProjectTile(
                              'STYLEO Ceylon',
                              'E-Commerce System',
                              'A full-stack apparel shopping platform with transactional checkout, REST APIs and courier tracking.',
                              'JavaScript • Node.js • Express.js • MySQL',
                              'https://github.com/reezmahanan/STYLEO-Ceylon',
                              liveUrl:
                                  'https://project-01-nu-ruddy.vercel.app/',
                              onLink: _openLink,
                            ),
                            _ProjectTile(
                              'Electricity Consumption Prediction',
                              'Time-Series Forecasting',
                              'A machine learning forecasting system using Sri Lankan residential smart meter data. Reported R² score: 93.1%.',
                              'Python • LightGBM • Scikit-Learn • Pandas',
                              'https://github.com/reezmahanan/Electricity-Consumption-Prediction',
                              onLink: _openLink,
                            ),
                            _ProjectTile(
                              'StudyScore AI',
                              'Machine Learning Prediction',
                              'A machine learning predictive application for house price and performance prediction using regression techniques.',
                              'Python • Scikit-Learn • NumPy • Streamlit',
                              'https://github.com/reezmahanan/StudyScore-AI',
                              onLink: _openLink,
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 2),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF155E75),
                                    Color(0xFF164E63),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'View More Projects',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Explore my other projects on GitHub.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      height: 1.4,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  OutlinedButton.icon(
                                    onPressed: () => _openLink(
                                      'https://github.com/reezmahanan?tab=repositories',
                                    ),
                                    icon: const Icon(
                                      Icons.open_in_new,
                                      size: 17,
                                    ),
                                    label: const Text('View Repositories'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFF67E8F9),
                                      side: const BorderSide(
                                        color: Color(0xFF67E8F9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _ExpandableSection(
                        icon: Icons.workspace_premium_outlined,
                        title: 'Professional Certifications',
                        expanded: _showCertifications,
                        onTap: () => setState(
                          () => _showCertifications = !_showCertifications,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _CertificationRow(
                              'SLIIT',
                              'AI/ML Engineer — Stage 1, 2 & 3',
                            ),
                            _CertificationRow(
                              'HackerRank',
                              'React, Node.js, Java, Python, SQL, JavaScript & CSS',
                            ),
                            _CertificationRow(
                              'Microsoft',
                              'Git, GitHub Copilot, Cloud Computing & AI Concepts',
                            ),
                            _CertificationRow(
                              'University of Moratuwa CODL',
                              'Front-End Development, Python & Web Design',
                            ),
                            _CertificationRow(
                              'Simplilearn',
                              'Machine Learning, Agile Scrum, Java OOP, Cloud & Cyber Security',
                            ),
                            _CertificationRow(
                              'Google Cloud',
                              'Introduction to Generative AI',
                            ),
                            _CertificationRow(
                              'KodeKloud',
                              'Docker for Absolute Beginners',
                            ),
                            _CertificationRow(
                              'Linux Foundation',
                              'Cyber Security Essential (LFC108)',
                            ),
                            _CertificationRow('Cisco', 'Cyber Security'),
                            _CertificationRow(
                              'Great Learning',
                              'UI/UX, HTML, MySQL, Programming, Python & Projects',
                            ),
                            _CertificationRow(
                              'Udemy',
                              'Hands-On Introduction to Git with GitHub',
                            ),
                            _CertificationRow(
                              'SoloLearn',
                              'Java, SQL, HTML, CSS, Python & C',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _ExpandableSection(
                        icon: Icons.volunteer_activism_outlined,
                        title: 'Open Source Contributions',
                        expanded: _showOpenSource,
                        onTap: () =>
                            setState(() => _showOpenSource = !_showOpenSource),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _OpenSourceItem(
                              'SWOC',
                              'SafeHaven',
                              'https://github.com/archangel2006/SafeHaven',
                            ),
                            const _OpenSourceItem(
                              'OSCG',
                              'Blockchain Evidence',
                              'https://github.com/Gooichand/blockchain-evidence',
                            ),
                            const _OpenSourceItem(
                              'SSOC',
                              'E-commerce',
                              'https://github.com/AnthropicBots/E-commerce.git',
                            ),
                            const _OpenSourceItem(
                              'GSSOC',
                              'EaseMotion CSS',
                              'https://github.com/SAPTARSHI-coder/EaseMotion-css.git',
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Open Source Community Initiative (OSCI)',
                              style: TextStyle(
                                color: Color(0xFF67E8F9),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton.icon(
                              onPressed: () =>
                                  _openLink('https://github.com/reezmahanan'),
                              icon: const Icon(Icons.open_in_new, size: 18),
                              label: const Text('View GitHub Profile'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF67E8F9),
                                side: const BorderSide(
                                  color: Color(0xFF155E75),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SectionCard(
                        icon: Icons.alternate_email_rounded,
                        title: 'Connect',
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _SocialButton(
                              'Email',
                              Icons.email_outlined,
                              () => _openLink('mailto:reezmahanan@gmail.com'),
                            ),
                            _SocialButton(
                              'GitHub',
                              Icons.code_rounded,
                              () => _openLink('https://github.com/reezmahanan'),
                            ),
                            _SocialButton(
                              'LinkedIn',
                              Icons.work_outline_rounded,
                              () => _openLink(
                                'https://www.linkedin.com/in/reezma-hanan',
                              ),
                            ),
                            _SocialButton(
                              'HackerRank',
                              Icons.terminal_rounded,
                              () => _openLink(
                                'https://www.hackerrank.com/profile/reezmahanan',
                              ),
                            ),
                            _SocialButton(
                              'Portfolio',
                              Icons.language_rounded,
                              () => _openLink(
                                'https://portfolio-website-7mdi.vercel.app',
                              ),
                            ),
                            _SocialButton(
                              'Medium',
                              Icons.article_outlined,
                              () =>
                                  _openLink('https://medium.com/@reezmahanan'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Center(
                        child: Text(
                          '"Learn continuously, build consistently, and engineer scalable solutions that matter."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF67E8F9),
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({this.size = 136});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF67E8F9), width: 3),
        boxShadow: const [
          BoxShadow(color: Color(0x5505B6D4), blurRadius: 26, spreadRadius: 3),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/reezma.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const ColoredBox(
            color: Color(0xFF164E63),
            child: Center(
              child: Icon(
                Icons.person_rounded,
                size: 68,
                color: Color(0xFF67E8F9),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileHeaderText extends StatelessWidget {
  const _ProfileHeaderText({required this.centered});
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Reezma Hanan',
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 7),
        Text(
          'Aspiring Software Engineer',
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            color: Color(0xFF67E8F9),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Full-Stack Developer • AI/ML Enthusiast • Open Source Contributor',
          textAlign: centered ? TextAlign.center : TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white70,
            height: 1.25,
            fontSize: 11,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '23IT0480',
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            color: Color(0xFF99F6E4),
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF67E8F9),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2631),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF164E63)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF22D3EE)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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

class _ExpandableSection extends StatelessWidget {
  const _ExpandableSection({
    required this.icon,
    required this.title,
    required this.expanded,
    required this.onTap,
    required this.child,
  });

  final IconData icon;
  final String title;
  final bool expanded;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C2631),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF164E63)),
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
                  Icon(icon, color: const Color(0xFF22D3EE)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: child,
            ),
        ],
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  const _MiniTag(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF164E63),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF67E8F9)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF155E75), Color(0xFF164E63)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'National Diploma in Technology (NDT)',
            style: TextStyle(
              color: Color(0xFF67E8F9),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Information Technology',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Text(
            'Institute of Technology, University of Moratuwa',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          SizedBox(height: 8),
          Text(
            'Currently pursuing higher education',
            style: TextStyle(color: Color(0xFF99F6E4), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SkillCategory extends StatelessWidget {
  const _SkillCategory(this.title, this.skills, this.icon);
  final String title;
  final String skills;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF164E63),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF67E8F9)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  skills,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.35,
                    fontSize: 12,
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

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label, this.icon);
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 17, color: const Color(0xFF67E8F9)),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color(0xFF164E63),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _LeadershipRow extends StatelessWidget {
  const _LeadershipRow(this.role, this.project);
  final String role;
  final String project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          const Icon(
            Icons.verified_rounded,
            size: 18,
            color: Color(0xFF67E8F9),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white70, height: 1.35),
                children: [
                  TextSpan(
                    text: '$role — ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

class _ProjectTile extends StatelessWidget {
  const _ProjectTile(
    this.title,
    this.subtitle,
    this.description,
    this.technologies,
    this.githubUrl, {
    this.liveUrl,
    required this.onLink,
  });

  final String title;
  final String subtitle;
  final String description;
  final String technologies;
  final String githubUrl;
  final String? liveUrl;
  final Future<void> Function(String) onLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF164E63),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF67E8F9),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              height: 1.45,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            technologies,
            style: const TextStyle(
              color: Color(0xFF99F6E4),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton.icon(
                onPressed: () => onLink(githubUrl),
                icon: const Icon(Icons.code, size: 17),
                label: const Text('GitHub'),
              ),
              if (liveUrl != null)
                TextButton.icon(
                  onPressed: () => onLink(liveUrl!),
                  icon: const Icon(Icons.open_in_new, size: 17),
                  label: const Text('Live Demo'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CertificationRow extends StatelessWidget {
  const _CertificationRow(this.provider, this.certifications);
  final String provider;
  final String certifications;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.verified_outlined,
            size: 18,
            color: Color(0xFF67E8F9),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white70, height: 1.35),
                children: [
                  TextSpan(
                    text: '$provider — ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: certifications),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OpenSourceItem extends StatelessWidget {
  const _OpenSourceItem(this.provider, this.project, this.url);
  final String provider;
  final String project;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: OutlinedButton(
        onPressed: () async {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF67E8F9),
          side: const BorderSide(color: Color(0xFF155E75)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          alignment: Alignment.centerLeft,
        ),
        child: Text('$provider — $project'),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton(this.label, this.icon, this.onPressed);
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF67E8F9),
        side: const BorderSide(color: Color(0xFF155E75)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
