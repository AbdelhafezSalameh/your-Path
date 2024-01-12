import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // اذا كان عامل تسجيل دخول من اول
  Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  // انشاء حساب
  // ignore: body_might_complete_normally_nullable
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
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
