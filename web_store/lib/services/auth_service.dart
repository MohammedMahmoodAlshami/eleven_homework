import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
      throw Exception('فشل في تسجيل الخروج.');
    }
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return Exception('كلمة المرور ضعيفة جداً.');
      case 'email-already-in-use':
        return Exception('البريد الإلكتروني مستخدم بالفعل.');
      case 'invalid-email':
        return Exception('البريد الإلكتروني غير صالح.');
      case 'user-not-found':
        return Exception('لا يوجد مستخدم بهذا البريد الإلكتروني.');
      case 'wrong-password':
        return Exception('كلمة المرور غير صحيحة.');
      case 'network-request-failed':
        return Exception('فشل الاتصال بالشبكة. يرجى التحقق من اتصالك بالإنترنت.');
      default:
        return Exception(e.message ?? 'حدث خطأ في المصادقة.');
    }
  }
}
