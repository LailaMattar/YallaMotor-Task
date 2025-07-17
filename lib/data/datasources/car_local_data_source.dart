import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/car_model.dart';

abstract class CarLocalDataSource {
  Future<List<CarModel>> getCars();
  Future<List<CarModel>> getFeaturedCars();
  Future<CarModel> updateCarFavoriteStatus(String carId, bool isFavorite);
}

class CarLocalDataSourceImpl implements CarLocalDataSource {
  List<CarModel> _cachedCars = [];
  List<CarModel> _cachedFeaturedCars = [];

  @override
  Future<List<CarModel>> getCars() async {
    if (_cachedCars.isEmpty) {
      await _loadCarsFromAssets();
    }
    return List.from(_cachedCars);
  }

  @override
  Future<List<CarModel>> getFeaturedCars() async {
    if (_cachedFeaturedCars.isEmpty) {
      await _loadCarsFromAssets();
    }
    return List.from(_cachedFeaturedCars);
  }

  @override
  Future<CarModel> updateCarFavoriteStatus(String carId, bool isFavorite) async {
    // Check in regular cars first
    final carIndex = _cachedCars.indexWhere((car) => car.id == carId);
    if (carIndex != -1) {
      final updatedCar = CarModel.fromEntity(
        _cachedCars[carIndex].copyWith(isFavorite: isFavorite),
      );
      _cachedCars[carIndex] = updatedCar;
      
      // Also update in featured cars if it exists there
      final featuredCarIndex = _cachedFeaturedCars.indexWhere((car) => car.id == carId);
      if (featuredCarIndex != -1) {
        _cachedFeaturedCars[featuredCarIndex] = updatedCar;
      }
      
      return updatedCar;
    }
    
    // Check in featured cars
    final featuredCarIndex = _cachedFeaturedCars.indexWhere((car) => car.id == carId);
    if (featuredCarIndex != -1) {
      final updatedCar = CarModel.fromEntity(
        _cachedFeaturedCars[featuredCarIndex].copyWith(isFavorite: isFavorite),
      );
      _cachedFeaturedCars[featuredCarIndex] = updatedCar;
      return updatedCar;
    }
    
    throw Exception('Car with id $carId not found');
  }

  Future<void> _loadCarsFromAssets() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/data-2.json');
      
      print('=== PARSING JSON DATA ===');
      print('JSON file size: ${jsonString.length} characters');
      
      // Handle both single response and multiple concatenated responses
      List<CarModel> allCars = [];
      List<CarModel> allFeaturedCars = [];
      
      // Try to parse as a single JSON object first
      try {
        final Map<String, dynamic> singleResponse = json.decode(jsonString);
        if (singleResponse.containsKey('data')) {
          final data = singleResponse['data'];
          
          // Parse used_cars
          if (data?.containsKey('used_cars') == true) {
            final List<dynamic> usedCarsList = data['used_cars'] ?? [];
            allCars.addAll(usedCarsList.map((json) => CarModel.fromJson(json)).toList());
            print('Parsed single response with ${usedCarsList.length} used cars');
          }
          
          // Parse featured_used_cars
          if (data?.containsKey('featured_used_cars') == true) {
            final List<dynamic> featuredCarsList = data['featured_used_cars'] ?? [];
            allFeaturedCars.addAll(featuredCarsList.map((json) => CarModel.fromJson(json)).toList());
            print('Parsed single response with ${featuredCarsList.length} featured cars');
          }
        }
      } catch (e) {
        print('Not a single JSON object, trying to parse multiple responses...');
        
        // If single parsing fails, try to split and parse multiple responses
        // Split the JSON string by looking for response boundaries
        final List<String> responseStrings = _splitMultipleJsonResponses(jsonString);
        print('Found ${responseStrings.length} potential response objects');
        
        for (int i = 0; i < responseStrings.length; i++) {
          try {
            final Map<String, dynamic> response = json.decode(responseStrings[i]);
            if (response.containsKey('data')) {
              final data = response['data'];
              
              // Parse used_cars
              if (data?.containsKey('used_cars') == true) {
                final List<dynamic> usedCarsList = data['used_cars'] ?? [];
                allCars.addAll(usedCarsList.map((json) => CarModel.fromJson(json)).toList());
                print('Response ${i + 1}: Added ${usedCarsList.length} used cars');
              }
              
              // Parse featured_used_cars
              if (data?.containsKey('featured_used_cars') == true) {
                final List<dynamic> featuredCarsList = data['featured_used_cars'] ?? [];
                allFeaturedCars.addAll(featuredCarsList.map((json) => CarModel.fromJson(json)).toList());
                print('Response ${i + 1}: Added ${featuredCarsList.length} featured cars');
              }
            }
          } catch (parseError) {
            print('Failed to parse response ${i + 1}: $parseError');
            continue;
          }
        }
      }
      
      // Remove duplicates based on car ID for regular cars
      final Map<String, CarModel> uniqueCars = {};
      for (var car in allCars) {
        uniqueCars[car.id] = car;
      }
      
      // Remove duplicates based on car ID for featured cars
      final Map<String, CarModel> uniqueFeaturedCars = {};
      for (var car in allFeaturedCars) {
        uniqueFeaturedCars[car.id] = car;
      }
      
      _cachedCars = uniqueCars.values.toList();
      _cachedFeaturedCars = uniqueFeaturedCars.values.toList();
      
      print('=== FINAL RESULT ===');
      print('Total unique used cars loaded: ${_cachedCars.length}');
      print('Total unique featured cars loaded: ${_cachedFeaturedCars.length}');
      print('===================');
      
    } catch (e) {
      throw Exception('Failed to load cars from assets: $e');
    }
  }

  List<String> _splitMultipleJsonResponses(String jsonString) {
    // This method attempts to split multiple JSON objects that might be concatenated
    List<String> responses = [];
    
    // Look for patterns that indicate the start of a new response
    // YallaMotor responses typically start with {"status":200,"message":null...
    final regex = RegExp(r'(?=\{"status"\s*:\s*200)');
    final parts = jsonString.split(regex);
    
    for (String part in parts) {
      final trimmed = part.trim();
      if (trimmed.isNotEmpty && trimmed.startsWith('{')) {
        // Ensure the JSON object is properly closed
        if (trimmed.endsWith('}')) {
          responses.add(trimmed);
        } else {
          // Try to find the proper closing brace
          int braceCount = 0;
          int endIndex = -1;
          for (int i = 0; i < trimmed.length; i++) {
            if (trimmed[i] == '{') braceCount++;
            if (trimmed[i] == '}') braceCount--;
            if (braceCount == 0) {
              endIndex = i;
              break;
            }
          }
          if (endIndex != -1) {
            responses.add(trimmed.substring(0, endIndex + 1));
          }
        }
      }
    }
    
    return responses;
  }
} 