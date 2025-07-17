import 'package:flutter/foundation.dart';
import '../../domain/entities/car_entity.dart';
import '../../domain/usecases/get_cars_usecase.dart';
import '../../domain/usecases/update_car_favorite_usecase.dart';

enum LoadingState {
  idle,
  loading,
  doneWithData,
  doneWithNoData,
  hasError,
}

class CarProvider extends ChangeNotifier {
  final GetCarsUseCase getCarsUseCase;
  final UpdateCarFavoriteUseCase updateCarFavoriteUseCase;

  CarProvider({
    required this.getCarsUseCase,
    required this.updateCarFavoriteUseCase,
  });

  LoadingState _state = LoadingState.idle;
  List<CarEntity> _cars = [];
  String _errorMessage = '';

  // Getters
  LoadingState get state => _state;
  List<CarEntity> get cars => _cars;
  String get errorMessage => _errorMessage;

  Future<void> loadCars() async {
    _state = LoadingState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      
      // Add a small delay to make loading state visible during refresh
      await Future.delayed(const Duration(milliseconds: 500));
      
      _cars = await getCarsUseCase();
      
      // Determine the state based on the data
      if (_cars.isEmpty) {
        _state = LoadingState.doneWithNoData;
      } else {
        _state = LoadingState.doneWithData;
      }
      
      
      // Debug: Print the loaded cars data
      debugPrint('=== LOADED CARS DATA ===');
      debugPrint('Total cars loaded: ${_cars.length}');
      for (int i = 0; i < _cars.length && i < 3; i++) {
        final car = _cars[i];
        debugPrint('Car ${i + 1}:');
        debugPrint('  ID: ${car.id}');
        debugPrint('  Title: ${car.title}');
        debugPrint('  Price: ${car.price} ${car.currency}');
        debugPrint('  Year: ${car.year}');
        debugPrint('  Location: ${car.location}');
        debugPrint('  Fuel: ${car.fuel}');
        debugPrint('  Body: ${car.body}');
        debugPrint('  Color: ${car.color}');
        debugPrint('  Transmission: ${car.transmission}');
        debugPrint('  Image: ${car.image.isNotEmpty ? 'Has image' : 'No image'}');
        debugPrint('  Mileage: ${car.mileage}');
        debugPrint('---');
      }
      debugPrint('======================');
    } catch (e) {
      print('loadCars ERROR - Setting state to hasError');
      _state = LoadingState.hasError;
      _errorMessage = e.toString();
      debugPrint('ERROR loading cars: $e');
    }
    
    print('loadCars 10 - Calling final notifyListeners() with state: $_state');
    notifyListeners();
    print('=== LOAD CARS END ===');
  }

  Future<void> toggleCarFavorite(String carId) async {
    try {
      final carIndex = _cars.indexWhere((car) => car.id == carId);
      if (carIndex != -1) {
        final currentCar = _cars[carIndex];
        final updatedCar = await updateCarFavoriteUseCase(
          carId: carId,
          isFavorite: !currentCar.isFavorite,
        );
        _cars[carIndex] = updatedCar;
        notifyListeners();
      }
    } catch (e) {
      // Handle error - you might want to show a snackbar or toast
      debugPrint('Error updating favorite status: $e');
    }
  }

  void refreshCars() {
    loadCars();
  }
} 