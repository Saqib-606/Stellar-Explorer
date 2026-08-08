import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/navigation_provider.dart';
import 'package:stellar_explorer/screens/dashboard_screens/navigator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData( // To remove flutter default Bottom Navigation Bar Effect
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        home: const NavigatorScreen(),
      ),
    );
  }
}