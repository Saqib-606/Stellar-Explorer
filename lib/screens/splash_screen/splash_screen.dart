import 'package:flutter/material.dart';
import 'package:stellar_explorer/screens/dashboard_screens/navigation_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void nextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const NavigationScreen()),
        (value) => false,
      );
    }
  }
  
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(), 

              Container(
                height: 160, 
                width: 160,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorPalettes.subTextGray.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ],
                  border: Border.all(
                    color: ColorPalettes.subTextGray.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Image.asset(
                  "assets/images/Logo.png", 
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Stellar Explorer",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: ColorPalettes.primaryWhite,
                  letterSpacing: 1.5,
                ),
              ),

              const Text(
                "Your Gateway to the Cosmos",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorPalettes.subTextGray,
                  letterSpacing: 1.2,
                ),
              ),

              const Spacer(), 

              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Developed By Saqib",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Times New Roman',
                    color: ColorPalettes.subTextGray, 
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}