import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductController extends GetxController {  

  static const apiBaseUrl = 'http://192.168.1.11:3005/api/';

  List<ProductModel> allProduct = [];

  Future<void> addProduct(Map productData) async {
    var url = Uri.parse(apiBaseUrl + 'products');

    try {
      final response = await http.post(url, body: productData);
      if (response.statusCode == 200) {
        print(json.decode(response.body));

        var r = json.decode(response.body);
        print(r['code']);
        Get.back();
      }
    } catch (error) {
      print(error);
    }
  }

  getProduct() async {
    allProduct = [];
    var url = Uri.parse(apiBaseUrl + 'products');
    List<ProductModel> helperList = [];
    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 201) {
        var productResponse = json.decode(response.body);

        productResponse['productData'].forEach((result) => {
              helperList.add(ProductModel(
                  id: result['id'],
                  name: result['name'],
                  description: result['description'],
                  price: result['price']))
            });
      }
      allProduct.addAll(helperList);
      update();
    } catch (error) {
      print(error);
    }
  }
}
