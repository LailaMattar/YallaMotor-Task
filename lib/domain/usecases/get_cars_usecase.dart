import '../entities/car_entity.dart';
import '../repositories/car_repository.dart';

class GetCarsUseCase {
  final CarRepository repository;

  GetCarsUseCase({required this.repository});

  Future<List<CarEntity>> call() async {
    return await repository.getCars();
  }
} 