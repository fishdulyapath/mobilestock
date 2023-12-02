import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CartDetailScreen extends StatefulWidget {
  final String docno;
  const CartDetailScreen({super.key, required this.docno});

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  String _scanBarcode = 'Unknown';
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);

      if (!mounted) return;

      if (barcode != '-1') {
        setState(() {
          _controller.text = barcode;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        title: const Text('รายละเอียดสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(children: [
              const Text(
                'เลขที่: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.docno,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'วันที่: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                '2026-10-30',
                style: TextStyle(fontSize: 16),
              ),
            ]),
            const Row(children: [
              Text(
                'คลัง: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'คลังสินค้า 1',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'ที่เก็บ: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'ที่เก็บ 1',
                style: TextStyle(fontSize: 16),
              ),
            ]),
            const Divider(
              thickness: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Scan result',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true, // To prevent manual editing
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: scanQR,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('สินค้า ${index + 1}'),
                        subtitle: Text('รายละเอียดสินค้า ${index + 1}'),
                        trailing: const Text('จำนวน 1'),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
