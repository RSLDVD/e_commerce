import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//
import '../providers/orders.dart' as oi;

class OrderItem extends StatefulWidget {
  final oi.OrderItem order;
  // ignore: use_key_in_widget_constructors
  const OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = true;



  
  @override
  Widget build(BuildContext context) {

    
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
      child: Column(
        children: <Widget>[
          ListTile(
            iconColor: const Color(0XFF00adb5),
            textColor: const Color(0XFFff5722),
            tileColor: const Color(0XFFeeeeee),
            title: Text(
              '\$${widget.order.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(DateFormat('EEE , dd/MM/yy , HH:mm')
                .format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 50 + 11, 270),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              child: ListView(
                  children: widget.order.products
                      .map(
                        (p) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    p.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    height: 38,
                                    alignment: Alignment.center,
                                    child: Image.asset(p.imageUrl.toString(),
                                        height: 30, width: 30),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${p.quantity} x \$${p.price.toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      )
                      .toList()),
            )
        ],
      ),
    );
  }
}
