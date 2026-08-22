import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stellar_explorer/models/space_news_model.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatefulWidget {
  final SpaceNewsModel spaceNewsDetails;
  const NewsDetailScreen({super.key, required this.spaceNewsDetails});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {  
  String getFormattedDate(String dateString) {
    if (dateString == "N/A") return "Date Unknown";
    try {
      DateTime parsedDate = DateTime.parse(dateString).toLocal();
      return DateFormat('MMMM dd, yyyy • hh:mm a').format(parsedDate);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.40,
            pinned: true,
            backgroundColor: ColorPalettes.mainBackground,
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: const IconThemeData(color: ColorPalettes.primaryWhite),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.spaceNewsDetails.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: ColorPalettes.searchBarBg,
                      child: const Icon(Icons.newspaper, color: ColorPalettes.subTextGray, size: 50),
                    ),
                  ),
                  
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          ColorPalettes.mainBackground.withValues(alpha: 0.6),
                          ColorPalettes.mainBackground,
                        ],
                        stops: const [0.5, 0.85, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: ColorPalettes.electricBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorPalettes.electricBlue, width: 1),
                    ),
                    child: Text(
                      widget.spaceNewsDetails.newsSite.toUpperCase(),
                      style: const TextStyle(
                        color: ColorPalettes.electricBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  
                  Text(
                    widget.spaceNewsDetails.title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: ColorPalettes.primaryWhite,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded, color: ColorPalettes.subTextGray, size: 16),

                      const SizedBox(width: 6),
                      
                      Text(
                        getFormattedDate(widget.spaceNewsDetails.publishedAt),
                        style: const TextStyle(
                          color: ColorPalettes.subTextGray,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Divider(color: ColorPalettes.subTextGray.withValues(alpha: 0.2), thickness: 1),

                  const SizedBox(height: 20),
                  
                  const Text(
                    "Summary",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorPalettes.primaryWhite,
                    ),
                  ),
                                    
                  Text(
                    widget.spaceNewsDetails.summary,
                    textAlign: TextAlign.justify,
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false
                    ),
                    style: TextStyle(
                      color: ColorPalettes.primaryWhite.withValues(alpha: 0.85),
                      fontSize: 15,
                      height: 1.7, 
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorPalettes.electricBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                      ),
                      onPressed: () async {
                        final Uri url = Uri.parse(widget.spaceNewsDetails.newsSourceUrl,);

                        try {
                          bool launched = await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );

                          if (launched) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Opening Full Article...'),
                                ),
                              );
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Could not open the article. Please try again later.',
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid Article Link.'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "READ FULL ARTICLE",
                            style: TextStyle(
                              color: ColorPalettes.primaryWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),

                          SizedBox(width: 8),

                          Icon(Icons.open_in_new_rounded, color: ColorPalettes.primaryWhite, size: 18,)
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}