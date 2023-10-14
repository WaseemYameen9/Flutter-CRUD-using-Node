import 'package:assignmentdb/view/Update_Product.dart';
import 'package:assignmentdb/view/viewproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  Map productData = {"id":"","name": "", "description": "", "price": ""};

  ProductController controller = Get.put(ProductController());

   ProductViewScreen()
  {
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return ProductList();
        }));
  }

  addProduct() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      controller.addProduct(productData);
    }
  }

  UpdateProductScreen() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return UPdateProduct();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Id'),
                  ),
                  onSaved: (value) {
                    productData['id'] = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Product Name'),
                  ),
                  onSaved: (value) {
                    productData['name'] = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  onSaved: (value) {
                    productData['description'] = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Product price'),
                  ),
                  onSaved: (value) {
                    productData['price'] = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: addProduct,
                    child: const Text("Add",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                  ),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: ProductViewScreen,
                      child: const Text("View/Delete",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                    ),),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: UpdateProductScreen,
                    child: const Text("Update",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                    ),),
                )

                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          ),
        ),
      ),
    );
  }


}



