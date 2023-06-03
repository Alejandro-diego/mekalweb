import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final email = TextEditingController();
  final senha = TextEditingController();
  final valid = GlobalKey<FormState>();

  @override
  void initState() {
    _obtenerCredenciales();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: valid,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: email,
            decoration: const InputDecoration(
              hintText: "E-mail",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresar e-mail';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: senha,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Senha",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresar Senha';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                colocarCredenciales();
                sigIN();
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _obtenerCredenciales() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      senha.text = preference.getString('password') ?? '';
      email.text = preference.getString('email') ?? '';
    });
  }

  Future sigIN() async {
    debugPrint(email.text);
    late String error = "erro";
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: senha.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        error = "E-mail não registrado";
      } else if (e.code == 'wrong-password') {
        error = "Senha invalida";
      } else if (e.code == 'too-many-requests') {
        error = "Sua conta foi bloqueda temporariaramente";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            error,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Future<void> colocarCredenciales() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    setState(
      () {
        preference.setString('email', email.text);
        preference.setString('password', senha.text);
      },
    );
  }
}
