import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stellar_explorer/models/launches_model.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class LaunchesDetailScreen extends StatefulWidget {
  final LaunchesModel lauchDetail;
  const LaunchesDetailScreen({super.key, required this.lauchDetail});

  @override
  State<LaunchesDetailScreen> createState() => _LaunchesDetailScreenState();
}

class _LaunchesDetailScreenState extends State<LaunchesDetailScreen> {
    String getFormattedDate(String dateString) {
    if (dateString == "N/A") return "Date TBD";
    try {
      DateTime parsedDate = DateTime.parse(dateString).toLocal();
      return DateFormat('MMMM dd, yyyy hh:mm a').format(parsedDate);
    } catch (e) {
      return dateString;
    }
  }

  Color _getStatusColor(String status) {
    String s = status.toLowerCase();
    if (s.contains("go") || s.contains("success")) return Colors.greenAccent;
    if (s.contains("tbd") || s.contains("hold")) return Colors.orangeAccent;
    if (s.contains("fail")) return Colors.redAccent;
    return ColorPalettes.electricBlue;
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
            expandedHeight: screenHeight * 0.45,
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
                    widget.lauchDetail.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: ColorPalettes.searchBarBg,
                      child: const Icon(Icons.rocket_launch, color: ColorPalettes.subTextGray, size: 50),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.lauchDetail.launchServiceProvider.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ColorPalettes.electricBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10,),
                  
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getStatusColor(widget.lauchDetail.status).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _getStatusColor(widget.lauchDetail.status), 
                            width: 1
                          ),
                        ),
                        child: Text(
                          widget.lauchDetail.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(widget.lauchDetail.status),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    widget.lauchDetail.name,
                    style: const TextStyle(
                      fontSize: 26,
                      color: ColorPalettes.primaryWhite,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorPalettes.cardBackground,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.timer_outlined, color: ColorPalettes.electricBlue),

                              const SizedBox(height: 10),

                              const Text(
                                "TARGET DATE",
                                style: TextStyle(
                                  color: ColorPalettes.subTextGray,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),
                              
                              Text(
                                getFormattedDate(widget.lauchDetail.net),
                                style: const TextStyle(
                                  color: ColorPalettes.primaryWhite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorPalettes.cardBackground,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on_outlined, color: ColorPalettes.electricBlue),

                              const SizedBox(height: 10),

                              const Text(
                                "LAUNCH PAD",
                                style: TextStyle(
                                  color: ColorPalettes.subTextGray,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                widget.lauchDetail.pad,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: ColorPalettes.primaryWhite, fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Mission Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorPalettes.primaryWhite,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    widget.lauchDetail.missionDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: ColorPalettes.primaryWhite.withValues(alpha: 0.85),
                      fontSize: 15,
                      height: 1.6, 
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