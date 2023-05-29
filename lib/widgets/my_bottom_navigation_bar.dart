// import 'package:flutter/material.dart';
// import 'package:titled_navigation_bar/titled_navigation_bar.dart';

// import '../screens/edit_product_screen.dart';
// import '../screens/orders_screen.dart';
// import '../screens/product_overview_screen.dart';
// import 'my_tabbed_page.dart';
// //

// class MyBottomNavigationBar extends StatefulWidget {
//   const MyBottomNavigationBar({Key? key}) : super(key: key);

//   @override
//   State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
// }

// class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
//   final List<TitledNavigationBarItem> _items = [
//     TitledNavigationBarItem(icon: Icons.home, title: const Text('Home')),
//     TitledNavigationBarItem(icon: Icons.home, title: const Text('Cart')),
//     TitledNavigationBarItem(icon: Icons.home, title: const Text('Order')),
//     TitledNavigationBarItem(
//         icon: Icons.home, title: const Text('Manage Products')),
//   ];

//   int _currentIndex = 0;

//   void _onTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screens = [
//       ProductOverviewScreen(),
//       MyTabbedPage(),
//       OrdersScreen(),
//       EditProductScreen()
//     ];
//     return Scaffold(
//       body: screens[_currentIndex],
//       bottomNavigationBar:
//           TitledBottomNavigationBar(onTap: _onTap, items: _items, activeColor: Colors.red),
//     );
//   }
// }
