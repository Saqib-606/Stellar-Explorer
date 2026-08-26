import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/navigation_provider.dart';
import 'package:stellar_explorer/screens/dashboard_screens/explore_screen.dart';
import 'package:stellar_explorer/screens/dashboard_screens/earth_watch_screen.dart';
import 'package:stellar_explorer/screens/dashboard_screens/home_screen.dart';
import 'package:stellar_explorer/screens/dashboard_screens/news_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State <NavigationScreen> createState () => _NavigationScreenState();
}

class _NavigationScreenState extends State <NavigationScreen> {
  late final List<Widget> screens;
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();
    screens = const [
      HomeScreen(),
      ExploreScreen(),
      NewsScreen(),
      EarthWatchScreen()
    ];
  }
  
  void _onBackPressed () {
    final now = DateTime.now();

    if (_lastBackPressed == null || now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      Fluttertoast.showToast(
        msg: "Press again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
      );

      return;
    }
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onBackPressed();
        }
      },
      child: Scaffold(
        backgroundColor: ColorPalettes.mainBackground,
        body: Consumer<NavigationProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: IndexedStack(
                index: provider.currentIndex,
                children: screens,
              ),
            );
          }
        ),
        bottomNavigationBar: Consumer<NavigationProvider>(
          builder: (context, provider, child) {
            return BottomNavigationBar(
              backgroundColor: ColorPalettes.cardBackground,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorPalettes.electricBlue,
              unselectedItemColor: ColorPalettes.subTextGray,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home"
                ),
            
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_rounded),
                  label: "Explore"
                ),
            
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper_rounded),
                  label: "News"
                ),
            
                BottomNavigationBarItem(
                  icon: Icon(Icons.public_rounded),
                  label: "Earth Watch"
                ),
              ],
            );
          }
        )
      ),
    );
  }
}