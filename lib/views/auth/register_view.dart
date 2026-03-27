import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../../services/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
            height: MediaQuery.of(context).size.height - 50,
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(flex: 1),

                  // Üstteki İkon
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
                    "Create Account",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Start tracking your bills today",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),

                  // Full Name Alanı
                  CustomTextField(
                    label: "Full Name",
                    hintText: "John Doe",
                    controller: _fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Ad Soyad boş olamaz";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

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
                  const SizedBox(height: 20),

                  // Password Alanı
                  CustomTextField(
                    label: "Password",
                    hintText: "Create a password",
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
                  const SizedBox(height: 20),

                  // Confirm Password Alanı
                  CustomTextField(
                    label: "Confirm Password",
                    hintText: "Confirm your password",
                    controller: _confirmPasswordController,
                    isPassword: true,
                    suffixIcon: const Icon(Icons.visibility_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Şifre tekrarı boş olamaz";
                      if (value != _passwordController.text)
                        return "Şifreler eşleşmiyor!";
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // 🚀 13. GÜN: FIREBASE BAĞLANTISI VE HATA YAKALAMA
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: Color(0xFF2D7A78),
                        )
                      : CustomButton(
                          text: "Create Account",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isLoading = true);

                              try {
                                // 👇 BURASI KRİTİK: Firebase'e kayıt isteği gönderiyoruz
                                await AuthService().registerWithEmail(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );

                                // Başarılı olursa:
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Account created! Welcome Hilal!",
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context); // Login'e geri dön
                                }
                              } catch (e) {
                                // 👇 HATA YAKALAMA: Firebase'den gelen hatayı kullanıcıya göster
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Error: ${e.toString()}"),
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

                  // Giriş Sayfasına Dönüş
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(0xFF2D7A78),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
