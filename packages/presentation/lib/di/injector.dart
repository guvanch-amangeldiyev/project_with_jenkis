import 'package:domain/usecase/get_views_usecase.dart';
import 'package:domain/usecase/get_primary_view_usecase.dart';
import 'package:domain/usecase/home_usecase.dart';
import 'package:domain/usecase/token_usecase.dart';
import 'package:domain/usecase/login_usecase.dart';
import 'package:domain/usecase/login_validation_usecase.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/internal/analytics_event.dart';
import 'package:presentation/internal/analytics_service.dart';
import 'package:presentation/mapper/asset_mapper.dart';
import 'package:presentation/mapper/color_mapper.dart';
import 'package:presentation/mapper/error_mapper.dart';
import 'package:presentation/mapper/login_view_mapper.dart';
import 'package:presentation/mapper/main_view_mapper.dart';
import 'package:presentation/navigator/app_navigator.dart';
import 'package:presentation/screen/app/bloc/app_bloc.dart';
import 'package:presentation/screen/home/bloc/home_bloc.dart';
import 'package:presentation/screen/login/bloc/login_bloc.dart';
import 'package:presentation/screen/main/bloc/main_bloc.dart';
import 'package:presentation/screen/splash/bloc/splash_bloc.dart';

Future<void> injectPresentationModule() async {
  final sl = GetIt.I;

  sl.registerSingleton<AppNavigator>(
    AppNavigatorImpl(),
  );

  sl.registerSingleton<LoginViewMapper>(
    LoginViewMapper(),
  );

  sl.registerSingleton<ErrorMapper>(
    ErrorMapper(),
  );

  sl.registerSingleton<ColorMapper>(
    ColorMapper(),
  );

  sl.registerSingleton<AssetMapper>(
    AssetMapper(),
  );

  sl.registerSingleton<MainViewMapper>(
    MainViewMapper(),
  );

  sl.registerSingleton<FirebaseAnalytics>(
    FirebaseAnalytics.instance,
  );

  sl.registerSingleton<AnalyticsEvent>(
    AnalyticsEvent(),
  );

  sl.registerSingleton(
    AnalyticsService(
      sl.get<FirebaseAnalytics>(),
    ),
  );

  sl.registerFactory(
    () => LoginBloc(
      sl.get<LoginUseCase>(),
      sl.get<LoginValidationUseCase>(),
      sl.get<LoginViewMapper>(),
    ),
  );

  sl.registerFactory(
    () => HomeBloc(
      sl.get<HomeUseCase>(),
    ),
  );

  sl.registerFactory<SplashBloc>(
    () => SplashBloc(
      sl.get<AnalyticsService>(),
      sl.get<TokenUseCase>(),
    ),
  );

  sl.registerFactory<MainBloc>(
    () => MainBloc(
      sl.get<AnalyticsEvent>(),
      sl.get<AnalyticsService>(),
      sl.get<GetViewsUseCase>(),
      sl.get<GetPrimaryViewUseCase>(),
    ),
  );

  sl.registerFactory<AppBloc>(
    () => AppBloc(),
  );
}