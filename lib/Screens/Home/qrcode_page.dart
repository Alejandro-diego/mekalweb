import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class QrCodePage extends StatefulWidget {
  QrCodePage({Key? key, required this.code, required this.tag})
      : super(key: key);
  String code;
  String tag;

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
          const   Spacer(),
            Hero(
              tag: widget.tag,
              child: QrImageView(
                data: widget.code,
                version: QrVersions.auto,
                size: 250.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Voltar'),
              ),
            ),
         const     Spacer(),
          ],
        ),
      ),
    );
  }
}
