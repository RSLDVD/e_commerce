// import 'package:flutter/material.dart';
// //
// import '../screens/orders_screen.dart';
// import '../screens/cart_screen.dart';
// import 'app_drawer.dart';

// class MyTabbedPage extends StatefulWidget {
//   static const routeName = '/my_tabbed_page';

//   @override
//   State<MyTabbedPage> createState() => _MyTabbedPageState();
// }

// class _MyTabbedPageState extends State<MyTabbedPage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         drawer: AppDrawer(),
//         appBar: AppBar(foregroundColor: Colors.black,
//             backgroundColor: const Color(0xfffefbe7),
//             toolbarHeight: 26,
//             bottom: const TabBar(tabs: [
//               Tab(
                  
//                   child: Text(
//                     'Cart',
//                     style: TextStyle(
//                         color: Colors.black87, fontFamily: 'TitanOne', fontSize: 16),
//                   )),
//               Tab(
//                   child: Text(
//                 'Orders',
//                 style:
//                     TextStyle(color: Colors.black87, fontFamily: 'TitanOne', fontSize: 16),
//               )),
//             ])),
//         body: TabBarView(children: [
//           CartScreen(),
//           OrdersScreen(),
//         ]),
//       ),
//     );
//   }
// }
