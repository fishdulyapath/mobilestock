import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobilestock/features/cart/cart_item_search.dart';
import 'package:mobilestock/model/cart_model.dart';
import 'package:mobilestock/model/item_model.dart';
import 'package:mobilestock/repository/webservice_repository.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CartDetailScreen extends StatefulWidget {
  final CartModel cart;
  final int ismerge;
  const CartDetailScreen({super.key, required this.cart, required this.ismerge});

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final WebServiceRepository _webServiceRepository = WebServiceRepository();
  FocusNode textfocusNode = FocusNode();
  List<ItemScanModel> itemScanList = [];
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _controller.text += barcodeScanRes;
      getItemDetail();
    });

    // if (barcodeScanRes != '-1') {
    //   setState(() {
    //     _controller.text += barcodeScanRes;
    //     getItemDetail();
    //   });
    // }
  }

  void getItemDetail() async {
    var textsplit = _controller.text.split('*');
    var barcode = "";
    var qty = 1;
    if (textsplit.length > 1) {
      barcode = textsplit[1];
      qty = int.parse(textsplit[0]);
    } else {
      barcode = textsplit[0];
    }
    await _webServiceRepository.getItemDetail(barcode, widget.cart.whcode, widget.cart.locationcode).then((value) {
      if (value.success) {
        textfocusNode.requestFocus();
        if (value.data.length > 0) {
          ItemModel item = ItemModel.fromJson(value.data[0]);

          ItemScanModel checkdata =
              itemScanList.firstWhere((ele) => ele.barcode == item.barcode, orElse: () => ItemScanModel(barcode: "", itemcode: "", unitcode: "", itemname: ""));

          if (checkdata.barcode == "") {
            setState(() {
              itemScanList.add(ItemScanModel(
                  barcode: item.barcode, itemcode: item.itemcode, unitcode: item.unitcode, itemname: item.itemname, qty: qty, balanceqty: double.parse(item.balanceqty)));
              _controller.text = "";
            });
          } else {
            setState(() {
              itemScanList[itemScanList.indexOf(checkdata)].qty += qty;
              _controller.text = "";
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("ไม่พบข้อมูลสินค้า"),
              backgroundColor: Colors.red,
            ),
          );
        }
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

  void getCartDetail() async {
    await _webServiceRepository.getCartDetail(widget.cart.docno).then((value) {
      if (value.success) {
        if (value.data.length > 0) {
          setState(() {
            itemScanList = (value.data as List).map((data) => ItemScanModel.fromJson(data)).toList();
          });
        }
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

  @override
  void initState() {
    getCartDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (itemScanList.isNotEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('ยืนยันการออก'),
                    content: const Text('ต้องการออกจากหน้านี้ใช่หรือไม่?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop("");
                        },
                        child: const Text('ยกเลิก'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('ยืนยัน'),
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        title: const Text('รายละเอียดสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'เลขที่: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.cart.docno,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'วันที่: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.cart.docdate,
                    style: const TextStyle(fontSize: 16),
                  ),
                ])),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'คลัง: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.cart.whname,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'ที่เก็บ: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.cart.locationname,
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
            ),
            const Divider(
              thickness: 1,
            ),
            if (widget.ismerge == 0)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        getItemDetail();
                      },
                      focusNode: textfocusNode,
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Scan result',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final res = Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartItemSearch(),
                        ),
                      );
                      res.then((value) {
                        if (value != null) {
                          ItemModel item = value as ItemModel;
                          setState(() {
                            _controller.text += item.barcode;
                            getItemDetail();
                          });
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      scanBarcodeNormal();
                    },
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                  itemCount: itemScanList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey, // Color of the border
                              width: 1.0, // Width of the border
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Text(
                            itemScanList[index].qty.toString(),
                            style: const TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                          title: Text(itemScanList[index].itemname),
                          subtitle: Text("${itemScanList[index].barcode} ${itemScanList[index].unitcode}"),
                          trailing: (widget.ismerge == 0)
                              ? IconButton(
                                  onPressed: () {
                                    _showConfirmDialog(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              : const SizedBox(
                                  width: 0,
                                ),
                        ));
                  }),
            ),
            if (widget.ismerge == 0)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, foregroundColor: Colors.white),
                  onPressed: () {
                    _showConfirmSaveDialog();
                  },
                  child: const Text('บันทึก'),
                ),
              )
          ],
        ),
      ),
    );
  }

  _showConfirmDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),
          content: const Text('ต้องการลบรายการนี้ใช่หรือไม่?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  itemScanList.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }

  _showConfirmSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการบันทึก'),
          content: const Text('ต้องการบันทึกข้อมูลใช่หรือไม่?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop("");
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () async {
                await _webServiceRepository.saveCartDetail(itemScanList, widget.cart).then((value) {
                  if (value.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("บันทึกสำเร็จ"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
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
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }
}
