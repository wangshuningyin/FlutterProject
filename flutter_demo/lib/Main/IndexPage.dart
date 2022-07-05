import 'package:flutter/material.dart';
import 'package:flutter_demo/Home/HomePage.dart';
import 'package:flutter_demo/Me/PersonalCenterPage.dart';

class Indexpage extends StatefulWidget {
  const Indexpage({Key? key}) : super(key: key);
  @override
  _IndexpageState createState() => _IndexpageState();
}

class _IndexpageState extends State<Indexpage> {
  List<Widget> taBodies = [
    const HomePage(title: 'Home'),
    const PersonalCenterPage()
  ];
  int currentIndex = 0;
  //创建页面控制器
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  List<BottomNavigationBarItem> bottomtabs = [
    BottomNavigationBarItem(
      icon: Image.asset(
        "lib/images/2.0x/home_normal@2x.png",
        fit: BoxFit.cover,
        width: 20,
        height: 20,
      ),
      activeIcon: Image.asset(
        "lib/images/2.0x/home_select.png",
        fit: BoxFit.cover,
        width: 20,
        height: 20,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        "lib/images/2.0x/me_normal.png",
        fit: BoxFit.cover,
        width: 20,
        height: 20,
      ),
      activeIcon: Image.asset(
        "lib/images/2.0x/me_select.png",
        fit: BoxFit.cover,
        width: 20,
        height: 20,
      ),
      label: 'Me',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(147, 24, 24, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomtabs,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            // _pageController = taBodies[currentIndex];
            _pageController.jumpToPage(index);
            print(currentIndex);
          });
        },
      ),
      body: PageView(
        controller: _pageController,
        children: taBodies,
      ),
    );
  }
}
