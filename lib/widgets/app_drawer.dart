import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(width: MediaQuery.of(context).size.width/2,
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.white.withOpacity(0.8),
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text('My AppBar', style: TextStyle(color: Colors.black, fontFamily: 'Lato-Regular'),),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/shop.svg",
                height: 28,
              ),
              onPressed: () {Navigator.of(context).pushReplacementNamed('/');},
            ),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/order.svg",
                height: 28,
              ),
              onPressed: () {Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);},
            ),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/pencil-edit.svg",
                height: 28,
              ),
              onPressed: () {Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);},
            ),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
