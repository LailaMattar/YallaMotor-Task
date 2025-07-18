# YallaMotor-Task

A responsive Flutter car listing application that displays used cars with detailed information, built following clean architecture principles.

## 📱 Features Implemented

### ✅ Core Requirements
- **Car List Display**: Grid layout for tablets/desktop, list layout for mobile devices
- **Tabbed Interface**: Two tabs for 'Used Cars' and 'Featured Cars' with separate data sources
- **Reusable CarCard Component**: Displays car image, title, price, year, location, and basic info
- **Car Details Screen**: Full car information with image carousel, specifications, and contact options
- **Responsive Design**: Optimized for both iOS and Android with different layouts based on screen size
- **Local JSON Data**: Uses comprehensive car dataset loaded from local assets

### ✅ Bonus Features
- **Pull-to-refresh**: Implemented on car list page (pull down the screen to refresh data)
- **Favorite Toggle**: In-memory favorite functionality with heart icon
- **Provider State Management**: Using Provider for state management
- **HTML Description Parsing**: Rich text descriptions using `flutter_widget_from_html`

### ✅ WhatsApp Integration
- **WhatsApp Contact**: Fully implemented with URL launcher - opens WhatsApp with pre-filled message

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                     # Dependency injection
├── data/                     # Data layer
│   ├── datasources/         # Local data source implementation
│   ├── models/              # Data models
│   └── repositories/        # Repository implementations
├── domain/                   # Business logic layer
│   ├── entities/            # Business entities
│   ├── repositories/        # Repository contracts
│   └── usecases/           # Business use cases
└── presentation/            # UI layer
    ├── pages/              # Screen widgets
    ├── providers/          # State management
    └── widgets/            # Reusable UI components
```

## 🛠️ Tech Stack

- **Flutter SDK**: ^3.4.3
- **State Management**: Provider ^6.1.2
- **Dependency Injection**: GetIt ^7.6.4
- **Responsive Design**: Flutter ScreenUtil ^5.9.0
- **Image Caching**: Cached Network Image ^3.4.0
- **HTML Rendering**: Flutter Widget from HTML ^0.15.1
- **URL Launcher**: URL Launcher ^6.2.2 for WhatsApp integration
- **Architecture**: Clean Architecture with Repository Pattern

## 📥 Download APK

You can download the ready-to-install APK file from:
**[Download APK](https://drive.google.com/drive/u/1/folders/1t216LAnulOlpBhYFQbv9z2b9taw57iW6)**

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.4.3 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd YallaMotor-Task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate app icons** (optional)
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📊 Data Structure

The app loads car data from `assets/data/data-2.json` with the following structure:

```json
{
  "id": "1",
  "title": "Used Porsche Panamera 2022",
  "price": "305750",
  "currency": "AED",
  "year": "2022",
  "location": "Dubai",
  "fuel": "Petrol",
  "body": "Liftback",
  "image": "https://images.unsplash.com/...",
  "isFavorite": true,
  "mileage": "15000",
  "color": "Black",
  "transmission": "Automatic",
  "pictures": ["url1", "url2"],
  "description": "HTML description content",
  "whatsapp_number": "+971501234567",
  "seller_name": "Auto Central",
  "doors": "4",
  "seats": 5,
  "engine_cc": 2900
}
```

## 🎨 UI/UX Features

### Responsive Design
- **Mobile**: List layout with cards optimized for single-column display
- **Tablet/Desktop**: Grid layout with 2 columns for better space utilization
- **Adaptive UI**: Uses ScreenUtil for consistent sizing across devices

### Car List Page
- **Tabbed Navigation**: Switch between 'Used Cars' and 'Featured Cars'
- **Pull-to-refresh functionality** (pull down the screen to refresh data)
- **Loading states** with proper error handling
- **Empty state** with user guidance
- **Smooth navigation** to details

### Car Details Page
- Image carousel for multiple car photos
- Comprehensive car specifications (transmission, engine CC, seats, doors, etc.)
- Favorite toggle with visual feedback
- Dynamic seller information from JSON data
- WhatsApp contact button with automatic phone number formatting
- HTML description rendering

### Visual Elements
- Custom app icon and Cairo font family
- Consistent color scheme with primary blue (#2986F6)
- Material Design 3 components
- Smooth animations and transitions

## 🧪 Testing

Run tests using:
```bash
flutter test
```

## 📝 Project Status

### ✅ Completed
- [x] Display list of cars with reusable CarCard component
- [x] Tabbed interface for Used Cars and Featured Cars
- [x] Car details screen with full information
- [x] Responsive design for mobile and tablet
- [x] Pull-to-refresh functionality
- [x] Favorite toggle (in-memory)
- [x] Provider state management
- [x] Clean architecture implementation
- [x] HTML description parsing
- [x] Image carousel
- [x] Local JSON data loading
- [x] WhatsApp contact integration with URL launcher
- [x] Dynamic car specifications (doors, seats, engine CC)

### 🔄 Future Enhancements
- [ ] Search and filter functionality
- [ ] Persistent favorites using local storage
- [ ] Car comparison feature
- [ ] Sort options (price, year, mileage)

## 📱 Screenshots

The app includes:
- **Home Screen**: Responsive car list with pull-to-refresh
- **Car Details**: Full car information with image carousel
- **Responsive Layout**: Different layouts for mobile and tablet
- **Favorite Feature**: Toggle favorites with visual feedback

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is part of a coding challenge and is for educational purposes.

---

**Built with ❤️ using Flutter**