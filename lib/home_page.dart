import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              gradient1, // warna atas
              gradient2, // warna bawah
              gradient3,
              gradient4,
            ],
            center: Alignment.center, // posisi pusat gradient
            radius: 0.8, // semakin besar nilainya, semakin luas gradient-nya
            focal: Alignment.center, // titik fokus (opsional)
            focalRadius: 0.1, // seberapa kuat efek fokus (opsional)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 30,

                      backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/2208884525/id/foto/permukaan-daun-dengan-tetesan-air-makro-dangkal-dofleaf-permukaan-dengan-tetesan-air-makro-dof.jpg?s=1024x1024&w=is&k=20&c=-tRdIPrCaNYembSMp4c0fvd9XKpKobrc4gNBH0t3y6M=',
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName.isNotEmpty
                            ? 'Halo, $userName 👋'
                            : 'Selamat datang di JDQuizz!',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 55,
                        height: 25,
                        decoration: BoxDecoration(
                          border: BoxBorder.all(
                            color: Colors.white,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffD9D9D9).withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text('Role', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/id/2208884525/id/foto/permukaan-daun-dengan-tetesan-air-makro-dangkal-dofleaf-permukaan-dengan-tetesan-air-makro-dof.jpg?s=1024x1024&w=is&k=20&c=-tRdIPrCaNYembSMp4c0fvd9XKpKobrc4gNBH0t3y6M=',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text('1200'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  color: containerColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: containerColor2.withOpacity(0.5),
                          ),
                          child: Image.asset('assets/container1.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tugas harian'),
                                SizedBox(height: 10),
                                Text('14 Soal'),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.7, -0.7),
                            child: CircleAvatar(
                              child: Icon(Icons.access_time_filled_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
