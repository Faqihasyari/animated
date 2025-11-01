// lib/app/modules/register/views/register_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradient1, gradient2, gradient3, gradient4],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 280,
                      child: Column(
                        children: [
                          Image.asset('assets/SignUp.png'),
                          Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Masukkan email dan kata sandi untuk membuat akun Anda',
                            style: TextStyle(color: subtitle),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Username'),
                  const SizedBox(height: 5),
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: Icon(Icons.person, color: icon),
                      ),
                      hintText: 'Username',
                      hintStyle: GoogleFonts.poppins(
                        color: subtitle,
                        fontSize: 12,
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Email Address'),
                  const SizedBox(height: 5),
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: Icon(Icons.email, color: icon),
                      ),
                      hintText: 'Email',
                      hintStyle: GoogleFonts.poppins(
                        color: subtitle,
                        fontSize: 12,
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Password'),
                  const SizedBox(height: 5),
                  Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            color: icon,
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.poppins(
                          color: subtitle,
                          fontSize: 12,
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Confirm Password'),
                  const SizedBox(height: 5),
                  Obx(
                    () => TextField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.obscureConfirmPassword.value,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            color: icon,
                            icon: Icon(
                              controller.obscureConfirmPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: GoogleFonts.poppins(
                          color: subtitle,
                          fontSize: 12,
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.isChecked.value,
                          onChanged: (value) => controller.toggleAgreement(),
                        ),
                      ),
                      Text(
                        'I agree to ',
                        style: GoogleFonts.poppins(fontSize: 11),
                      ),
                      GestureDetector(
                        onTap: controller.goToTerms,
                        child: Text(
                          'Public Agreement, Terms, & Privacy Police',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.purple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [gradient1Button, gradient2Button],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.register,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Buat Akun',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: controller.goToLogin,
                      child: RichText(
                        text: TextSpan(
                          text: 'Sudah punya akun? ',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: GoogleFonts.poppins(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}