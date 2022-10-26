import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:practice_clean_architecture/core/network/network_info.dart';
import 'package:practice_clean_architecture/features/home_screen/data/datasources/user_devices_remote_datasource.dart';
import 'package:practice_clean_architecture/features/home_screen/data/repositories/user_devices_repository_implementation.dart';
import 'package:practice_clean_architecture/features/home_screen/domain/repositories/user_devices_repository.dart';
import 'package:practice_clean_architecture/features/home_screen/domain/usecases/get_all_user_devices.dart';
import 'package:practice_clean_architecture/features/home_screen/presentation/bloc/bloc.dart';
import 'package:practice_clean_architecture/features/user_login/data/datasources/user_login_local_data_source.dart';
import 'package:practice_clean_architecture/features/user_login/data/datasources/user_login_remote_data_source.dart';
import 'package:practice_clean_architecture/features/user_login/data/repositories/user_login_repository_implementation.dart';
import 'package:practice_clean_architecture/features/user_login/domain/repositories/user_login_repository.dart';
import 'package:practice_clean_architecture/features/user_login/domain/usecases/get_user_login.dart';
import 'package:practice_clean_architecture/features/user_login/presentation/bloc/bloc.dart';
import 'package:practice_clean_architecture/features/user_signup/data/datasources/user_account_verification_remote_datasource.dart';
import 'package:practice_clean_architecture/features/user_signup/data/datasources/user_signup_remote_datasource.dart';
import 'package:practice_clean_architecture/features/user_signup/data/repositories/get_user_registration_repository_implementation.dart';
import 'package:practice_clean_architecture/features/user_signup/domain/repositories/get_user_registration_repository.dart';
import 'package:practice_clean_architecture/features/user_signup/domain/usecases/get_user_account_verification.dart';
import 'package:practice_clean_architecture/features/user_signup/domain/usecases/get_user_sign_up.dart';
import 'package:practice_clean_architecture/features/user_signup/presentation/bloc/bloc.dart';
import 'package:practice_clean_architecture/userpreferances/local_user_data.dart';

final getItServiceLocator = GetIt.instance;

Future<void> init() async {
  // Core Dependencies
  getItServiceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<LocalUserData>(
    () => LocalUserDataImplementation(),
  );
  // External Dependencies
  getItServiceLocator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
  // User Login Dependencies
  getItServiceLocator.registerFactory(
    () => UserLoginBloc(
      getUserLogin: getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton(
    () => GetUserLogin(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<UserLoginRepository>(
    () => UserLoginRepositoryImplementation(
      userLoginRemoteDataSource: getItServiceLocator(),
      userLoginLocalDataSource: getItServiceLocator(),
      networkInfo: getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<UserLoginRemoteDataSource>(
    () => UserLoginRemoteDataSourceImplementation(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<UserLoginLocalDataSource>(
    () => UserLoginLocalDataSourceImplementation(
      localUserData: getItServiceLocator(),
    ),
  );
  //  User SignUp Dependencies
  getItServiceLocator.registerFactory(
    () => UserSignUpBloc(
      getUserSignUp: getItServiceLocator(),
      getUserAccountVerification: getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton(
    () => GetUserSignUp(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton(
    () => GetUserAccountVerification(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<GetUserRegistrationRepository>(
    () => GetUserRegistrationRepositoryImplementation(
      userSignUpRemoteDataSource: getItServiceLocator(),
      userAccountVerificationRemoteDataSource: getItServiceLocator(),
      networkInfo: getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<UserSignUpRemoteDataSource>(
    () => UserSignUpRemoteDataSourceImplementation(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator
      .registerLazySingleton<UserAccountVerificationRemoteDataSource>(
    () => UserAccountVerificationRemoteDataSourceImplementation(),
  );
  // User Devices Dependencies
  getItServiceLocator.registerFactory(
    () => UserDevicesBloc(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton(
    () => GetAllUserDevices(
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<UserDevicesRepository>(
    () => UserDevicesRepositoryImplementation(
      getItServiceLocator(),
      getItServiceLocator(),
    ),
  );
  getItServiceLocator.registerLazySingleton<UserDevicesRemoteDataSource>(
    () => UserDevicesRemoteDataSourceImplementation(),
  );
}
