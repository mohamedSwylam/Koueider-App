import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/networking/api_provider.dart';
import 'package:task/features/data/repositories/product_repositoy.dart';
import 'package:task/features/presentation/cubit/product_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => ApiProvider(sl()));
  
  // External
  sl.registerLazySingleton(() {
    final dio = Dio();
    return dio;
  });

  // Repositories
  sl.registerLazySingleton(() => ProductRepository(sl()));

  // Cubits
  sl.registerFactory(() => ProductsCubit(sl()));
}