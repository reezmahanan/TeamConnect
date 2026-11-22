import 'package:flutter/material.dart';

class MemberPlaceholderScreen extends StatelessWidget {
  const MemberPlaceholderScreen({
    super.key,
    required this.name,
    required this.registrationNumber,
  });

  final String name;
  final String registrationNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        title: Text(name),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF1E293B),
                child: Icon(
                  Icons.person_outline,
                  size: 52,
                  color: Color(0xFFA5B4FC),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                registrationNumber,
                style: const TextStyle(
                  color: Color(0xFFA5B4FC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Profile under development',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
