import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/space_news_provider.dart';
import 'package:stellar_explorer/screens/detail_screens/news_detail_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';
import 'package:intl/intl.dart'; // Required for Date Formatting

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  TextEditingController searchBar = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SpaceNewsProvider>().fetchSpaceNewsData();
    });
  }

  String getFormattedDate(String dateString) {
    if (dateString == "N/A") return dateString;
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return dateString; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      appBar: AppBar(
        backgroundColor: ColorPalettes.mainBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "News",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: ColorPalettes.primaryWhite,
        backgroundColor: ColorPalettes.cardBackground,
        onRefresh: () async {
          await context.read<SpaceNewsProvider>().refreshSpaceNewsData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: searchBar,
                  cursorColor: ColorPalettes.primaryWhite,
                  style: const TextStyle(color: ColorPalettes.primaryWhite),
                  textInputAction: TextInputAction.search,  // Brings Search Icon on Keyboard
                  onChanged: (value) {
                    if (value.isEmpty) {
                      context.read<SpaceNewsProvider>().searchNewsData("");
                    }
                  },
                  onSubmitted: (value) {
                    context.read<SpaceNewsProvider>().searchNewsData(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search,color: ColorPalettes.primaryWhite,),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: ColorPalettes.subTextGray,),
                      onPressed: () {
                        searchBar.clear();
                        FocusScope.of(context).unfocus();  // Hide Keyboard
                        context.read<SpaceNewsProvider>().searchNewsData("");
                      },
                    ),
                    hintText: "Search space news...",
                    hintStyle: const TextStyle(color: ColorPalettes.primaryWhite),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: ColorPalettes.searchBarBg),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: ColorPalettes.searchBarBg,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: ColorPalettes.searchBarBg,width: 2,),
                    ),
                  ),
                ),
                    
                const SizedBox(height: 30),
                    
                Consumer<SpaceNewsProvider>(
                  builder: (context, provider, child) {
                    if (provider.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: CircularProgressIndicator(
                            color: ColorPalettes.electricBlue,
                          ),
                        ),
                      );
                    }
                    
                    if (provider.errorMessage.isNotEmpty) {
                      return Center(
                        child: Text(
                          provider.errorMessage,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      );
                    }
                    
                    return ListView.builder(
                      itemCount: provider.spaceNews.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final spaceNews = provider.spaceNews[index];
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
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(spaceNewsDetails: spaceNews),
                                ));
                              },
                              child: Row(
                                children: [
                                 ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      spaceNews.imageUrl,
                                      fit: BoxFit.cover,
                                      height: 125,
                                      width: 115,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        height: 125,
                                        width: 125,
                                        color: ColorPalettes.searchBarBg,
                                        child: const Icon(Icons.image_not_supported, color: ColorPalettes.subTextGray),
                                      ),
                                    ),
                                  ),
                    
                                  const SizedBox(width: 15),
                                  
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5,),
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            spaceNews.newsSite.toUpperCase(),
                                            style: const TextStyle(
                                              color: ColorPalettes.electricBlue, // Assuming you have this color
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                    
                                          const SizedBox(height: 5),
                    
                                          Text(
                                            spaceNews.title,
                                            maxLines:2, 
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3,
                                              color: ColorPalettes.primaryWhite,
                                            ),
                                          ),
                    
                                          const SizedBox(height: 10),
                    
                                          Row(
                                            children: [
                                              Text(
                                                getFormattedDate(spaceNews.publishedAt,),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: ColorPalettes.subTextGray,
                                                ),
                                              ),
                    
                                              const Spacer(),
                    
                                              const Padding(
                                                padding: EdgeInsets.only(right: 15,),
                                                child: Icon(
                                                  Icons.arrow_forward_ios_rounded,
                                                  color:ColorPalettes.subTextGray,
                                                  size: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}