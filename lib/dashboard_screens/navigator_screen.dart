import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/navigation_provider.dart';
import 'package:stellar_explorer/dashboard_screens/explore_screen.dart';
import 'package:stellar_explorer/dashboard_screens/favorites_screen.dart';
import 'package:stellar_explorer/dashboard_screens/home_screen.dart';
import 'package:stellar_explorer/dashboard_screens/news_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State <NavigatorScreen> createState () => _NavigatorScreenState();
}

class _NavigatorScreenState extends State <NavigatorScreen> {
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = const [
      HomeScreen(),
      ExploreScreen(),
      NewsScreen(),
      FavoritesScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: Icon(Icons.favorite_rounded),
                label: "Favorites"
              ),
            ],
          );
        }
      )
    );
  }
}