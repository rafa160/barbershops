import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kabanas_barbershop/screens/home/home_module.dart';
import 'package:kabanas_barbershop/screens/infos/infos_module.dart';
import 'package:kabanas_barbershop/screens/infos/infos_page.dart';
import 'package:kabanas_barbershop/screens/profile/profile_module.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }


  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            HomeModule(),
            InfosModule(),
            ProfileModule()
          ]),
      bottomNavigationBar:  AnimationConfiguration.staggeredList(
          duration: const Duration(milliseconds: 1550),
          position: 1,
          child: SlideAnimation(
            verticalOffset: 150,
            child: FadeInAnimation(
              child:  ConvexAppBar(
                backgroundColor: Colors.white,
                color: Colors.black26,
                activeColor: Color(0xff40dedf),
                style: TabStyle.react,
                items: [
                  TabItem(icon: Icons.home, title: 'Home'),
                  TabItem(icon: Icons.info, title: 'Informações'),
                  TabItem(icon: Icons.person, title: 'Perfil'),
                ],
                initialActiveIndex: 0,
                onTap: (int i) => _pageController.jumpToPage(i),
              )
            ),
          )
      ),
    );
  }
}
