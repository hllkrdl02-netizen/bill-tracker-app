import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import 'register_view.dart';
import '../../services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(flex: 2),

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
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "E-posta boş olamaz";
                      if (!value.contains("@"))
                        return "Geçerli bir e-posta giriniz";
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Şifre Alanı
                  CustomTextField(
                    label: "Password",
                    hintText: "Enter your password",
                    controller: _passwordController,
                    isPassword: true,
                    suffixIcon: const Icon(Icons.visibility_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Şifre boş olamaz";
                      if (value.length < 6)
                        return "Şifre en az 6 karakter olmalı";
                      return null;
                    },
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // İleride şifre sıfırlama eklenebilir
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Color(0xFF2D7A78)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // FIREBASE LOGIN İŞLEMİ
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: Color(0xFF2D7A78),
                        )
                      : CustomButton(
                          text: "Sign In",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isLoading = true);

                              try {
                                // Gerçek Login Fonksiyonu
                                await AuthService().loginWithEmail(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );

                                if (mounted) {
                                  //print("Giriş başarılı!");
                                  Navigator.of(
                                    context,
                                  ).popUntil((route) => route.isFirst);
                                  // Buraya ana sayfaya yönlendirme kodu gelecek (Day 14-15)
                                }
                              } catch (e) {
                                // 👇 Hata Yakalama ve Kullanıcıya Gösterme
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Hata: ${e.toString()}"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } finally {
                                if (mounted) setState(() => _isLoading = false);
                              }
                            }
                          },
                        ),

                  const SizedBox(height: 32),

                  // Kayıt Ol Sayfasına Yönlendirme
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
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
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
