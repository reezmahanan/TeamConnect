import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Member9Screen extends StatefulWidget {
  const Member9Screen({super.key});

  @override
  State<Member9Screen> createState() => _Member9ScreenState();
}

class _Member9ScreenState extends State<Member9Screen> {
  bool dark = true;
  int selected = 0;
  // Replace this with your address before submission.
  static const address = 'To be updated';
  static const photo = 'assets/images/23IT0491.jpg';
  static const email = 'yuhansiyuthmi@gmail.com';
  Color get background => dark ? const Color(0xFF15121F) : const Color(0xFFF5EFFA);
  Color get panel => dark ? const Color(0xFF241E32) : Colors.white;
  Color get ink => dark ? const Color(0xFFF5EFFA) : const Color(0xFF30223F);
  Color get muted => dark ? const Color(0xFFC5B7D4) : const Color(0xFF62546F);
  Color get highlight => dark ? const Color(0xFFD6B4FA) : const Color(0xFF70409E);

  Future<void> copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  void showPhoto() {
    showDialog<void>(context: context, builder: (context) => Dialog(
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 400, maxHeight: 460),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Flexible(child: Image.asset(photo, fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(Icons.person, size: 120))),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ])),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background, foregroundColor: ink,
        title: const Text('TEAMCONNECT / 09', style: TextStyle(fontSize: 15, letterSpacing: 2, fontWeight: FontWeight.w700)),
        actions: [IconButton(tooltip: 'Switch theme', icon: Icon(dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined), onPressed: () => setState(() => dark = !dark)), const SizedBox(width: 8)],
      ),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200), child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero(), const SizedBox(height: 18), stats(), const SizedBox(height: 22), tabs(), const SizedBox(height: 18),
            if (selected == 0) about(),
            if (selected == 1) skills(),
            if (selected == 2) projects(),
            if (selected == 3) certificates(),
            const SizedBox(height: 28),
            Text('Yuhansi Karunaratna  •  TeamConnect 2026', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12)),
          ],
        ))),
      )),
    );
  }

  Widget hero() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: const LinearGradient(colors: [Color(0xFF312442), Color(0xFF4B3157), Color(0xFF633C63)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    child: LayoutBuilder(builder: (context, constraints) {
      final avatar = InkWell(onTap: showPhoto, borderRadius: BorderRadius.circular(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 132, height: 132, padding: const EdgeInsets.all(3), decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: const Color(0xFFDAB9F5)), child: ClipRRect(borderRadius: BorderRadius.circular(22), child: Image.asset(photo, fit: BoxFit.cover, errorBuilder: (_, _, _) => const ColoredBox(color: Color(0xFF59426B), child: Icon(Icons.person, color: Colors.white, size: 70))))),
        const SizedBox(height: 8), const Text('View photo', style: TextStyle(color: Color(0xFFE1C5F9), fontSize: 12)),
      ]));
      final bio = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('SOFTWARE DEVELOPMENT', style: TextStyle(color: Color(0xFFDAB9F5), fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Yuhansi Karunaratna', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800, height: 1.1)),
        const SizedBox(height: 8), const Text('Full-Stack Development  |  Java  |  Spring Boot  |  React.js', style: TextStyle(color: Color(0xFFE1C5F9), fontSize: 15)),
        const SizedBox(height: 12), const Text('23IT0491  •  ITUM', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 18), Wrap(spacing: 8, runSpacing: 8, children: [
          heroLink(Icons.code, 'GitHub', 'https://github.com/yuhansi07'),
          heroLink(Icons.work_outline, 'LinkedIn', 'https://linkedin.com/in/yuhansi-karunaratn-it'),
          heroLink(Icons.language, 'Portfolio', 'https://yuhansi-portfolio.vercel.app'),
          heroLink(Icons.mail_outline, 'Email', email),
        ]),
      ]);
      return constraints.maxWidth < 620
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Center(child: avatar), const SizedBox(height: 20), bio])
        : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [avatar, const SizedBox(width: 28), Expanded(child: bio)]);
    }),
  );

  Widget heroLink(IconData icon, String label, String value) => OutlinedButton.icon(
    onPressed: () => copy(value), icon: Icon(icon, size: 17),
    label: Text('Copy $label'), style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFEAD7FF), side: const BorderSide(color: Color(0xFFB38ACB))),
  );

  Widget stats() => responsive([
    stat(Icons.school_outlined, '3.15 / 4.00', 'Current GPA'),
    stat(Icons.folder_open, '03', 'Projects'),
    stat(Icons.workspace_premium_outlined, '07', 'Certifications'),
  ], count: 3, minWidth: 210);

  Widget stat(IconData icon, String number, String label) => Container(
    padding: const EdgeInsets.all(18), decoration: decoration(),
    child: Row(children: [Icon(icon, color: highlight, size: 28), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(number, style: TextStyle(color: ink, fontSize: 25, fontWeight: FontWeight.bold)), Text(label, style: TextStyle(color: muted))]))]),
  );

  Widget tabs() {
    const names = ['About', 'Skills', 'Projects', 'Certificates'];
    const icons = [Icons.person_outline, Icons.code, Icons.folder_outlined, Icons.workspace_premium_outlined];
    return Wrap(spacing: 8, runSpacing: 8, children: List.generate(names.length, (index) => ChoiceChip(
      avatar: Icon(icons[index], size: 18, color: selected == index ? Colors.white : highlight),
      label: Text(names[index]), selected: selected == index, showCheckmark: false,
      selectedColor: const Color(0xFF70409E), backgroundColor: panel,
      labelStyle: TextStyle(color: selected == index ? Colors.white : ink, fontWeight: FontWeight.w600),
      onSelected: (_) => setState(() => selected = index),
    )));
  }

  Widget about() => responsive([
    section(Icons.auto_awesome, 'About Me', [paragraph('Information Technology student with hands-on experience building full-stack web and mobile applications. Experienced in REST API development and integration, CRUD workflows, database-backed applications, authentication, authorization and role-based systems.')]),
    section(Icons.badge_outlined, 'Personal Details', [detail(Icons.fingerprint, 'Registration Number', '23IT0491'), detail(Icons.mail_outline, 'Email', email), detail(Icons.location_on_outlined, 'Address', address)]),
    section(Icons.school_outlined, 'Academic Qualifications', [
      education('Present', 'Information Technology', 'Institute of Technology, University of Moratuwa (ITUM)', 'Current GPA: 3.15 / 4.00'),
      education('2023 – 2024', 'Diploma in English', 'National Institute of Business Management (NIBM)', ''),
      education('2023', 'Certificate in Counseling', 'BCI Campus', ''),
    ]),
    section(Icons.groups_outlined, 'Soft Skills', [tags(['Problem Solving', 'Teamwork', 'Communication', 'Leadership', 'Adaptability', 'Time Management'])]),
  ]);

  Widget skills() => responsive([
    section(Icons.code, 'Programming Languages', [tags(['Java', 'JavaScript', 'Dart', 'Python', 'SQL'])]),
    section(Icons.web, 'Frontend', [tags(['React.js', 'HTML', 'CSS', 'TypeScript', 'Responsive Web Design'])]),
    section(Icons.smartphone, 'Mobile Development', [tags(['Flutter'])]),
    section(Icons.storage, 'Backend', [tags(['Spring Boot', 'Node.js', 'Express.js'])]),
    section(Icons.security, 'Security', [tags(['Authentication', 'Authorization', 'Role-based Access', 'JWT'])]),
    section(Icons.dns_outlined, 'Databases', [tags(['MySQL', 'PostgreSQL'])]),
    section(Icons.build_outlined, 'DevOps & Tools', [tags(['Git', 'GitHub', 'VS Code', 'Postman'])]),
  ]);

  Widget projects() => responsive([
    project('North Sea – Smart Sales Management System', '2024', ['React.js', 'Node.js', 'Express.js', 'MySQL'], 'Built a sales management system with role-based access for admins, staff and customers. Implemented product management, order processing and sales reporting.', 'https://github.com/nawodya2003/NSS-SMS.git'),
    project('BookNest – Library Management System', '2024', ['Flutter', 'Node.js', 'Express.js', 'PostgreSQL', 'AWS'], 'Developed a library management system with demand forecasting and anomaly detection, Flutter mobile application, AWS deployment, role-based access and CRUD operations.', 'https://github.com/yuhansi07/BookNest', live: 'https://16-178-235-210.sslip.io'),
    project('TourFlow – Tourist Management System', '2023', ['React.js', 'Spring Boot', 'MySQL'], 'Developed a tourist management system for tours, packages and customer bookings, with CRUD operations and role-based access control for multiple staff roles.', 'https://github.com/yuhansi07/TourFlow'),
  ]);

  Widget certificates() => responsive([
    section(Icons.workspace_premium_outlined, 'University of Moratuwa', [certificate('Front-End Web Development'), certificate('Python Programming'), certificate('Web Design for Beginners')]),
    section(Icons.workspace_premium_outlined, 'Cisco Networking Academy', [certificate('Introduction to Cybersecurity'), certificate('Computer Hardware Basics'), certificate('Data Analytics Essentials')]),
    section(Icons.workspace_premium_outlined, 'Simplilearn SkillUp', [certificate('AWS')]),
  ]);

  Widget project(String title, String year, List<String> tech, String description, String repo, {String? live}) => section(Icons.folder_outlined, title, [
    Text(year, style: TextStyle(color: highlight, fontWeight: FontWeight.bold)), tags(tech), paragraph(description),
    Wrap(spacing: 8, runSpacing: 8, children: [OutlinedButton.icon(onPressed: () => copy(repo), icon: const Icon(Icons.content_copy, size: 16), label: const Text('Copy GitHub URL'), style: OutlinedButton.styleFrom(foregroundColor: highlight)), if (live != null) OutlinedButton(onPressed: () => copy(live), style: OutlinedButton.styleFrom(foregroundColor: highlight), child: const Text('Copy live URL'))]),
  ]);

  Widget certificate(String title) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.check_circle_outline, color: highlight, size: 20), const SizedBox(width: 10), Expanded(child: paragraph(title))]);

  Widget detail(IconData icon, String label, String value) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: highlight, size: 22), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: muted, fontSize: 12)), const SizedBox(height: 3), SelectableText(value, style: TextStyle(color: ink, fontSize: 15))]))]);

  Widget education(String date, String title, String institute, String extra) => Container(
    decoration: BoxDecoration(border: Border(left: BorderSide(color: highlight, width: 3))), padding: const EdgeInsets.only(left: 14, top: 4, bottom: 4),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(date, style: TextStyle(color: highlight, fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 5), Text(title, style: TextStyle(color: ink, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 4), paragraph(institute), if (extra.isNotEmpty) ...[const SizedBox(height: 5), Text(extra, style: TextStyle(color: highlight, fontWeight: FontWeight.w600))]]),
  );

  Widget tags(List<String> items) => Wrap(spacing: 8, runSpacing: 8, children: items.map((item) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7), decoration: BoxDecoration(color: dark ? const Color(0xFF382B49) : const Color(0xFFF1E6FA), borderRadius: BorderRadius.circular(18)), child: Text(item, style: TextStyle(color: highlight, fontSize: 13)))).toList());

  Widget paragraph(String text) => Text(text, style: TextStyle(color: muted, fontSize: 15, height: 1.6));

  BoxDecoration decoration() => BoxDecoration(color: panel, borderRadius: BorderRadius.circular(23), border: Border.all(color: dark ? const Color(0xFF443452) : const Color(0xFFE8DDF1)));

  Widget section(IconData icon, String title, List<Widget> children) => Container(
    padding: const EdgeInsets.all(20), decoration: decoration(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: dark ? const Color(0xFF382B49) : const Color(0xFFF1E6FA), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: highlight)), const SizedBox(width: 12), Expanded(child: Text(title, style: TextStyle(color: ink, fontSize: 18, fontWeight: FontWeight.bold)))]),
      for (final child in children) ...[const SizedBox(height: 16), child],
    ]),
  );

  Widget responsive(List<Widget> children, {int count = 2, double minWidth = 350}) => LayoutBuilder(builder: (context, constraints) {
    const gap = 14.0;
    final possible = ((constraints.maxWidth + gap) / (minWidth + gap)).floor();
    final columns = possible < 1 ? 1 : (possible > count ? count : possible);
    final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
    return Wrap(spacing: gap, runSpacing: gap, children: children.map((child) => SizedBox(width: width, child: child)).toList());
  });
}