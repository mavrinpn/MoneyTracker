import 'package:firebase_auth/firebase_auth.dart';
import '../core/exception.dart';

class FirebaseAuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String getCurrentUserUid() {
    return firebaseAuth.currentUser?.uid ?? '';
  }

  String getCurrentUserEmail() {
    return firebaseAuth.currentUser?.email ?? '';
  }

  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } catch (_) {
      throw const AuthenticationException();
    }
  }

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } catch (_) {
      throw const AuthenticationException();
    }
  }

  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
