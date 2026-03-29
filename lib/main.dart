import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'views/auth/login_view.dart';
import 'views/dashboard/dashboard_view.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bill Tracker',
      theme: ThemeData(primarySwatch: Colors.teal),
      // 👇 StreamBuilder ile oturum kontrolü yapıyoruz
      home: StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          // Bağlantı kurulurken loading gösterelim
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // Eğer veride bir kullanıcı (user) varsa Dashboard aç
          if (snapshot.hasData) {
            return const DashboardView();
          }
          // Kullanıcı yoksa Login ekranını aç
          return const LoginView();
        },
      ),
    );
  }
}
