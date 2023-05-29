import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorites ;
  // ignore: use_key_in_widget_constructors
  const ProductGrid(this.showFavorites);
  @override
  Widget build(BuildContext context) {
    final producstData = Provider.of<Products>(context);
    final products =
        showFavorites ? producstData.favoriteItems : producstData.items;
    return GridView.builder(
        controller: ScrollController(),
        padding: const EdgeInsets.fromLTRB(18,4,18,0,),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.77,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7),
        itemCount: products.length,
        itemBuilder: ((ctx, index) => ChangeNotifierProvider.value(
            value: products[index], 
            child: ProductItem())));
  }
}
