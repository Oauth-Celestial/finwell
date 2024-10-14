import 'package:finwell/core/theme/app_theme.dart';
import 'package:finwell/core/theme/theme_model.dart';
import 'package:finwell/feature/auth/data/datasource/auth_data_source.dart';
import 'package:finwell/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:finwell/feature/auth/domain/usecase/create_user_use_case.dart';
import 'package:finwell/feature/auth/domain/usecase/google_login_use_case.dart';
import 'package:finwell/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:finwell/feature/auth/presentation/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_manager_plus/theme_manager_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            )),
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
            currentTheme: darkTheme,
            child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // TRY THIS: Try running your application with "flutter run". You'll see
                  // the application has a purple toolbar. Then, without quitting the app,
                  // try changing the seedColor in the colorScheme below to Colors.green
                  // and then invoke "hot reload" (save your changes or press the "hot
                  // reload" button in a Flutter-supported IDE, or press "r" if you used
                  // the command line to start the app).
                  //
                  // Notice that the counter didn't reset back to zero; the application
                  // state is not lost during the reload. To reset the state, use hot
                  // restart instead.
                  //
                  // This works for code too, not just values: Most code changes can be
                  // tested with just a hot reload.
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const LoginPage()),
          );
        });
  }
}
