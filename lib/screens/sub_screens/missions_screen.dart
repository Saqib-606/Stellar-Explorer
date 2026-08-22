import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/mission_provider.dart';
import 'package:stellar_explorer/screens/detail_screens/missions_detail_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State <MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State <MissionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MissionProvider>().fetchMissionsData();
    });
  }

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
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      appBar: AppBar(
        backgroundColor: ColorPalettes.mainBackground,
        elevation: 0,
        scrolledUnderElevation: 0,  
        iconTheme: const IconThemeData(color: ColorPalettes.primaryWhite),
        title: const Text(
          "Missions",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: ColorPalettes.primaryWhite,
        backgroundColor: ColorPalettes.cardBackground,
        onRefresh: () async {
          await context.read<MissionProvider>().refreshMissionsData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: ColorPalettes.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.2), width: 1)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
                          child: Image.asset(
                            "assets/images/mission.jpg",
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
        
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Space Missions",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalettes.primaryWhite,
                                  letterSpacing: 1.1
                                ),
                              ),
                          
                              const SizedBox(height: 8,),
                            
                              const Text(
                                "Explore ongoing and historic space missions from around the world.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorPalettes.subTextGray
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        
                const SizedBox(height: 20,),
          
                Consumer<MissionProvider>(
                  builder: (context, provider, child) {
                    if (provider.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: CircularProgressIndicator(
                            color: ColorPalettes.primaryWhite,
                            backgroundColor: ColorPalettes.cardBackground,
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
                      itemCount: provider.missionData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final missionData = provider.missionData[index];
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
                                  builder: (context) => MissionsDetailScreen(missionsDetail: missionData,),
                                ));
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      missionData.image,
                                      fit: BoxFit.cover,
                                      height: 130,
                                      width: 100,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        height: 130,
                                        width: 100,
                                        color: ColorPalettes.searchBarBg,
                                        child: const Icon(Icons.image_not_supported, color: ColorPalettes.subTextGray,),
                                      ),
                                    ),
                                  ),
        
                                  const SizedBox(width: 15),
        
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            missionData.launchServiceProvider.toUpperCase(),
                                            style: const TextStyle(
                                              color: ColorPalettes.electricBlue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
        
                                          const SizedBox(height: 5),
        
                                          Text(
                                            missionData.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2,
                                              color: ColorPalettes.primaryWhite,
                                            ),
                                          ),
        
                                          const SizedBox(height: 8),
        
                                          Row(
                                            children: [
                                              const Icon(Icons.calendar_month, color: ColorPalettes.subTextGray, size: 12,),
        
                                              const SizedBox(width: 5),
        
                                              Expanded(
                                                child: Text(
                                                  getFormattedDate(missionData.net,),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: ColorPalettes.subTextGray,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
        
                                          const SizedBox(height: 4),
        
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on, color: ColorPalettes.subTextGray, size: 12,),
        
                                              const SizedBox(width: 5),
        
                                              Expanded(
                                                child: Text(
                                                  missionData.pad,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: ColorPalettes.subTextGray,
                                                  ),
                                                ),
                                              ),
                                              
                                              const Padding(
                                                padding: EdgeInsets.only(right: 15.0,left: 5.0,),
                                                child: Icon(Icons.arrow_forward_ios_rounded, color: ColorPalettes.subTextGray, size: 14,),
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
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}