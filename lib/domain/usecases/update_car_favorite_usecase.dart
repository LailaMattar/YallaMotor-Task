import '../entities/car_entity.dart';
import '../repositories/car_repository.dart';

class UpdateCarFavoriteUseCase {
  final CarRepository repository;

  UpdateCarFavoriteUseCase({required this.repository});

  Future<CarEntity> call({required String carId, required bool isFavorite}) async {
    return await repository.updateCarFavoriteStatus(carId, isFavorite);
  }
} 