import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // FlutterFire CLI'ın oluşturduğu dosya

void main() async {
  // 1. Flutter motorunun (Engine) tamamen hazır olduğundan emin oluyoruz.
  // Bu satır olmadan 'async' işlemler başlatılamaz.
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Uygulama ayağa kalkmadan önce Firebase ile el sıkışıyoruz.
  // 'await' kullanarak bu işlemin bitmesini bekliyoruz.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fatura Takip Sistemi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Modern Material 3 tasarımı
      ),
      home: const FirebaseTestPage(),
    );
  }
}

class FirebaseTestPage extends StatelessWidget {
  const FirebaseTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_done, color: Colors.blue, size: 100),
            SizedBox(height: 20),
            Text(
              "Firebase Bağlantısı Hazır!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Tebrikler Hilal! Bitirme projenin bulut altyapısı artık çalışıyor.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
