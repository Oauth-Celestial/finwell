import 'package:finwell/core/app_user/user_cubit/user_cubit_cubit.dart';
import 'package:finwell/core/database/database_helper.dart';
import 'package:finwell/core/notification/notification_service.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/shared_prefs/shared_pref_manager.dart';
import 'package:finwell/core/theme/app_theme.dart';
import 'package:finwell/core/theme/theme_model.dart';
import 'package:finwell/feature/auth/data/datasource/auth_data_source.dart';
import 'package:finwell/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:finwell/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:finwell/feature/auth/domain/usecase/google_login_use_case.dart';
import 'package:finwell/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:finwell/feature/dashboard/data/datasource/dashboard_data_source.dart';
import 'package:finwell/feature/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:finwell/feature/dashboard/domain/usecase/dashboard_details_use_case.dart';
import 'package:finwell/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:finwell/feature/onboarding/data/datasource/onboarding_datasource.dart';
import 'package:finwell/feature/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:finwell/feature/onboarding/domain/usecase/update_user_usecase.dart';
import 'package:finwell/feature/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:finwell/feature/pending_transactions/data/datasource/pending_transaction_data_source.dart';
import 'package:finwell/feature/pending_transactions/data/repository/pending_repo_impl.dart';
import 'package:finwell/feature/pending_transactions/domain/usecase/pending_transaction_usecase.dart';
import 'package:finwell/feature/pending_transactions/domain/usecase/remove_pending_transaction_usecase.dart';
import 'package:finwell/feature/pending_transactions/presentation/bloc/pending_transaction_bloc.dart';
import 'package:finwell/feature/splash_screen/presentation/splash_screen.dart';
import 'package:finwell/feature/transaction/data/datasource/transaction_data_source.dart';
import 'package:finwell/feature/transaction/data/repository/transaction_repo_impl.dart';
import 'package:finwell/feature/transaction/domain/usecase/create_transaction_usecase.dart';
import 'package:finwell/feature/transaction/domain/usecase/fetch_transaction_usecase.dart';
import 'package:finwell/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_manager_plus/theme_manager_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  await SharedPrefManager().initialize();
  DatabaseHelper().getDb();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          googleLoginUseCase: GoogleLoginUseCase(
            repository: AuthRepositoryImpl(
              authDataSource: AuthDataSourceImpl(),
            ),
          ),
          createUserUseCase: CreateUserUseCase(
            authRepository: AuthRepositoryImpl(
              authDataSource: AuthDataSourceImpl(),
            ),
          ),
        ),
      ),
      BlocProvider(
        create: (_) => OnboardingCubit(
          usecase: UpdateUserUsecase(
            onboardingRepository: OnboardingRepositoryImpl(
              datasource: OnboardingDatasourceImpl(),
            ),
          ),
        ),
      ),
      BlocProvider(create: (_) => UserCubit()),
      BlocProvider(
        create: (_) => TransactionBloc(
          createtransactionusecase: CreateTransactionUsecase(
            transactionRepository: TransactionRepoImpl(
              dataSource: TransactionDataSourceImpl(),
            ),
          ),
          fetchTransactionUsecase: FetchTransactionUsecase(
            transactionRepository: TransactionRepoImpl(
              dataSource: TransactionDataSourceImpl(),
            ),
          ),
        ),
      ),
      BlocProvider(
        create: (_) => PendingTransactionBloc(
            pendingTransactionUsecase: PendingTransactionUsecase(
              pendingTransactionRepository: PendingRepoImpl(
                  pendingTransactionDataSource:
                      PendingTransactionDataSourceImpl()),
            ),
            removePendingTransactionsUseCase: RemovePendingTransactionUsecase(
                pendingTransactionRepository: PendingRepoImpl(
                    pendingTransactionDataSource:
                        PendingTransactionDataSourceImpl()))),
      ),
      BlocProvider(
        create: (_) => DashboardBloc(
          dashboardDetailsUseCase: DashboardDetailsUseCase(
            repository: DashboardRepoImpl(
              dataSource: DashboardDataSourceImpl(),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, _) {
          return ThemeManagerPlus<FinThemeModel>(
            darkTheme: darkTheme,
            lightTheme: lightTheme,
            currentTheme: lightTheme,
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouteManager.shared.generateRoute,
              navigatorKey: NavigationService().navigationKey,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: Builder(builder: (context) {
                return const SplashScreen();
              }),
            ),
          );
        });
  }
}
