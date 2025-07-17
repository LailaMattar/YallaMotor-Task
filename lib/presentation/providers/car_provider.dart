import 'package:flutter/foundation.dart';
import '../../domain/entities/car_entity.dart';
import '../../domain/usecases/get_cars_usecase.dart';
import '../../domain/usecases/get_featured_cars_usecase.dart';
import '../../domain/usecases/update_car_favorite_usecase.dart';

enum LoadingState {
  idle,
  loading,
  doneWithData,
  doneWithNoData,
  hasError,
}

enum CarTabType {
  usedCars,
  featuredCars,
}

class CarProvider extends ChangeNotifier {
  final GetCarsUseCase getCarsUseCase;
  final GetFeaturedCarsUseCase getFeaturedCarsUseCase;
  final UpdateCarFavoriteUseCase updateCarFavoriteUseCase;

  CarProvider({
    required this.getCarsUseCase,
    required this.getFeaturedCarsUseCase,
    required this.updateCarFavoriteUseCase,
  });

  LoadingState _state = LoadingState.idle;
  CarTabType _currentTab = CarTabType.usedCars;
  List<CarEntity> _cars = [];
  List<CarEntity> _featuredCars = [];
  String _errorMessage = '';

  // Getters
  LoadingState get state => _state;
  CarTabType get currentTab => _currentTab;
  List<CarEntity> get cars => _currentTab == CarTabType.usedCars ? _cars : _featuredCars;
  List<CarEntity> get usedCars => _cars;
  List<CarEntity> get featuredCars => _featuredCars;
  String get errorMessage => _errorMessage;

  void changeTab(CarTabType tabType) {
    if (_currentTab != tabType) {
      _currentTab = tabType;
      notifyListeners();
      
      // Load data for the new tab if not already loaded
      if (tabType == CarTabType.usedCars && _cars.isEmpty) {
        loadCars();
      } else if (tabType == CarTabType.featuredCars && _featuredCars.isEmpty) {
        loadFeaturedCars();
      }
    }
  }

  Future<void> loadCars() async {
    _state = LoadingState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // Add a small delay to make loading state visible during refresh
      await Future.delayed(const Duration(milliseconds: 500));
      
      _cars = await getCarsUseCase();
      
      // Determine the state based on the data for current tab
      if (_currentTab == CarTabType.usedCars) {
        if (_cars.isEmpty) {
          _state = LoadingState.doneWithNoData;
        } else {
          _state = LoadingState.doneWithData;
        }
      }
      
      // Debug: Print the loaded cars data
      debugPrint('=== LOADED USED CARS DATA ===');
      debugPrint('Total used cars loaded: ${_cars.length}');
      for (int i = 0; i < _cars.length && i < 3; i++) {
        final car = _cars[i];
        debugPrint('Car ${i + 1}: ${car.title}');
      }
      debugPrint('============================');
    } catch (e) {
      print('loadCars ERROR - Setting state to hasError');
      _state = LoadingState.hasError;
      _errorMessage = e.toString();
      debugPrint('ERROR loading cars: $e');
    }
    
    notifyListeners();
  }

  Future<void> loadFeaturedCars() async {
    _state = LoadingState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // Add a small delay to make loading state visible during refresh
      await Future.delayed(const Duration(milliseconds: 500));
      
      _featuredCars = await getFeaturedCarsUseCase();
      
      // Determine the state based on the data for current tab
      if (_currentTab == CarTabType.featuredCars) {
        if (_featuredCars.isEmpty) {
          _state = LoadingState.doneWithNoData;
        } else {
          _state = LoadingState.doneWithData;
        }
      }
      
      // Debug: Print the loaded featured cars data
      debugPrint('=== LOADED FEATURED CARS DATA ===');
      debugPrint('Total featured cars loaded: ${_featuredCars.length}');
      for (int i = 0; i < _featuredCars.length && i < 3; i++) {
        final car = _featuredCars[i];
        debugPrint('Featured Car ${i + 1}: ${car.title}');
      }
      debugPrint('=================================');
    } catch (e) {
      print('loadFeaturedCars ERROR - Setting state to hasError');
      _state = LoadingState.hasError;
      _errorMessage = e.toString();
      debugPrint('ERROR loading featured cars: $e');
    }
    
    notifyListeners();
  }

  Future<void> loadCurrentTabData() async {
    if (_currentTab == CarTabType.usedCars) {
      await loadCars();
    } else {
      await loadFeaturedCars();
    }
  }

  Future<void> toggleCarFavorite(String carId) async {
    try {
      // Check in current tab's cars first
      final currentCars = _currentTab == CarTabType.usedCars ? _cars : _featuredCars;
      final carIndex = currentCars.indexWhere((car) => car.id == carId);
      
      if (carIndex != -1) {
        final currentCar = currentCars[carIndex];
        final updatedCar = await updateCarFavoriteUseCase(
          carId: carId,
          isFavorite: !currentCar.isFavorite,
        );
        
        // Update in the appropriate list
        if (_currentTab == CarTabType.usedCars) {
          _cars[carIndex] = updatedCar;
        } else {
          _featuredCars[carIndex] = updatedCar;
        }
        
        // Also update in the other list if the car exists there
        if (_currentTab == CarTabType.usedCars) {
          final featuredIndex = _featuredCars.indexWhere((car) => car.id == carId);
          if (featuredIndex != -1) {
            _featuredCars[featuredIndex] = updatedCar;
          }
        } else {
          final usedIndex = _cars.indexWhere((car) => car.id == carId);
          if (usedIndex != -1) {
            _cars[usedIndex] = updatedCar;
          }
        }
        
        notifyListeners();
      }
    } catch (e) {
      // Handle error - you might want to show a snackbar or toast
      debugPrint('Error updating favorite status: $e');
    }
  }

  void refreshCars() {
    loadCurrentTabData();
  }
} 