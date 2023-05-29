import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
//
//
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../util/my_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fourth_app/util/my_page_view.dart';
import 'package:fourth_app/widgets/animated_scrolling_text.dart';
//

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  final PageController _pagecontroller = PageController(initialPage: 0);
  late int _currentPage = 0;
  final _numPage = 5;

  get _timer => null;

  @override
  void initState() {
    // TODO: implement initState
    _startAutoScroll();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _stopAutoScroll();
    _pagecontroller.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < (_numPage - 1)) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pagecontroller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  void _stopAutoScroll() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFf1faee),
      drawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.8),
        title: Row(
          children: const [
            Text(
              'My ',
              style: TextStyle(
                  color: Color(0XFF5d2a42), fontFamily: 'AlfaSlabOne'),
            ),
            Text(
              'Shop',
              style: TextStyle(
                  color: Color(0XFFfb6376), fontFamily: 'AlfaSlabOne'),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
              color: Theme.of(context).scaffoldBackgroundColor,
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              elevation: 5,
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: FilterOptions.Favorites,
                      child: Text('Only Favorites'),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.All,
                      child: Text('Show All'),
                    ),
                  ]),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/search.svg",
                color: Colors.black, height: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const AnimatedScrollingText(),
            // page view
            const SizedBox(
              height: 7,
            ),

            SizedBox(
              height: 160,
              child: PageView(
                controller: _pagecontroller,
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  MyPageView(
                    color: Color(0xffFFC107),
                    image: "assets/images/shirt.png",
                  ),
                  MyPageView(
                    color: Color(0xff757575),
                    image: "assets/images/headphone.png",
                  ),
                  MyPageView(
                    color: Color(0xff7952B3),
                    image: "assets/images/shoes.png",
                  ),
                  MyPageView(
                    color: Color(0xff70d6ff),
                    image: "assets/images/short1.png",
                  ),
                  MyPageView(
                    color: Colors.black12,
                    image: "assets/images/short2.png",
                  ),
                ],
              ),
            ),

            SmoothPageIndicator(
              controller: _pagecontroller,
              count: 5,
              effect: const JumpingDotEffect(
                spacing: 5,
                activeDotColor: Color(0xffFF4500),
                dotHeight: 10,
                dotWidth: 10,
                jumpScale: .7,
                verticalOffset: 2,
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "women",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oxygen',
                        color: Colors.black),
                  ),
                ),
              ],
            ),

            SizedBox(
                height: 500,
                child: ProductGrid(
                  _showOnlyFavorites,
                )),
          ],
        ),
      ),
    );
  }
}
