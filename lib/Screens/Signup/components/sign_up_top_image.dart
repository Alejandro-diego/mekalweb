import 'package:flutter/material.dart';


import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Criar Cuenta",
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Container(
                width: 500.00,
                height: 500.00,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
