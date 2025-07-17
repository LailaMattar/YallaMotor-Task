import '../entities/car_entity.dart';
import '../repositories/car_repository.dart';

class GetFeaturedCarsUseCase {
  final CarRepository repository;

  GetFeaturedCarsUseCase({required this.repository});

  Future<List<CarEntity>> call() async {
    return await repository.getFeaturedCars();
  }
} 