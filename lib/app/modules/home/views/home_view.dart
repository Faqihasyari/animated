import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controller/home_controller.dart';
import 'package:flutter_application_1/app/modules/quiz/view/quiz_view.dart';
import 'package:flutter_application_1/color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameList = ['Football', 'Science', 'Fashion', 'Movie', 'Music'];
    final List<String> nameList2 = ['Quiz Sejarah', 'Geography', 'Technology'];
    final assetList = [
      'assets/Football.png',
      'assets/Science.png',
      'assets/Fashion.png',
      'assets/Movie.png',
      'assets/music.png',
    ];

    return Scaffold(
      backgroundColor: primaryColor,
      body: Obx(
        () => Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                radialGradient, // warna atas
                radialGradient2, // warna bawah
                radialGradient3,
                radialGradient4,
              ],
              center: Alignment.center, // posisi pusat gradient
              radius: 1.7, // semakin besar nilainya, semakin luas gradient-nya
              focal: Alignment.center, // titik fokus (opsional)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👤 Header user
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/id/2208884525/id/foto/permukaan-daun-dengan-tetesan-air-makro-dangkal-dofleaf-permukaan-dengan-tetesan-air-makro-dof.jpg?s=1024x1024&w=is&k=20&c=-tRdIPrCaNYembSMp4c0fvd9XKpKobrc4gNBH0t3y6M=',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userName.value.isNotEmpty
                                ? 'Halo, ${controller.userName.value} 👋'
                                : 'Selamat datang di JDQuizz!',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: BoxBorder.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffD9D9D9).withOpacity(0.5),
                            ),
                            child: Center(
                              child: Text(
                                controller.userRank.isNotEmpty
                                    ? controller.userRank.value
                                    : 'Beginner',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
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
                            const Padding(
                              padding: EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                backgroundColor: btnquiz,
                                child: Icon(Icons.bolt, color: Colors.white),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text('1200'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // 🔥 Daily Task Card
                  Container(
                    width: double.infinity,
                    height: 170,
                    padding: const EdgeInsets.all(20),
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
                                    LinearProgressIndicator(
                                      value: controller.progressValue.value,
                                      backgroundColor: Colors.white24,
                                      color: controller.isCompleted.value
                                          ? Colors.greenAccent
                                          : Colors.orangeAccent,
                                      minHeight: 10,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Progress: ${controller.answered} / ${controller.target}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
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
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quiz',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      nameList.length,
                      (index) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      QuizView(categoryName: nameList[index]),
                                ),
                              );
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: containerQuiz.withOpacity(0.6),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Image.asset(
                                  assetList[index],
                                  scale: 2.5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            nameList[index],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'More Games',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: nameList2.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuizView(categoryName: nameList2[index]),
                            ),
                          );
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 500,

                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      3,
                                    ),
                                    child: Image.network(
                                      'https://plus.unsplash.com/premium_photo-1675827055694-010aef2cf08f?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=3112',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),

                                Text(
                                  nameList2[index],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  controller.questionCounts.isNotEmpty
                                      ? '${controller.questionCounts[index]} Soal'
                                      : '...',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset('coin.jpg', scale: 2),
                                    SizedBox(width: 5),
                                    Text(
                                      controller.quizPoints.isNotEmpty
                                          ? '${controller.quizPoints[index]}K'
                                          : '....',
                                      style: GoogleFonts.poppins(
                                        color: btnquiz,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: btnquiz,
                                      child: Icon(
                                        MdiIcons.lightningBolt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
