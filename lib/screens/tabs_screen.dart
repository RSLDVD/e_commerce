import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourth_app/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/badge.dart';
import 'user_products_screen.dart';
import 'orders_screen.dart';
import 'product_overview_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/shopify.svg",
          color: Colors.black54,
          height: 28,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Consumer<Cart>(
          builder: ((_, Cart, ch) => Badge(
                childWidget: IconButton(
            icon: SvgPicture.asset("assets/icons/shopping-cart.svg",
                color: Colors.black, height: 28),
            onPressed: () {},
          ),
                value: Cart.itemCount.toString(),
                color: const Color(0XFFef476f),
              )),
          // child: IconButton(
          //   icon: SvgPicture.asset("assets/icons/shopping-cart.svg",
          //       color: Colors.black, height: 28),
          //   onPressed: () {},
          // ),
        ),

        // icon:
        // SvgPicture.asset(
        //   "assets/icons/shopping-cart.svg",
        //   color: Colors.black54,
        //   height: 26,
        // ),
        label: 'Cart'),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/orders.svg",
          height: 30,
          color: Colors.black54,
        ),
        label: 'Orders'),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/edit.svg",
          color: Colors.black54,
          height: 24,
        ),
        label: 'Manage Products'),
  ];
  //
  final List<Widget> _screens = [
    ProductOverviewScreen(),
    const CartScreen(),
    const OrdersScreen(),
    UserProductsScreen()
  ];
  //
  int _currentIndex = 0;
  //
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 24,
        items: _items,
        onTap: _onTap,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
