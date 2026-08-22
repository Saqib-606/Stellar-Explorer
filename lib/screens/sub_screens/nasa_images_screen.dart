import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/nasa_image_provider.dart';
import 'package:stellar_explorer/screens/detail_screens/nasa_images_deatil_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class NasaImagesScreen extends StatefulWidget {
  const NasaImagesScreen({super.key});

  @override
  State <NasaImagesScreen> createState() => _NasaImagesScreenState();
}

class _NasaImagesScreenState extends State <NasaImagesScreen> {
  TextEditingController searchBar = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NasaImageProvider>().fetchNasaImages("andromeda galaxy");
    });
  }

  @override
  void dispose () {
    searchBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      appBar: AppBar(
        backgroundColor: ColorPalettes.mainBackground,
        elevation: 0,
        scrolledUnderElevation: 0,  
        iconTheme: const IconThemeData(color: ColorPalettes.primaryWhite),
        title: const Text(
          "NASA Images",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: searchBar,
                cursorColor: ColorPalettes.primaryWhite,
                style: const TextStyle(color: ColorPalettes.primaryWhite),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: ColorPalettes.primaryWhite,),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: ColorPalettes.subTextGray,),
                    onPressed: () {
                      searchBar.clear();
                      context.read<NasaImageProvider>().clearImages();
                      context.read<NasaImageProvider>().fetchNasaImages("andromeda galaxy");
                    },
                  ),
                  hintText: "Search space images....",
                  hintStyle: const TextStyle(color: ColorPalettes.primaryWhite),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: ColorPalettes.searchBarBg)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: ColorPalettes.searchBarBg)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: ColorPalettes.searchBarBg, width: 2)
                  )
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    context.read<NasaImageProvider>().fetchNasaImages(value.trim());
                  }
                },
              ),

              const SizedBox(height: 20,),

              Consumer<NasaImageProvider>(
                builder: (context, provider, child) {
                  if (provider.loading) {
                    return const Center(child: CircularProgressIndicator(color: ColorPalettes.primaryWhite));
                  }
                  if (provider.errorMessage.isNotEmpty) {
                    return Center(child: Text(provider.errorMessage, style: TextStyle(color: Colors.red)));
                  }

                  if (provider.imageList.isEmpty) {
                    return const Center(child: Text("No images found", style: TextStyle(color: ColorPalettes.primaryWhite)));
                  }

                  return GridView.builder(
                    itemCount: provider.imageList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8
                    ),
                    itemBuilder: (context, index) {
                      final currentData = provider.imageList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => NasaImagesDeatilScreen(imageDetails: currentData,),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.2), width: 1),
                            image: DecorationImage(
                              image: NetworkImage(currentData.imageUrl),
                              fit: BoxFit.cover
                            )
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.8),
                                  Colors.transparent
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        currentData.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: ColorPalettes.primaryWhite,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8,),
                            
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: ColorPalettes.primaryWhite,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              ),

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}