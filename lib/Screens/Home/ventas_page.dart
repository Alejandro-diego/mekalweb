import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mekalweb/Screens/Home/qrcode_page.dart';
import 'package:pix_flutter/pix_flutter.dart';

import 'details_de_venta.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({Key? key}) : super(key: key);

  @override
  State<VentasPage> createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamentos'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orçamentos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Deu Merda');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Cargando');
          }
          return ListView(
            children:
                snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 3),
                  title: Text('Cliente : ${data['cliente']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data : ${data['data']}'),
                      Text('Hora : ${data['hora']}'),
                      Text('Vendedor  : ${data['vendedor']}'),
                      Text('Pagamento : ${data['pagamento']}'),
                    ],
                  ),
                  // leading: Text('${data['quantidade']}'),
                  trailing: Column(
                    children: <Widget>[
                      Text('Rs ${data['total'].toStringAsFixed(2)}'),
                      Hero(
                        tag: data['reference'],
                        child: IconButton(
                          onPressed: () {
                            mandarPix(data['total'].toStringAsFixed(2),
                                data['reference']);
                          },
                          icon: const Icon(Icons.qr_code_2),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsOfSales(
                          cliente: data['cliente'],
                          reference: data['reference'],
                          total: data['total'].toStringAsFixed(2),
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    debugPrint(data['reference']);
                    deleteAllTaskDocs(data['reference']);
                    _db
                        .collection('orçamentos')
                        .doc(data['reference'])
                        .delete();

                    _db.collection('pedidos').doc(data['reference']).delete();
                  },
                  isThreeLine: true,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<void> deleteAllTaskDocs(String ref) {
    return _db
        .collection('orçamentos')
        .doc(ref)
        .collection('itens')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  void mandarPix(String valor, String tag) async {
    PixFlutter pixFlutter = PixFlutter(
        payload: Payload(
            pixKey: '09473073000175',
            // A descrição está desativada por um erro no próprio API Pix, que não deixa processar pagamentos se ela estiver presente.
            // Assim que o bug for consertado, a funcionalidade será adicionada de volta.
            description: 'Mekal',
            merchantName: 'MERCHANT_NAME',
            merchantCity: 'IBIRUBA',
            txid: 'TXID', // Até 25 caracteres para o QR Code estático
            amount: valor));

    debugPrint(tag);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrCodePage(
          code: pixFlutter.getQRCode(),
          tag: tag,
        ),
      ),
    );
  }
}
