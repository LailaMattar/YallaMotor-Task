class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  // ===== APP GENERAL =====
  static const String appTitle = 'Cars';
  static const String unknownCar = 'Unknown Car';
  static const String unknownSeller = 'Unknown Seller';
  static const String unknown = 'Unknown';
  static const String notAvailable = 'N/A';
  static const String defaultCurrency = 'AED';
  static const String defaultLocation = 'UAE';

  // ===== CAR LIST PAGE =====
  static const String cars = 'Cars';
  static const String usedCars = 'Used Cars';
  static const String featuredCars = 'Featured Cars';
  
  // Empty States
  static const String noUsedCarsAvailable = 'No used cars available';
  static const String noFeaturedCarsAvailable = 'No featured cars available';
  static const String welcomeToCarsApp = 'Welcome to Cars App';
  static const String welcomeToFeaturedCars = 'Welcome to Featured Cars';
  static const String pullDownToLoadCars = 'Pull down to load cars';
  static const String pullDownToLoadFeaturedCars = 'Pull down to load featured cars';
  
  // Error States  
  static const String failedToLoadCars = 'Failed to load cars';
  static const String pullDownToRefreshOrRetry = 'Pull down to refresh or tap retry';
  static const String retry = 'Retry';
  
  // Actions
  static const String pullDownToRefresh = 'Pull down to refresh';

  // ===== CAR DETAILS PAGE =====
  static const String carDetails = 'Car Details';
  static const String addedToFavorites = 'Added to favorites';
  static const String removedFromFavorites = 'Removed from favorites';
  static const String failedToUpdateFavoriteStatus = 'Failed to update favorite status';

  // ===== CAR SPECIFICATIONS =====
  static const String specifications = 'Specifications';
  static const String fuelType = 'Fuel Type';
  static const String bodyStyle = 'Body Style';
  static const String transmission = 'Transmission';
  static const String engineCC = 'Engine CC';
  static const String mileage = 'Mileage';
  static const String color = 'Color';
  static const String seats = 'Seats';
  static const String doors = 'Doors';

  // ===== CAR DESCRIPTION =====
  static const String description = 'Description';
  static const String noDescriptionAvailable = 'No description available for this vehicle.';

  // ===== SELLER SECTION =====
  static const String seller = 'Seller';

  // ===== CONTACT SECTION =====
  static const String contactViaWhatsApp = 'Contact via WhatsApp';
  static const String noContactAvailable = 'No Contact Available';
  static const String whatsAppNotInstalled = 'WhatsApp is not installed or failed to open';
  static const String noWhatsAppNumber = 'No WhatsApp number available for this car';

  // ===== DEFAULT VALUES =====
  static const String defaultFuelType = 'Petrol';
  static const String defaultTransmission = 'Automatic';

  // ===== WHATSAPP MESSAGE TEMPLATE =====
  static String whatsAppMessage({
    required String carTitle,
    required String carYear,
    required String currency,
    required String price,
  }) {
    return 'Hi! I am interested in your $carTitle ($carYear) listed for $currency $price. Is it still available?';
  }

  // ===== FORMATTING =====
  static String formatMileage(String mileage) => '$mileage km';
  static String formatEngineCC(String engineCC) => '${engineCC}cc';
  static String formatPrice(String currency, String price) => '$currency $price';
  
  // ===== IMAGE CAROUSEL =====
  static String imageCounter(int current, int total) => '${current + 1} / $total';

  // ===== DEBUG MESSAGES =====
  static const String loadedUsedCarsData = '=== LOADED USED CARS DATA ===';
  static const String loadedFeaturedCarsData = '=== LOADED FEATURED CARS DATA ===';
  static const String finalResult = '=== FINAL RESULT ===';
  static const String parsingJsonData = '=== PARSING JSON DATA ===';
  static String totalUsedCarsLoaded(int count) => 'Total used cars loaded: $count';
  static String totalFeaturedCarsLoaded(int count) => 'Total featured cars loaded: $count';
  static String carDebugInfo(int index, String title) => 'Car ${index + 1}: $title';
  static String featuredCarDebugInfo(int index, String title) => 'Featured Car ${index + 1}: $title';
  static String jsonFileSize(int size) => 'JSON file size: $size characters';
  static String parsedSingleResponse(int count) => 'Parsed single response with $count used cars';
  static String parsedSingleFeaturedResponse(int count) => 'Parsed single response with $count featured cars';
  
  // ===== ERROR MESSAGES =====
  static String carNotFound(String carId) => 'Car with id $carId not found';
  static String failedToLoadCarsFromAssets(String error) => 'Failed to load cars from assets: $error';
  static String errorLoadingCars(String error) => 'ERROR loading cars: $error';
  static String errorLoadingFeaturedCars(String error) => 'ERROR loading featured cars: $error';
  static String errorUpdatingFavoriteStatus(String error) => 'Error updating favorite status: $error';
} 