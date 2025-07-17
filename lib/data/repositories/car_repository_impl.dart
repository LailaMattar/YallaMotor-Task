import '../../domain/entities/car_entity.dart';
import '../../domain/repositories/car_repository.dart';
import '../datasources/car_local_data_source.dart';

class CarRepositoryImpl implements CarRepository {
  final CarLocalDataSource localDataSource;

  CarRepositoryImpl({required this.localDataSource});

  @override
  Future<List<CarEntity>> getCars() async {
    try {
      final cars = await localDataSource.getCars();
      return cars;
    } catch (e) {
      throw Exception('Failed to get cars: $e');
    }
  }

  @override
  Future<List<CarEntity>> getFeaturedCars() async {
    try {
      final featuredCars = await localDataSource.getFeaturedCars();
      return featuredCars;
    } catch (e) {
      throw Exception('Failed to get featured cars: $e');
    }
  }

  @override
  Future<CarEntity> updateCarFavoriteStatus(String carId, bool isFavorite) async {
    try {
      final updatedCar = await localDataSource.updateCarFavoriteStatus(carId, isFavorite);
      return updatedCar;
    } catch (e) {
      throw Exception('Failed to update car favorite status: $e');
    }
  }
} 