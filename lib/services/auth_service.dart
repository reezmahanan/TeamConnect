import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Get current logged-in user
  User? get currentUser => _auth.currentUser;

  // Listen to authentication changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
