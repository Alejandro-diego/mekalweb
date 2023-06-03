import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mekalweb/Screens/Home/ventas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('Orcamentos'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VentasPage(),
                  ),
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('SingOut'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
