import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
//
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

// final String id ;
// final String title ;
// final String imageUrl ;

// ProductItem(this.id, this.title, this.imageUrl);
//
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.5, color: const Color(0xff181818).withOpacity(0.9)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xfff2542d),
                ),
                height: 22,
                width: 32,
                margin: const EdgeInsets.fromLTRB(0.2, 0.2, 0.2, 0.2),
                padding: const EdgeInsets.all(2),
                child: const Center(
                  child:  Text(
                    'NEW',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Knewave',
                        //fontWeight: FontWeight.w700,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          // ignore: sort_child_properties_last
          footer: GridTileBar(
            backgroundColor: const Color(0xFFced4da).withOpacity(0.5),
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                softWrap: true,
                textAlign: TextAlign.start,
                product.title!,
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Allura',
                    //fontWeight: FontWeight.bold,
                    color: Color(0xFF222831)),
              ),
            ),
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: product.isFavorite
                    ? SvgPicture.asset(
                        "assets/icons/favorite.svg",
                        color: const Color(0xfffe161d).withOpacity(0.9),
                        height: 30,
                      )
                    : SvgPicture.asset("assets/icons/favorite-border.svg",
                        color: const Color(0xfffe161d).withOpacity(0.7)),
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
              ),
            ),
            trailing: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/shopping-cart-add.svg",
                color: const Color(0XFFff005c),
              ),
              onPressed: () {
                cart.addItem(product.id!, product.price!, product.title!,
                    product.image.toString());
                // ignore: deprecated_member_use
                Scaffold.of(context).hideCurrentSnackBar();
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: const Text('Added item to cart!'),
                  duration: const Duration(milliseconds: 500),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeLastItem(product.id!);
                      }),
                ));
              },
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 60, top: 30),
              color: const Color(0xffE9EAE0),
              alignment: Alignment.center,
              child: Hero(
                tag: "${product.id}",
                child: Image.asset(
                  scale: 0.8,
                  fit: BoxFit.contain,
                  product.image.toString(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
