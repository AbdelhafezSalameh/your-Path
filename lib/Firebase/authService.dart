import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // اذا كان عامل تسجيل دخول من اول
  Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  // تسجيل دخول
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // اll
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("Firebase Auth Error Code: ${e.code}");
      return mapFirebaseAuthErrorToMessage(
          e.code); // في مشكلة بتسجيل الدخول وانزل تحت شوف شو رح يرجع مسج
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

// المسجات يلي بترجعلي
  String mapFirebaseAuthErrorToMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'This email address is not registered. Please sign up.';
      case 'wrong-password':
        return 'Wrong password. Please try again.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }
}
