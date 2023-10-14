import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final String apiUrl = 'http://192.168.1.11:3005/api/products';

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.1.11:3005/api/products'));
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }


  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 201) {
      print('Product deleted successfully');
    } else {
      print('Failed to delete product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products"),),
      body: FutureBuilder<List<dynamic>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Map<String, dynamic>> products = (snapshot.data as List).cast<Map<String, dynamic>>();
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                        leading: Text(products[index]['id'].toString()),
                        title: Text(products[index]['name']),
                        subtitle: Text('Price: ${products[index]['price']}'),
                        trailing: ElevatedButton(onPressed: () {
                          deleteProduct(products[index]['id']);
                          setState(() {
                          });
                        }, child: Text("Delete"),

                        ),
                      );
              },
            );
          }
        },
      ),
    );
  }
}
