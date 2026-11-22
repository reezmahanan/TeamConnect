import 'package:flutter/material.dart';

import '../models/member.dart';
import '../services/auth_service.dart';
import 'members/member1_screen.dart';
import 'members/member2_screen.dart';
import 'members/member3_screen.dart';
import 'members/member4_screen.dart';
import 'members/member5_screen.dart';
import 'members/member6_screen.dart';
import 'members/member7_screen.dart';
import 'members/member8_screen.dart';
import 'members/member9_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const members = <Member>[
    Member(id: '23IT0480', name: 'Ms M R Hanan'),
    Member(id: '23IT0481', name: 'Ms W R K W Hansamali'),
    Member(id: '23IT0482', name: 'Ms H M C B Herath'),
    Member(id: '23IT0485', name: 'Ms V Inthumathy'),
    Member(id: '23IT0486', name: 'Ms R V P A Jayamali'),
    Member(id: '23IT0487', name: 'Ms G W T Jayampathi'),
    Member(id: '23IT0488', name: 'Ms W D C G Jayarathna'),
    Member(id: '23IT0490', name: 'Mr K A S K Kapuhenthuduwa'),
    Member(id: '23IT0491', name: 'Ms W K Y Y Karunaratna'),
  ];

  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Log out?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'You will be returned to the login page.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (shouldLogout == true) {
      await AuthService().logout();
    }
  }

  void _openMember(int index) {
    final destinations = <Widget>[
      const Member1Screen(),
      const Member2Screen(),
      const Member3Screen(),
      const Member4Screen(),
      const Member5Screen(),
      const Member6Screen(),
      const Member7Screen(),
      const Member8Screen(),
      const Member9Screen(),
    ];
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => destinations[index]));
  }

  @override
  Widget build(BuildContext context) {
    final filtered = members.where((member) {
      final query = _query.toLowerCase();
      return member.name.toLowerCase().contains(query) ||
          member.id.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        title: const Text(
          'TeamConnect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: _confirmLogout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4F46E5), Color(0xFF312E81)],
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to the team',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'National Diploma in Technology',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Information Technology • Institute of Technology',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'University of Moratuwa',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            '9 team members',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'NDT • IT',
                            style: TextStyle(
                              color: Color(0xFFA5B4FC),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _query = value),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search by name or registration number',
                        hintStyle: const TextStyle(color: Colors.white38),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white54,
                        ),
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _query = '');
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white54,
                                ),
                              ),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (filtered.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No members found',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.crossAxisExtent;
                    final columns = width >= 1000
                        ? 4
                        : width >= 650
                        ? 3
                        : width >= 390
                        ? 2
                        : 1;
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final memberIndex = members.indexOf(filtered[index]);
                        final member = filtered[index];
                        return _MemberCard(
                          member: member,
                          accent: const [
                            Colors.teal,
                            Colors.indigo,
                            Colors.green,
                            Colors.purple,
                            Colors.blue,
                            Colors.orange,
                            Colors.cyan,
                            Colors.blueGrey,
                            Colors.redAccent,
                          ][memberIndex],
                          onTap: () => _openMember(memberIndex),
                        );
                      }, childCount: filtered.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 220,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.member,
    required this.accent,
    required this.onTap,
  });

  final Member member;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: accent.withValues(alpha: 0.18),
                child: Icon(Icons.person_rounded, color: accent, size: 38),
              ),
              const SizedBox(height: 12),
              Text(
                member.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                member.id,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: onTap,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF312E81),
                  foregroundColor: const Color(0xFFC7D2FE),
                  minimumSize: const Size(130, 38),
                ),
                child: const Text(
                  'View Profile',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
