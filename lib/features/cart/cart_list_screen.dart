import 'package:flutter/material.dart';
import 'package:mobilestock/features/cart/cart_detail_screen.dart';
import 'package:mobilestock/features/cart/cart_form_screen.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade600,
          foregroundColor: Colors.white,
          title: const Text('ตะกร้าตรวจนับ'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartFormScreen(docno: ''),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          "สร้างตะกร้าใหม่",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.compare_arrows),
                        label: const Text(
                          "รวมตะกร้า",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 8,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('เลขที่: 123', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('วันที่: 2023-11-30'),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('เวลา: 12:45'),
                                  Text('Creator: John Doe'),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('คลัง: WH-01'),
                                  Text('ที่เก็บ: A1-B2-C3'),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('หมายเหตุ: สินค้าชำรุด'),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text('สินค้า: 10 รายการ'),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        color: Colors.orange,
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      IconButton(
                                        color: Colors.blue,
                                        icon: const Icon(Icons.barcode_reader),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const CartDetailScreen(docno: '1234568789'),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      IconButton(
                                        color: Colors.red,
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
