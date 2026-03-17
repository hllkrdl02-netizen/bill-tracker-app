import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // 1. Firebase Auth örneğini (instance) tanımlıyoruz.
  // Bu değişken üzerinden Firebase servislerine erişeceğiz.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 2. Kayıt Ol Fonksiyonu (İskelet)
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      // Firebase'e e-posta ve şifre ile kullanıcı oluşturma isteği gönderiyoruz.
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user; // Başarılıysa kullanıcıyı döndür
    } on FirebaseAuthException catch (e) {
      // Firebase'e özel hataları yakalıyoruz (zayıf şifre, geçersiz e-posta vb.)
      print("Firebase Kayıt Hatası: ${e.code}");
      rethrow; // Hatayı yukarı fırlatıyoruz ki UI tarafında kullanıcıya gösterelim
    } catch (e) {
      print("Beklenmedik bir hata oluştu: $e");
      return null;
    }
  }

  // 3. Giriş Yap Fonksiyonu (İskelet)
  Future<User?> loginWithEmail(String email, String password) async {
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
      return null;
    }
  }

  // 4. Çıkış Yap Fonksiyonu
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Çıkış yapılırken hata oluştu: $e");
    }
  }

  // 5. Oturum Durumunu Dinle (Stream)
  // Kullanıcı giriş yapmış mı yapmamış mı anlık kontrol etmek için
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
