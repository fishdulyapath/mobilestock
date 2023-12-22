import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobilestock/model/item_model.dart';
import 'package:mobilestock/repository/webservice_repository.dart';

class CartItemSearch extends StatefulWidget {
  const CartItemSearch({super.key});

  @override
  State<CartItemSearch> createState() => _CartItemSearchState();
}

class _CartItemSearchState extends State<CartItemSearch> {
  final TextEditingController _controller = TextEditingController();
  final WebServiceRepository _webServiceRepository = WebServiceRepository();
  Timer? _debounce;
  List<ItemModel> itemList = [];
  @override
  void initState() {
    getItemSearch();
    _controller.addListener(_onSearchChanged);
    super.initState();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), () {
      getItemSearch();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void getItemSearch() async {
    var search = _controller.text.isNotEmpty ? _controller.text : "";
    await _webServiceRepository.getItemSearch(search).then((value) {
      if (value.success) {
        setState(() {
          itemList = (value.data as List).map((data) => ItemModel.fromJson(data)).toList();
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
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        title: const Text('ค้นหาสินค้า'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: TextField(
              controller: _controller,
              onSubmitted: (String value) async {
                getItemSearch();
              },
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'ค้นหาสินค้า',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: itemList.length,
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
                  title: Text(itemList[index].itemname),
                  subtitle: Text("${itemList[index].barcode} | ${itemList[index].unitcode}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context, itemList[index]);
                  },
                ),
              );
            },
          ))
        ],
      )),
    );
  }
}
