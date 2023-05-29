import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.8),
        title: const Text('Orders', style: TextStyle(color: Colors.black, fontFamily: 'AlfaSlabOne'),),
        
      ),
      
      body: ListView.builder(controller: ScrollController(),
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(orderData.orders[index]),
      ),
    );
  }
}
