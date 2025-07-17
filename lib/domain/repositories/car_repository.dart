import '../entities/car_entity.dart';

abstract class CarRepository {
  Future<List<CarEntity>> getCars();
  Future<List<CarEntity>> getFeaturedCars();
  Future<CarEntity> updateCarFavoriteStatus(String carId, bool isFavorite);
} 