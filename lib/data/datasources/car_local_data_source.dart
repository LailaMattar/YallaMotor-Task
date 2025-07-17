import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/car_model.dart';

abstract class CarLocalDataSource {
  Future<List<CarModel>> getCars();
  Future<CarModel> updateCarFavoriteStatus(String carId, bool isFavorite);
}

class CarLocalDataSourceImpl implements CarLocalDataSource {
  List<CarModel> _cachedCars = [];

  @override
  Future<List<CarModel>> getCars() async {
    if (_cachedCars.isEmpty) {
      await _loadCarsFromAssets();
    }
    return List.from(_cachedCars);
  }

  @override
  Future<CarModel> updateCarFavoriteStatus(String carId, bool isFavorite) async {
    final carIndex = _cachedCars.indexWhere((car) => car.id == carId);
    if (carIndex != -1) {
      final updatedCar = CarModel.fromEntity(
        _cachedCars[carIndex].copyWith(isFavorite: isFavorite),
      );
      _cachedCars[carIndex] = updatedCar;
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
      
      // Try to parse as a single JSON object first
      try {
        final Map<String, dynamic> singleResponse = json.decode(jsonString);
        if (singleResponse.containsKey('data') && singleResponse['data']?.containsKey('used_cars') == true) {
          // Single response format
          final List<dynamic> usedCarsList = singleResponse['data']['used_cars'] ?? [];
          allCars.addAll(usedCarsList.map((json) => CarModel.fromJson(json)).toList());
          print('Parsed single response with ${usedCarsList.length} cars');
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
            if (response.containsKey('data') && response['data']?.containsKey('used_cars') == true) {
              final List<dynamic> usedCarsList = response['data']['used_cars'] ?? [];
              allCars.addAll(usedCarsList.map((json) => CarModel.fromJson(json)).toList());
              print('Response ${i + 1}: Added ${usedCarsList.length} cars');
            }
          } catch (parseError) {
            print('Failed to parse response ${i + 1}: $parseError');
            continue;
          }
        }
      }
      
      // Remove duplicates based on car ID
      final Map<String, CarModel> uniqueCars = {};
      for (var car in allCars) {
        uniqueCars[car.id] = car;
      }
      
      _cachedCars = uniqueCars.values.toList();
      print('=== FINAL RESULT ===');
      print('Total unique cars loaded: ${_cachedCars.length}');
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