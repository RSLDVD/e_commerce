// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
//
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.8),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontFamily: 'AlfaSlabOne'),
        ),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: cart.itemCount == 0
              ? Center(child: Image.asset("assets/images/emptyCart.png", fit: BoxFit.contain),)
              : ListView.builder(
                controller: ScrollController(),
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) => CartItem(
                      cart.items.values.toList()[index].id,
                      cart.items.keys.toList()[
                          index], //map e CartItem use Key(productId) & value
                      cart.items.values.toList()[index].price,
                      cart.items.values.toList()[index].quantity,
                      cart.items.values.toList()[index].title,
                      cart.items.values.toList()[index].imageUrl.toString()),
                ),
        ),
        Card(
          color: const Color(0xffEEEEEE),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total ',
                    style: TextStyle(fontSize: 18, fontFamily: 'Oxygen'),
                  ),
                  //
                  Chip(
                      labelPadding: const EdgeInsets.all(5),
                      elevation: 3,
                      backgroundColor: const Color(0xffffff00),
                      //Theme.of(context).primaryColorLight,
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xff303841),
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )),
                  const Spacer(),
                  FlatButton(
                    color: const Color(0xffFA163F),
                     shape: RoundedRectangleBorder(
                       side: const BorderSide(
                         color: Color(0xff12CAD6),
                         width: 2.0,
                       ),
                       borderRadius: BorderRadius.circular(8.0),
                     ),
                    onPressed: () {
                      if (cart.totalAmount == 0) {
                        return;
                      } else {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                      }
                    },
                    child: const Text(
                      'ORDER NOW',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          color: Color(0xffeeeeee),
                          fontSize: 18),
                    ),
                  )
                ],
              )),
        ),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}
