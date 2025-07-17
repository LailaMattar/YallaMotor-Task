import 'package:get_it/get_it.dart';

// Data layer
import '../data/datasources/car_local_data_source.dart';
import '../data/repositories/car_repository_impl.dart';

// Domain layer
import '../domain/repositories/car_repository.dart';
import '../domain/usecases/get_cars_usecase.dart';
import '../domain/usecases/get_featured_cars_usecase.dart';
import '../domain/usecases/update_car_favorite_usecase.dart';

// Presentation layer
import '../presentation/providers/car_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Provider
  sl.registerFactory(() => CarProvider(
        getCarsUseCase: sl(),
        getFeaturedCarsUseCase: sl(),
        updateCarFavoriteUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetCarsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetFeaturedCarsUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateCarFavoriteUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CarLocalDataSource>(
    () => CarLocalDataSourceImpl(),
  );
} 