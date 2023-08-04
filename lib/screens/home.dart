import 'dart:async';
import 'package:adhicine/screens/add_medicine.dart';
import 'package:adhicine/screens/home_inside.dart';
import 'package:adhicine/screens/login.dart';
import 'package:adhicine/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adhicine/constants/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isNavHidden = false;
  StreamSubscription? subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      debugPrint("CONNECTION DEBUG MESSAGE${connectivityResult.name}");
      if (connectivityResult == ConnectivityResult.none) {
        // I am not connected to any network.
        showNoConnectionDialog(context);
      }
    });
  }

/*
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/add_medicine');
                          },
                          child: Center(child: Container(child: Text('Click me to add', style: TextStyle(fontSize: 40),),)))
                    ),
                    GestureDetector(
                        onTap: (){
                          logoutUser();
                        },
                        child: Text('LOGUUOT'))
                  ],
                ),
              ],
            )
        )
    );
  }
*/
  // Be sure to cancel subscription after you are done
  @override
  dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      handleAndroidBackButtonPress: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      hideNavigationBar: isNavHidden,
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle
          .style15, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeInside(),
      AddMedicine(),
      HomeInside(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.plus, color: Colors.white,),
          title: (" "),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: Colors.black,
          contentPadding: 10,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.report_problem_rounded),
        title: ("Report"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

    ];
  }
}