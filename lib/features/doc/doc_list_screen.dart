import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/features/cart/cart_detail_screen.dart';
import 'package:mobilestock/features/cart/cart_form_screen.dart';
import 'package:mobilestock/features/cart/cart_merge_screen.dart';
import 'package:mobilestock/features/doc/doc_detail_screen.dart';
import 'package:mobilestock/model/cart_model.dart';
import 'package:mobilestock/repository/webservice_repository.dart';

class DocListScreen extends StatefulWidget {
  const DocListScreen({super.key});

  @override
  State<DocListScreen> createState() => _DocListScreenState();
}

class _DocListScreenState extends State<DocListScreen> {
  final WebServiceRepository _webServiceRepository = WebServiceRepository();
  List<CartModel> carts = [];
  List<bool> checked = [];
  bool showCheckbox = false;
  @override
  void initState() {
    getDocList();

    super.initState();
  }

  void getDocList() async {
    await _webServiceRepository.getCartSubList().then((value) {
      if (value.success) {
        setState(() {
          carts = (value.data as List).map((data) => CartModel.fromJson(data)).toList();
          checked = List<bool>.filled(carts.length, false);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  String formatTime(String timeString) {
    // Assuming the input is always correctly formatted as "HH:mm:ss.SSSSS"
    final time = DateTime.parse("1970-01-01 $timeString"); // Dummy date
    return DateFormat('HH:mm').format(time); // Format to "HH:mm"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          title: const Text('รายการนับซ้ำ'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var index = 0; index < carts.length; index++)
                        Row(
                          children: [
                            Visibility(
                              visible: showCheckbox,
                              child: Checkbox(
                                value: checked[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    checked[index] = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: double.infinity,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('เลขที่: ${carts[index].docno} ${carts[index].ismerge == 0 && carts[index].carts.isNotEmpty ? '(รวม)' : ''}',
                                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 1.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('วันที่: ${'${carts[index].docdate} เวลา${formatTime(carts[index].doctime)}'}'),
                                          Text('ผู้สร้าง: ${carts[index].creatorname}'),
                                        ],
                                      ),
                                      const SizedBox(height: 1.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                'คลัง: ${carts[index].whcode}~${carts[index].whname}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 1.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ที่เก็บ: ${carts[index].locationcode}~${carts[index].locationname}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ],
                                      ),
                                      if (carts[index].carts.isNotEmpty)
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(top: 1),
                                          child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Text((carts[index].ismerge == 0) ? 'ตะกร้าย่อย: ${carts[index].carts}' : 'ตะกร้าหลัก: ${carts[index].carts}'),
                                                ],
                                              )),
                                        ),
                                      const SizedBox(height: 1.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('ตะกร้าหลัก: ${carts[index].docref}'),
                                        ],
                                      ),
                                      const SizedBox(height: 1.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('สินค้า: ${carts[index].itemcount} รายการ'),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              IconButton(
                                                color: Colors.green,
                                                icon: const Icon(Icons.play_circle_outline),
                                                onPressed: () {
                                                  _showConfirmSendDialog(context, carts[index].docno);
                                                },
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              IconButton(
                                                color: Colors.blue,
                                                icon: const Icon(Icons.barcode_reader),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => DocDetailScreen(cart: carts[index], status: carts[index].status),
                                                    ),
                                                  ).then((value) {
                                                    getDocList();
                                                  });
                                                },
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                )),
                if (showCheckbox)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "ตะกร้าที่เลือก:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${checked.where((element) => element).length} รายการ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                if (showCheckbox)
                  for (int i = 0; i < checked.length; i++)
                    if (checked[i])
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('เลขที่: ${carts[i].docno}'),
                        ],
                      ),
                if (showCheckbox)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (checked.where((element) => element).length > 1) {
                            showCheckbox = false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartMergeScreen(cart: carts.where((element) => checked[carts.indexOf(element)]).toList()),
                              ),
                            ).then((value) {
                              checked = [];
                              getDocList();
                            });
                          } else {
                            if (checked.where((element) => element).length == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("กรุณาเลือกมากกว่า1ตะกร้า"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("กรุณาเลือกตะกร้า"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "รวมตะกร้า",
                          style: TextStyle(fontSize: 17),
                        )),
                  )
              ],
            ),
          ),
        ));
  }

  _showConfirmSendDialog(BuildContext context, String docno) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการทำงาน'),
          content: Text('คุณต้องการส่งตะกร้า $docno ใช่หรือไม่?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              child: const Text('ยืนยัน'),
              onPressed: () async {
                await _webServiceRepository.sendSubCart(docno).then((value) {
                  if (value.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("ส่งตะกร้าสำเร็จ"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    getDocList();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  _showConfirmationDialog(BuildContext context, String docno) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการทำงาน'),
          content: Text('คุณต้องการลบตะกร้า $docno ใช่หรือไม่?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              child: const Text('ยืนยัน'),
              onPressed: () async {
                await _webServiceRepository.deleteCart(docno).then((value) {
                  if (value.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("ลบตะกร้าสำเร็จ"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    getDocList();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
