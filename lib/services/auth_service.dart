import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Kayıt Ol Fonksiyonu (Parametreleri İsimli Yaptık)
  Future<User?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Firebase Kayıt Hatası: ${e.code}");
      rethrow;
    } catch (e) {
      print("Beklenmedik bir hata oluştu: $e");
      rethrow; // UI tarafında yakalamak için rethrow daha iyidir
    }
  }

  // 2. Giriş Yap Fonksiyonu (Parametreleri İsimli Yaptık)
  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Firebase Giriş Hatası: ${e.code}");
      rethrow;
    } catch (e) {
      print("Hata: $e");
      rethrow;
    }
  }

  // Çıkış ve Stream kısımları aynı kalabilir...
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
