import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/core/client.dart';
import 'package:mobilestock/model/cart_model.dart';
import 'package:mobilestock/model/warehouse_location.dart';
import 'package:mobilestock/repository/webservice_repository.dart';
import 'package:mobilestock/global.dart' as global;

class CartMergeScreen extends StatefulWidget {
  final List<CartModel> cart;
  const CartMergeScreen({super.key, required this.cart});

  @override
  State<CartMergeScreen> createState() => _CartMergeScreenState();
}

class _CartMergeScreenState extends State<CartMergeScreen> {
  final TextEditingController basketNumberController = TextEditingController();
  final TextEditingController docdateTime = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WarehouseModel selectedWarehouse = WarehouseModel();
  LocationModel selectedLocation = LocationModel();

  final WebServiceRepository _webServiceRepository = WebServiceRepository();
  List<WarehouseModel> warehouses = [];
  List<LocationModel> locations = [];
  TextEditingController remarkController = TextEditingController();
  TextEditingController cartsController = TextEditingController();
  TextEditingController userCodeController = TextEditingController(text: "${global.userCode}~${global.userName}");
  @override
  void initState() {
    super.initState();

    if (widget.cart.isNotEmpty) {
      basketNumberController.text = generateBasketNumber();
      selectedWarehouse = WarehouseModel(code: widget.cart[0].whcode, name: widget.cart[0].whname);

      docdateTime.text = "${widget.cart[0].docdate} ${formatTime(widget.cart[0].doctime)}";
      for (var ele in widget.cart) {
        cartsController.text += "${ele.docno}\n";
      }
      remarkController.text = widget.cart[0].remark;
      Future.delayed(const Duration(milliseconds: 300), () async {
        getLocation();
      });
    }
  }

  String formatTime(String timeString) {
    // Assuming the input is always correctly formatted as "HH:mm:ss.SSSSS"
    final time = DateTime.parse("1970-01-01 $timeString"); // Dummy date
    return DateFormat('HH:mm').format(time); // Format to "HH:mm"
  }

  void getWareHouse() async {
    await _webServiceRepository.getWarehouse().then((value) {
      if (value.success) {
        setState(() {
          warehouses = (value.data as List).map((data) => WarehouseModel.fromJson(data)).toList();
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

  void getLocation() async {
    await _webServiceRepository.getLocation(selectedWarehouse.code).then((value) {
      if (value.success) {
        setState(() {
          locations = (value.data as List).map((data) => LocationModel.fromJson(data)).toList();
          if (widget.cart[0].docno.isNotEmpty) {
            selectedLocation = LocationModel(code: widget.cart[0].locationcode, name: widget.cart[0].locationname);
          }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        title: const Text(
          'รวมตะกร้า',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: basketNumberController,
                decoration: const InputDecoration(
                  labelText: 'เลขที่',
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Prevent editing
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: docdateTime,
                decoration: const InputDecoration(
                  labelText: 'วันเวลาตรวจนับ',
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Prevent editing
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: userCodeController,
                decoration: const InputDecoration(
                  labelText: 'ผู้สร้าง',
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Prevent editing
              ),
              const SizedBox(height: 16.0),
              DropdownSearch<WarehouseModel>(
                enabled: false,
                popupProps: const PopupProps.bottomSheet(
                  showSearchBox: true,
                ),
                items: warehouses,
                itemAsString: (item) => "${item.code}~${item.name}",
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "คลัง",
                    hintText: "เลือกคลัง",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                onChanged: (WarehouseModel? val) {
                  setState(() {
                    selectedWarehouse = val!;
                    locations = [];
                  });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    getLocation();
                    selectedLocation = LocationModel();
                  });
                },
                selectedItem: selectedWarehouse,
              ),
              const SizedBox(height: 16.0),
              DropdownSearch<LocationModel>(
                enabled: false,
                popupProps: const PopupProps.bottomSheet(
                  showSearchBox: true,
                ),
                items: locations,
                itemAsString: (item) => "${item.code}~${item.name}",
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "ที่เก็บ",
                    hintText: "เลือกที่เก็บ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                onChanged: (LocationModel? val) {
                  selectedLocation = val!;
                },
                selectedItem: selectedLocation,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: cartsController,
                decoration: const InputDecoration(
                  labelText: 'ตะกร้าที่เลือก',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: remarkController,
                decoration: const InputDecoration(
                  labelText: 'หมายเหตุ',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green.shade600,
                    ),
                    onPressed: () async {
                      if (selectedWarehouse.code.isEmpty || selectedLocation.code.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("กรุณาเลือกคลังและที่เก็บ"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      } else {
                        var cartsarr = widget.cart.map((e) => e.docno).toList();
                        String result = cartsarr.join(',');

                        await _webServiceRepository
                            .mergeCart(basketNumberController.text, widget.cart[0].docdate, widget.cart[0].doctime, selectedWarehouse.code, selectedLocation.code,
                                remarkController.text, result)
                            .then((value) {
                          if (value.success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("สร้างตะกร้ารวมสำเร็จ"),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Navigator.of(context).pop("success");
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
                    },
                    icon: const Icon(
                      Icons.save_alt_rounded,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "สร้างตะกร้า",
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  String generateBasketNumber() {
    var now = DateTime.now();
    var random = Random();
    String year = now.year.toString().padLeft(4, '0');
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    String randomDigits = (random.nextInt(9000) + 1000).toString();
    return 'SC${global.branchCode}$year$month$day$hour$minute$randomDigits';
  }
}
