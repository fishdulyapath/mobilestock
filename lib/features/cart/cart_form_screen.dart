import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/model/warehouse_location.dart';

class CartFormScreen extends StatefulWidget {
  final String docno;
  const CartFormScreen({super.key, required this.docno});

  @override
  State<CartFormScreen> createState() => _CartFormScreenState();
}

class _CartFormScreenState extends State<CartFormScreen> {
  final TextEditingController basketNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WarehouseModel selectedWarehouse = WarehouseModel();
  LocationModel selectedLocation = LocationModel();
  final List<WarehouseModel> warehouses = [
    WarehouseModel(code: 'WH01', name: 'คลังสินค้า 1'),
    WarehouseModel(code: 'WH02', name: 'คลังสินค้า 2'),
    WarehouseModel(code: 'WH03', name: 'คลังสินค้า 3')
  ];
  final List<LocationModel> locations = [
    LocationModel(code: 'LOC01', name: 'ที่เก็บ 1'),
    LocationModel(code: 'LOC02', name: 'ที่เก็บ 2'),
    LocationModel(code: 'LOC03', name: 'ที่เก็บ 3')
  ];

  @override
  void initState() {
    super.initState();
    if (widget.docno.isNotEmpty) {
      basketNumberController.text = widget.docno;
    } else {
      basketNumberController.text = generateBasketNumber();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        title: const Text(
          'สร้างตะกร้าตรวจนับ',
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
                  selectedWarehouse = val!;
                },
                selectedItem: selectedWarehouse,
              ),
              const SizedBox(height: 16.0),
              DropdownSearch<LocationModel>(
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
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
    return '$year$month$day$hour$minute$randomDigits';
  }
}
