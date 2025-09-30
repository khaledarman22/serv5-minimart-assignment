import 'package:get_it/get_it.dart';
import 'package:minimart/core/themes/cubit/theme_cubit.dart';
import 'package:minimart/features/cart/cubit/cart_cubit.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => CartCubit());
  sl.registerLazySingleton(() => ThemeCubit());
}
