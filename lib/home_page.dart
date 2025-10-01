import 'package:flutter/material.dart';

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
            ),
            SizedBox(height: 40),

            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 223, 174),
                borderRadius: BorderRadius.circular(10),
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
            ),
            SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 223, 174),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
