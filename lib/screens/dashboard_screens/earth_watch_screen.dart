import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:stellar_explorer/provider/earth_watch_provider.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class EarthWatchScreen extends StatefulWidget {
  const EarthWatchScreen({super.key});

  @override
  State<EarthWatchScreen> createState() => _EarthWatchScreenState();
}

class _EarthWatchScreenState extends State<EarthWatchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EarthWatchProvider>().fetchEarthWatchData();
    });
  }

  String getFormattedDate(String dateString) {
    if (dateString == "N/A" || dateString.isEmpty) return "Date Unknown";
    try {
      DateTime parsedDate = DateTime.parse(dateString).toLocal();
      return DateFormat('MMM dd, yyyy • hh:mm a').format(parsedDate);
    } catch (e) {
      return dateString;
    }
  }

  IconData getIconForCategory(String category) {
    final cat = category.toLowerCase();
    if (cat.contains("storm") || cat.contains("cyclone")) return Icons.cyclone_rounded;
    if (cat.contains("volcano")) return Icons.landscape_rounded;
    if (cat.contains("fire") || cat.contains("wildfire")) return Icons.local_fire_department_rounded;
    if (cat.contains("ice") || cat.contains("sea")) return Icons.ac_unit_rounded;
    return Icons.warning_rounded; 
  }

  Color getColorForCategory(String category) {
    final cat = category.toLowerCase();
    if (cat.contains("storm") || cat.contains("cyclone")) return Colors.blueAccent;
    if (cat.contains("volcano")) return Colors.redAccent;
    if (cat.contains("fire") || cat.contains("wildfire")) return Colors.orangeAccent;
    if (cat.contains("ice") || cat.contains("sea")) return Colors.cyanAccent;
    return Colors.amberAccent; 
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
          "Earth Watch",
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
          await context.read<EarthWatchProvider>().refreshEarthWatchData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: ColorPalettes.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: ColorPalettes.subTextGray.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Global Natural Events",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalettes.primaryWhite,
                                ),
                              ),

                              SizedBox(height: 8),
                              
                              Text(
                                "Track live severe storms, wildfires, and volcanic activity via NASA EONET.",
                                style: TextStyle(
                                  color: ColorPalettes.subTextGray,
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                          child: Container(
                            color: Colors.blueGrey.withValues(alpha: 0.3),
                            child: const Center(
                              child: Icon(
                                Icons.public_rounded,
                                size: 60,
                                color: ColorPalettes.subTextGray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 25),
                
                Consumer<EarthWatchProvider>(
                  builder: (context, provider, child) {
                    if (provider.loading) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "Active Events",
                              style: TextStyle(
                                color: ColorPalettes.primaryWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 50), 
                          
                          const Center(
                            child: CircularProgressIndicator(
                              color: ColorPalettes.primaryWhite,
                            ),
                          ),
                        ],
                      );
                    }

                    if (provider.errorMessage.isNotEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            provider.errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                          ),
                        ),
                      );
                    }

                    final activeEvents = provider.earthWatchList;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "Active Events",
                                style: TextStyle(
                                  color: ColorPalettes.primaryWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "${activeEvents.length} Events",
                                style: const TextStyle(
                                  color: ColorPalettes.subTextGray,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 15),

                        if (activeEvents.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                "No active events found.",
                                style: TextStyle(color: ColorPalettes.subTextGray),
                              ),
                            ),
                          )
                        else
                          ListView.separated(
                            itemCount: activeEvents.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final event = activeEvents[index];
                              
                              final categoryTitle = event.categories.isNotEmpty ? event.categories[0]["title"]?.toString() ?? "Unknown" : "Unknown";

                              final rawDate = event.geometry.isNotEmpty ? event.geometry[0]["date"]?.toString() ?? "" : "";

                              final eventColor = getColorForCategory(categoryTitle);
                              
                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ColorPalettes.cardBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ColorPalettes.subTextGray.withValues(alpha: 0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: eventColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        getIconForCategory(categoryTitle),
                                        color: eventColor,
                                        size: 28,
                                      ),
                                    ),

                                    const SizedBox(width: 15),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: ColorPalettes.primaryWhite,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            categoryTitle,
                                            style: const TextStyle(
                                              color: ColorPalettes.subTextGray,
                                              fontSize: 12,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time_rounded,
                                                size: 14,
                                                color: ColorPalettes.subTextGray,
                                              ),

                                              const SizedBox(width: 4),
                                              
                                              Expanded(
                                                child: Text(
                                                  getFormattedDate(rawDate),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: ColorPalettes.subTextGray,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: eventColor.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        "LIVE",
                                        style: TextStyle(
                                          color: eventColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}