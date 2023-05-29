import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
 
  @override
  Widget build(BuildContext context) {
     final productsData = Provider.of<Products>(context);
    //
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.8),
        title: const Text('Your Products', style: TextStyle(color: Colors.black, fontFamily: 'AlfaSlabOne'),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add_box_rounded))
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          controller: ScrollController(),
            itemCount: productsData.items.length,
            itemBuilder: ((_, index) => Column(
                  children: [
                    UserProductItem(
                        productsData.items[index].id!,
                        productsData.items[index].title!,
                        productsData.items[index].image!),
                    const Divider()
                  ],
                ))),
      ),
    );
    
  }
}