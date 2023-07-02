
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mekalweb/Screens/Home/ventas_page.dart';
import 'list_produc.dart';

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
        title: const Text('Mekal'),
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
            /*
            ElevatedButton(
              child: const Text('Adisionar Produto'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CargarProduto(),
                  ),
                );
              },
            ),*/
       
            const Spacer(),
            ElevatedButton(
              child: const Text('Lista de Produtos'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ListProduct(),
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
