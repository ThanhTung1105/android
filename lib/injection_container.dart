// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:get_it/get_it.dart';
import 'package:safetrek_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:safetrek_app/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:safetrek_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:safetrek_app/features/auth/domain/repositories/auth_repository.dart';

import 'package:safetrek_app/features/auth/domain/usecases/forgot_password.dart';
import 'package:safetrek_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/login_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/logout_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/register_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/reset_password.dart';

// ... các import cũ ...
import 'package:safetrek_app/features/auth/presentation/auth_state.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_view_model.dart'; // THÊM DÒNG NÀY
import 'package:dio/dio.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/api_constants.dart'; // THÊM DÒNG NÀY

final sl = GetIt.instance; // 'sl' viết tắt của Service Locator


Future<void> init() async {
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(dio: sl()), // THÊM 'dio: sl()' VÀO ĐÂY
  );
  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  sl.registerFactory(() => AuthViewModel(
    loginUser: sl(),
    registerUser: sl(),
    forgotPasswordUseCase: sl(),
    resetPasswordUseCase: sl(),
    logoutUser: sl(),
    getCurrentUserUseCase: sl(),
  ));

  sl.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10), // 10 giây
      receiveTimeout: const Duration(seconds: 10), // 10 giây
      headers: {'Content-Type': 'application/json'},
    ),
  ));


  // Các service hoặc đối tượng khác sẽ được đăng ký ở đây sau này
}