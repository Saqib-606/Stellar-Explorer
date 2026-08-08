import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State <NewsScreen> createState () => _NewsScreenState();
}

class _NewsScreenState extends State <NewsScreen> {
  TextEditingController searchBar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      appBar: AppBar(
        backgroundColor: ColorPalettes.mainBackground,
        elevation: 0,
        scrolledUnderElevation: 0, 
        title: const Text(
          "Space News",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), 
          child: Column(
            children: [
              TextField(
                controller: searchBar,
                style: TextStyle(color: ColorPalettes.primaryWhite),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: ColorPalettes.primaryWhite,),
                  hintText: "Search Space",
                  hintStyle: const TextStyle(color: ColorPalettes.primaryWhite),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: ColorPalettes.searchBarBg)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: ColorPalettes.searchBarBg)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: ColorPalettes.searchBarBg, width: 2)
                  )
                ),
              ),

              const SizedBox(height: 30,),

              ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), 
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias, 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorPalettes.cardBackground,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "assets/images/ISS.jpg",
                                fit: BoxFit.cover,
                                height: 125,
                                width: 115,
                              ),
                            ),
                                      
                            const SizedBox(width: 15,),
                                      
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "NASA Webb Telescope Finds New Exoplanet",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                      color: ColorPalettes.primaryWhite
                                    ),
                                  ),
                        
                                  SizedBox(height: 10,),
                                            
                                  Row(
                                    children: [
                                      Text(
                                        "May 18, 2024",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorPalettes.subTextGray
                                        ),
                                      ),
                        
                                      Spacer(),
                        
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: ColorPalettes.subTextGray,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}