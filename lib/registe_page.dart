import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistePage extends StatefulWidget {
  const RegistePage({super.key});

  @override
  State<RegistePage> createState() => _RegistePageState();
}

class _RegistePageState extends State<RegistePage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscurePassword2 = true;

  void register() async {
    setState(() => isLoading = true);

    if (passwordController.text != passwordController2.text) {
      _showCenteredDialog(
        title: "Password Tidak Sama",
        message:
            "Pastikan password dan konfirmasi password kamu sama sebelum melanjutkan.",
      );
      setState(() => isLoading = false);

      return;
    }

    final regist = await ApiService.register(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });

    if (regist.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anda Telah Berhasil Membuat Akun JDquizz')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('message')));
    }
  }

  void _showCenteredDialog({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, textAlign: TextAlign.center),
        content: Text(message, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (onConfirm != null) onConfirm();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // mulai dari atas
            end: Alignment.bottomCenter, // berakhir di bawah
            colors: [
              gradient1, // warna atas
              gradient2, // warna bawah
              gradient3,
              gradient4,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80),
          child: Center(
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
                        SizedBox(height: 10),
                        Text(
                          'Masukkan email dan kata sandi untuk membuat akun Anda',
                          style: TextStyle(color: subtitle),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),
                Text('Username'),
                SizedBox(height: 5),

                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Icon(Icons.email, color: icon),
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

                SizedBox(height: 15),
                Text('Email Address'),
                SizedBox(height: 5),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 14),
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
                SizedBox(height: 15),
                Text('Password'),
                SizedBox(height: 5),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        color: icon,
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() => obscurePassword = !obscurePassword);
                        },
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
                SizedBox(height: 15),
                Text('Confirm Password'),
                SizedBox(height: 5),
                TextFormField(
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Konfirmasi password wajib diisi';
                    }
                    if (v != passwordController.text) {
                      return 'Password tidak sama!';
                    }
                    return null;
                  },
                  controller: passwordController2,
                  obscureText: obscurePassword2,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        color: icon,
                        icon: Icon(
                          obscurePassword2
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() => obscurePassword2 = !obscurePassword2);
                        },
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

                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'I agree to wimbo',
                      style: GoogleFonts.poppins(fontSize: 11),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // aksi saat teks "Wimbo" diklik
                        print("Wimbo clicked!");
                      },
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
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradient1Button, gradient2Button],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : register,

                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent, // transparan
                      shadowColor: Colors.transparent, // hilangkan bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Buat Akun',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
