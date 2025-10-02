import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Hi Pamela',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.brown[900],
                      ),
                    ),
                    subtitle: Text(
                      'Senang bertemu denganmu kembali',
                      style: TextStyle(fontSize: 16, color: Colors.brown[900]),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(9999)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 194, 117, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  children: [
                    Icon(Icons.ac_unit_sharp),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('2300'), Text('Exp. Points')],
                    ),
                    SizedBox(width: 50),

                    Icon(Icons.ac_unit_sharp),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('2300'), Text('Exp. Points')],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Mode Practice'),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 62, 129, 7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: Text('Daily Quiz'),
                  subtitle: Text('20 mixed questions'),
                  trailing: Icon(Icons.arrow_circle_right, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40),

            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 223, 174),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: Text('Daily Quiz'),
                  subtitle: Text('20 mixed questions'),
                  trailing: Icon(Icons.arrow_circle_right, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 223, 174),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: Text('Daily Quiz'),
                  subtitle: Text('20 mixed questions'),
                  trailing: Icon(Icons.arrow_circle_right, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 223, 174),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: Text('Daily Quiz'),
                  subtitle: Text('20 mixed questions'),
                  trailing: Icon(Icons.arrow_circle_right, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: Padding(
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
                    Text('Nama User'),
                    Container(
                      width: 55,
                      height: 25,
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: Colors.white, width: 0.5),
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
    );
  }
}
