import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/core/client.dart';
import 'package:mobilestock/model/cart_model.dart';
import 'package:mobilestock/model/warehouse_location.dart';
import 'package:mobilestock/repository/webservice_repository.dart';
import 'package:mobilestock/global.dart' as global;

class CartFormScreen extends StatefulWidget {
  final CartModel cart;
  const CartFormScreen({super.key, required this.cart});

  @override
  State<CartFormScreen> createState() => _CartFormScreenState();
}

class _CartFormScreenState extends State<CartFormScreen> {
  final TextEditingController basketNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WarehouseModel selectedWarehouse = WarehouseModel();
  LocationModel selectedLocation = LocationModel();

  final WebServiceRepository _webServiceRepository = WebServiceRepository();
  List<WarehouseModel> warehouses = [];
  List<LocationModel> locations = [];
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getWareHouse();
    if (widget.cart.docno.isNotEmpty) {
      basketNumberController.text = widget.cart.docno;
      selectedWarehouse = WarehouseModel(code: widget.cart.whcode, name: widget.cart.whname);
      remarkController.text = widget.cart.remark;
      Future.delayed(const Duration(milliseconds: 300), () async {
        getLocation();
      });
    } else {
      basketNumberController.text = generateBasketNumber();
    }
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
          if (widget.cart.docno.isNotEmpty) {
            selectedLocation = LocationModel(code: widget.cart.locationcode, name: widget.cart.locationname);
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
        title: Text(
          (widget.cart.docno.isEmpty) ? 'สร้างตะกร้าตรวจนับ' : 'แก้ไขตะกร้าตรวจนับ',
          style: const TextStyle(fontWeight: FontWeight.w400),
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
              DropdownSearch<WarehouseModel>(
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
                enabled: selectedWarehouse.code.isNotEmpty && locations.isNotEmpty,
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
                        if (widget.cart.docno.isEmpty) {
                          await _webServiceRepository.createCart(basketNumberController.text, selectedWarehouse.code, selectedLocation.code, remarkController.text).then((value) {
                            if (value.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("สร้างตะกร้าสำเร็จ"),
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
                        } else {
                          await _webServiceRepository.updateCart(basketNumberController.text, selectedWarehouse.code, selectedLocation.code, remarkController.text).then((value) {
                            if (value.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("แก้ไขตะกร้าสำเร็จ"),
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
                      }
                    },
                    icon: const Icon(
                      Icons.save_alt_rounded,
                      color: Colors.white,
                    ),
                    label: Text(
                      (widget.cart.docno.isEmpty) ? "สร้างตะกร้า" : "แก้ไขตะกร้า",
                      style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
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
