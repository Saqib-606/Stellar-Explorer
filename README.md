# 🚀 Stellar Explorer

A modern, premium **Space Exploration Companion** application built with **Flutter**, powered by **NASA Open APIs**, **The Solar System OpenData API**, and **Provider State Management**[cite: 1, 2, 14].

The application transforms your device into an interactive space command center, enabling users to explore real-time astronomical data, track the International Space Station, monitor near-Earth asteroids, read the latest space news, and discover thousands of cosmic images[cite: 2].

---

## ✨ Features

### 📸 Astronomy Picture of the Day (APOD)
- Daily High-Definition Space Images[cite: 12]
- Detailed Image Descriptions[cite: 12]
- Full-Screen Viewing[cite: 12]

### 🛰️ ISS Live Tracker (Hero Feature)
- Real-time ISS Position Tracking[cite: 12]
- Live Latitude, Longitude, and Altitude Metrics[cite: 12, 23]
- Current Velocity and Next Pass Information[cite: 12, 23]

### ☄️ Near-Earth Asteroids (NeoWs)
- Track Approaching Asteroids[cite: 12]
- Hazard Status Indicators[cite: 12]
- Distance, Speed, and Estimated Size Metrics[cite: 12]

### 🌍 Earth Watch (EONET)
- Live Global Natural Events Monitoring[cite: 7]
- Track Severe Storms, Wildfires, and Volcanoes[cite: 7]
- Real-time NASA Earth Observatory Data[cite: 7]

### 🌌 NASA Image Gallery & Space News
- Searchable Grid of Thousands of NASA Images[cite: 2, 13]
- Latest Articles via Spaceflight News API[cite: 9]
- Historic and Active Space Missions Tracker[cite: 24]

### 🪐 Planetary Data & Exoplanets
- Deep Physical Data of Solar System Planets and Moons[cite: 14]
- Explore Newly Discovered Exoplanets[cite: 6]

### 🎨 User Interface & Architecture
- Premium Dark Space Theme with Glassmorphism Cards[cite: 2]
- Smooth Navigation & Pull-to-Refresh Functionality[cite: 24]
- Clean Architecture (Presentation $\rightarrow$ Provider $\rightarrow$ Repository $\rightarrow$ API Services)[cite: 2]

---

## 🛠️ Tech Stack

- Flutter[cite: 1, 2]
- Dart
- Provider (State Management)[cite: 1, 2]
- Dio (Robust REST API Networking)[cite: 1, 5]
- NASA Open APIs (APOD, NeoWs, DONKI, EONET)[cite: 15]
- The Solar System OpenData API[cite: 14]

---

## 📂 Project Structure

```text
lib/
│
├── models/
├── provider/
├── screens/
│   ├── dashboard_screens/
│   ├── detail_screens/
│   └── sub_screens/
├── services/
├── utils/
├── widgets/
└── main.dart


## 🚀 Implemented Features

- ✅ Splash & Onboarding Screens

- ✅ Home Dashboard with Quick Access Grid

- ✅ APOD Integration

- ✅ Live ISS Tracking Module

- ✅ Asteroid & Exoplanet Explorer

- ✅ Planets & Moons Detailed Data

- ✅ Earth Watch (EONET) Integration

- ✅ Space Weather (DONKI) Reports

- ✅ Searchable NASA Image Gallery

- ✅ Upcoming Launches & Historic Missions

- ✅ Space News Feed

- ✅ Favorites System

- ✅ Provider State Management

- ✅ Custom Dark Theme UI


---

## 📱 Application Screens

<p align="center">
  <img src="assets/screenshots/Home_Screen.png" alt="Home Screen" width="190"/>
  <img src="assets/screenshots/Explore_Screen.png" alt="Explore Screen" width="190"/>
  <img src="assets/screenshots/News_Screen.png" alt="News Screen" width="190"/>
  <img src="assets/screenshots/ISS_Tracker_Screen.png" alt="ISS Tracker Screen" width="190"/>
</p>

---

## 🔑 API Configuration
This project relies on multiple public APIs. You need to configure your own API keys for the app to function correctly.

Create the following file:
lib/services/api_constants.dart

Add your keys in the following format:
class ApiConstants {
  static const String baseUrl = "[https://api.nasa.gov](https://api.nasa.gov)";
  static const String apiKey = "YOUR_NASA_API_KEY_HERE";
  
  static const String baseUrlForPlanetsData = "[https://api.le-systeme-solaire.net/rest/](https://api.le-systeme-solaire.net/rest/)";
  static const String apiKeyForPlanetsData = "YOUR_UUID_KEY_HERE";
}

Get your free API keys:
NASA API Key: api.nasa.gov

Solar System OpenData API Token: api.le-systeme-solaire.net/generatekey.html

(Note: The ISS Tracker, Earth Watch, NASA Image Library, and Launch Library 2 (Dev) APIs do not require API keys and will work out of the box).

---

## 👨‍💻 Author

**Saqib**

Flutter Developer

---

## 📄 License

This project is created for learning, educational, and portfolio purposes.