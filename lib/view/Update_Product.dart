import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UPdateProduct extends StatefulWidget {  @override
State<UPdateProduct> createState() => _UPdateProductState();
}

class _UPdateProductState extends State<UPdateProduct> {
  final _formKey = GlobalKey<FormState>();
  final String apiUrl = 'http://192.168.1.11:3005/api/products';
  Map productData = {"id":"","name": "", "description": "", "price": ""};
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  update(){
    updateProduct(idController.text, {"name": nameController.text,"price":priceController.text,"description":descriptionController.text});
    Navigator.pop(context);
  }


  Future<void> updateProduct(String id, Map<String, dynamic> updates) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updates),
    );

    if (response.statusCode == 201) {
      // Product successfully updated
      print('Product updated successfully');
    } else {
      // Handle the error case here
      print(response.statusCode);
      print('Failed to update product');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  label: Text('Id'),
                ),
                controller: idController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Product Name'),
                ),
               controller: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                controller: descriptionController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Product price'),
                ),
                controller: priceController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: update,
                child: const Text("Update",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                ),
              )

              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        ),
      ),
    );
  }}
