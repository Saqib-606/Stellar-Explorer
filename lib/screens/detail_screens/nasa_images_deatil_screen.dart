import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stellar_explorer/models/nasa_images_model.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class NasaImagesDeatilScreen extends StatefulWidget {
  final NasaImagesModel imageDetails;
  const NasaImagesDeatilScreen({super.key, required this.imageDetails});

  @override
  State<NasaImagesDeatilScreen> createState() => _NasaImagesDeatilScreenState();
}

class _NasaImagesDeatilScreenState extends State<NasaImagesDeatilScreen> {
  String getFormattedDate(String dateString) {
    if (dateString == "N/A") return dateString;
    try {
      DateTime parsedDate = DateTime.parse(dateString).toLocal();
      return DateFormat('MMM dd, yyyy • hh:mm a').format(parsedDate);
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
            expandedHeight: screenHeight * 0.50, 
            pinned: true,
            backgroundColor: ColorPalettes.mainBackground,
            elevation: 0,
            scrolledUnderElevation: 0,
            iconTheme: const IconThemeData(color: ColorPalettes.primaryWhite),
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  widget.imageDetails.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: ColorPalettes.searchBarBg,
                    child: const Icon(Icons.image_not_supported, color: ColorPalettes.subTextGray, size: 50),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        ColorPalettes.mainBackground.withValues(alpha: 0.1),
                        ColorPalettes.mainBackground,
                      ],
                      stops: const [0.6, 0.85, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.imageDetails.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24, 
                      color: ColorPalettes.primaryWhite,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded, 
                        color: ColorPalettes.subTextGray, 
                        size: 16
                      ),

                      const SizedBox(width: 6),

                      Text(
                        getFormattedDate(widget.imageDetails.dateCreated),
                        style: const TextStyle(
                          color: ColorPalettes.subTextGray,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Divider(
                    color: ColorPalettes.subTextGray.withValues(alpha: 0.2), 
                    thickness: 1
                  ),

                  const SizedBox(height: 20),
                  
                  const Text(
                    "About this picture",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorPalettes.primaryWhite,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.imageDetails.description,
                    style: TextStyle(
                      color: ColorPalettes.primaryWhite.withValues(alpha: 0.9), 
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),                  

                  const SizedBox(height: 60,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}