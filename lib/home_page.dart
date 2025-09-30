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
                color: const Color.fromARGB(255, 216, 130, 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 100),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 216, 130, 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
