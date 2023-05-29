
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late int _numOfItems;

  @override
  void initState() {
    super.initState();
    _numOfItems = 1;
  }

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    //final product= Provider.of<Product>(context,listen: false );

    return ChangeNotifierProvider.value(
      value: loadedProduct,
      child: Scaffold(
        backgroundColor: const Color(0XFFf1faee) ,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white.withOpacity(0.8),
          title: Text(
            loadedProduct.title!,
            style:
                const TextStyle(color: Colors.black, fontFamily: 'AlfaSlabOne'),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                //height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            5.0, // Move to right 5  horizontally
                            5.0,
                          ))
                    ],
                    color: Color(0xffe4f9ff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(400),
                        topRight: Radius.circular(5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 82,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffccc5b9),
                      ),
                      child: Text(
                        'Price : \$${loadedProduct.price}',
                        style: const TextStyle(
                            color: Color(0xffef476f),
                            fontSize: 26,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'AlfaSlabOne'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: const Color(0xfffce700).withOpacity(0.4),
                      ),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: Text(
                        loadedProduct.description!,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style:
                            const TextStyle(fontFamily: 'Lato', fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CartCounter(
                      numOfItems: _numOfItems,
                      onIncrease: () {
                        setState(() {
                          _numOfItems++;
                        });
                      },
                      onDecrease: () {
                        if (_numOfItems > 1) {
                          setState(() {
                            _numOfItems--;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Builder(builder: (BuildContext context) {
                            return FlatButton(
                              height: 55,
                              color: const Color(0xFF001427),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              // ignore: duplicate_ignore
                              onPressed: () {
                                cart.addItemByItemQuantity(
                                    loadedProduct.id.toString(),
                                    loadedProduct.price!,
                                    loadedProduct.title!,
                                    loadedProduct.image!,
                                    _numOfItems);

                                //
                                // ignore: deprecated_member_use
                                Scaffold.of(context).hideCurrentSnackBar();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text('Added $_numOfItems item to cart!'),
                                  duration: const Duration(milliseconds: 500),
                                  action: SnackBarAction(
                                      label: 'UNDO', onPressed: () {}),
                                ));
                              },
                              child: Text(
                                "add to cart".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Oxygen'),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Hero(
                tag: "${loadedProduct.id}",
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Image.asset(
                    width: 285,
                    height: 300,
                    loadedProduct.image!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                right: 40,
                bottom: 85,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    //color: const Color(0xFF94A0A1).withOpacity(0.8),
                  ),
                  child: IconButton(
                    icon: loadedProduct.isFavorite
                        ? SvgPicture.asset(
                            "assets/icons/favorite.svg",
                            color: const Color(0xfffa163f).withOpacity(0.9),
                            height: 33,
                          )
                        : SvgPicture.asset(
                            "assets/icons/favorite-border.svg",
                            color: const Color(0xfffa163f),
                            height: 30,
                          ),
                    onPressed: () {
                      setState(() {
                        loadedProduct.toggleFavoriteStatus();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//

class CartCounter extends StatelessWidget {
  final int numOfItems;
  final Function() onIncrease;
  final Function() onDecrease;

  const CartCounter({
    Key? key,
    required this.numOfItems,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildOutLineButton(
          icon: Icons.remove,
          press: onDecrease,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            numOfItems.toString().padLeft(2, '0'),
            style: const TextStyle(
                fontFamily: 'Oxygen', fontSize: 23, color: Colors.black),
          ),
        ),
        buildOutLineButton(
          icon: Icons.add,
          press: onIncrease,
        ),
      ],
    );
  }

  SizedBox buildOutLineButton({IconData? icon, required Function() press}) {
    return SizedBox(
      height: 28,
      width: 28,
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(2),
          alignment: Alignment.center,
          backgroundColor: Colors.white,
        ),
        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
    );
  }
}
