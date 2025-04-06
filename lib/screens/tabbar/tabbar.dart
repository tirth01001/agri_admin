import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_dashboard/image_loader.dart';
import 'package:flutter_dashboard/my_screen/order_screen/order_screen.dart';
import 'package:flutter_dashboard/my_screen/product_screen/product_screen.dart';
import 'package:flutter_dashboard/screens/home/home.dart';
import 'package:flutter_dashboard/screens/profile/profile_screen.dart';
import 'package:flutter_dashboard/size_config.dart';

class TabbarItem {
  final String lightIcon;
  final String boldIcon;
  final String label;

  TabbarItem({required this.lightIcon, required this.boldIcon, required this.label});

  BottomNavigationBarItem item(bool isbold) {
    return BottomNavigationBarItem(
      icon: ImageLoader.imageAsset(isbold ? boldIcon : lightIcon),
      label: label,
    );
  }

  BottomNavigationBarItem get light => item(false);
  BottomNavigationBarItem get bold => item(true);
}

class FRTabbarScreen extends StatefulWidget {
  const FRTabbarScreen({super.key});
 
  @override
  State<FRTabbarScreen> createState() => _FRTabbarScreenState();
}

class _FRTabbarScreenState extends State<FRTabbarScreen> {
  int _select = 0;

  final screens = [
    const HomeScreen(
      title: 'Home',
    ),
    // const HomeScreen(
    //   title: '首页0',
    // ),
    const ProductScreen(),
    const OrderScreen(),
    // const TestScreen(title: 'Product')/
    // const TestScreen(title: 'Wallet'),
    const ProfileScreen(),
  ];

  static Image generateIcon(String path) {
    return Image.asset(
      '${ImageLoader.rootPaht}/tabbar/$path',
      width: 24,
      height: 24,
    );
  }

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      backgroundColor: Colors.black,
      icon: Icon(IconlyLight.chart,color: Colors.white,),
      activeIcon: Icon(IconlyBold.chart,color: Colors.white,),
      // icon: generateIcon('light/Home@2x.png'),
      // activeIcon: generateIcon('bold/Home@2x.png'),
      label: 'DashBoard',
      
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.black,
      icon: Icon(IconlyLight.bag,color: Colors.white,),
      activeIcon: Icon(IconlyBold.bag,color: Colors.white,),
      label: 'Products',
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.black,
      icon: Icon(IconlyLight.buy,color: Colors.white,),
      activeIcon: Icon(IconlyBold.buy,color: Colors.white,),
      label: 'Orders',
    ),
    // BottomNavigationBarItem(
    //   icon: generateIcon('light/Wallet@2x.png'),
    //   activeIcon: generateIcon('bold/Wallet@2x.png'),
    //   label: 'Wallet',
    // ),
    BottomNavigationBarItem(
      backgroundColor: Colors.black,
      icon: Icon(IconlyLight.profile,color: Colors.white,),
      activeIcon: Icon(IconlyBold.profile,color: Colors.white,),
      label: 'Profile',
    ),
  ];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: screens[_select],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        // backgroundColor: Colors.black,
        onTap: ((value) => setState(() => _select = value)),
        currentIndex: _select,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
        selectedItemColor: const Color(0xFF212121),
        unselectedItemColor: const Color(0xFF9E9E9E),
      ),
    );
  }
}
