# Villa Manager Mobile App

A Flutter mobile application for managing villas and properties with integrated API support.

## Features

- **User Authentication**: Login functionality with credential persistence
- **Claimed Villas**: View list of claimed villas with location-based filtering
- **Business Unit Properties**: Browse properties by business unit
- **Property Details**: Detailed view of individual properties
- **Location Services**: Automatic location detection for villa fetching

## Project Structure

```
lib/
├── main.dart                          # App entry point with splash screen
├── models/                            # Data models
│   ├── login_response.dart
│   ├── villa.dart
│   ├── property.dart
│   └── property_detail.dart
├── providers/                         # State management (Provider)
│   ├── auth_provider.dart             # Authentication state
│   ├── villa_provider.dart            # Claimed villas state
│   ├── property_provider.dart         # Business unit properties state
│   └── property_detail_provider.dart   # Property details state
├── services/                          # Business logic and API calls
│   ├── api_service.dart               # API integration for all endpoints
│   ├── auth_service.dart              # Authentication persistence
│   └── location_service.dart          # Location handling
├── screens/                           # UI screens
│   ├── login_screen.dart
│   ├── claimed_villas_screen.dart
│   ├── business_unit_properties_screen.dart
│   └── property_detail_screen.dart
└── widgets/                           # Reusable widgets
    └── gaps.dart                      # HorizontalGap and VerticalGap widgets
```

## API Endpoints

### 1. Login
- **Endpoint**: `POST https://dev-villamanager.skills201.com/VM/mobile-api/login.json`
- **Parameters**: `username`, `password`

### 2. Get Claimed Villas
- **Endpoint**: `POST https://dev-villamanager.skills201.com/VM/mobile-api/getClaimedVilla.json`
- **Parameters**: `latitude`, `longitude`

### 3. Get Business Unit Properties
- **Endpoint**: `POST https://dev-villamanager.skills201.com/VM/mobile-api/getBuPropertyNew.json`
- **Parameters**: `latitude`, `longitude`, `business_unit_id`

### 4. Get Property Details
- **Endpoint**: `POST https://dev-villamanager.skills201.com/VM/mobile-api/getPropertyDetail.json`
- **Parameters**: `villa_id`

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- `http`: ^1.2.0 - For making API calls
- `shared_preferences`: ^2.2.2 - For storing authentication state
- `geolocator`: ^10.1.0 - For location services
- `provider`: ^6.1.1 - For state management

## App Flow

1. **Splash Screen**: Checks if user is logged in
2. **Login Screen**: User enters credentials (pre-filled with test credentials)
3. **Claimed Villas Screen**: Shows list of villas based on location
4. **Business Unit Properties Screen**: Shows properties for selected business unit
5. **Property Details Screen**: Shows detailed information about a property

## Default Credentials

- Username: `abhi`
- Password: `babysoft@123`

## Default Location

If location permission is denied, the app uses default coordinates:
- Latitude: 26.8373949
- Longitude: 80.933275

## Clean Architecture

The project follows a clean architecture pattern with clear separation of concerns:
- **Models**: Data structures
- **Providers**: State management using Provider pattern
- **Services**: Business logic and API integration
- **Screens**: UI presentation
- **Widgets**: Reusable UI components

## State Management

The app uses **Provider** for state management with the following providers:
- **AuthProvider**: Manages login/logout state and authentication
- **VillaProvider**: Manages claimed villas list
- **PropertyProvider**: Manages business unit properties list
- **PropertyDetailProvider**: Manages individual property details

All providers are registered at the app level using `MultiProvider` for global access throughout the app.
