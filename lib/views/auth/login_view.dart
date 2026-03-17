import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // İçeriği ortalamak için buraya bir Container ekleyip ekran yüksekliğini veriyoruz
          child: Container(
            height:
                MediaQuery.of(context).size.height -
                100, // Safe area ve padding payını düşüyoruz
            alignment: Alignment.center, // Container içindekileri ortala
            child: Column(
              // mainAxisAlignment'i center yapıyoruz ama SingleChildScrollView ile pek çalışmaz.
              // Bu yüzden aşağıda Spacer'ları kullanacağız.
              children: [
                // 👇 Üstte Boşluk (İçeriği aşağı itecek)
                const Spacer(flex: 2), // Esnek boşluk, 2 birim kapla
                // Üstteki İkon Kutusu
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D7A78),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Sign in to manage your bills",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 48),

                // Email Alanı
                CustomTextField(
                  label: "Email",
                  hintText: "you@example.com",
                  controller: _emailController,
                ),
                const SizedBox(height: 24),

                // Şifre Alanı
                CustomTextField(
                  label: "Password",
                  hintText: "Enter your password",
                  controller: _passwordController,
                  isPassword: true,
                  suffixIcon: const Icon(Icons.visibility_outlined),
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Color(0xFF2D7A78)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sign In Butonu
                CustomButton(text: "Sign In", onPressed: () {}),

                // 👇 Ortada Hafif Boşluk (Alt kısımdan ayıracak)
                const SizedBox(height: 32),

                // Alt Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color(0xFF2D7A78),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // 👇 Altta Boşluk (İçeriği yukarı çekecek)
                const Spacer(flex: 3), // Esnek boşluk, 3 birim kapla
              ],
            ),
          ),
        ),
      ),
    );
  }
}
