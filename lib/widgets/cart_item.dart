// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
//
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String image;
   const CartItem(this.id, this.productId, this.price, this.quantity, this.title,
      this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 7,
            title: const Text('Are you sure!'),
            content: const Text(
                'Do you really want to remove this item from the cart ?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('NO')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('YES')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        alignment: Alignment.centerRight,
        color: const Color(0xffd62828).withOpacity(0.5),
        child: SvgPicture.asset(
          "assets/icons/delete.svg", colorBlendMode: BlendMode.color, 
          height: 34,
        ),
      ),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: SizedBox(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 35,
                // backgroundColor: Color(0xFFA9A3B2),
                backgroundColor:  const Color(0xFF111110).withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: Image.asset(image.toString(), fit: BoxFit.cover),
                  //  Text(
                  //   '\$$price',
                  //   style: const TextStyle(
                  //        color:  Color(0xffeeeeee),
                  //        fontWeight: FontWeight.w600,
                  //        fontSize: 15
                  //        ),
                  // ),
                ),
              ),
              title: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, fontFamily: 'Oxygen'),
              ),
              subtitle:
                  Text('Total:  \$${(price * quantity).toStringAsFixed(2)}'),
              trailing: Text('$quantity x'),
            ),
          ),
        ),
      ),
    );
  }
}
