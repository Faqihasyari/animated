import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistePage extends StatefulWidget {
  const RegistePage({super.key});

  @override
  State<RegistePage> createState() => _RegistePageState();
}

class _RegistePageState extends State<RegistePage> {
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
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
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
                          'Buat akun menggunakan email dan password',
                          style: TextStyle(color: subtitle),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text('Email Address'),
                SizedBox(height: 5),

                TextField(
                  // controller: emailController,
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
                  // controller: passwordController,
                  // obscureText: obscurePassword,
                  decoration: InputDecoration(
                    filled: true,
                    // suffixIcon: Padding(
                    //   padding: const EdgeInsets.only(right: 10),
                    //   child: IconButton(
                    //     color: icon,
                    //     icon: Icon(
                    //       obscurePassword
                    //           ? Icons.visibility_off
                    //           : Icons.visibility,
                    //     ),
                    //     onPressed: () {
                    //       setState(() => obscurePassword = !obscurePassword);
                    //     },
                    //   ),
                    // ),
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
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent, // transparan
                      shadowColor: Colors.transparent, // hilangkan bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    // child: isLoading
                    //     ? const CircularProgressIndicator(color: Colors.white)
                    //     :
                    child: Text(
                      'Buat Akun',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
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
