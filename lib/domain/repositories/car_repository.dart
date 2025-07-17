import '../entities/car_entity.dart';

abstract class CarRepository {
  Future<List<CarEntity>> getCars();
  Future<CarEntity> updateCarFavoriteStatus(String carId, bool isFavorite);
} 