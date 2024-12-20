import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/di/dependency_injection.dart';
import 'package:task/core/router/app_router.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task/features/presentation/cubit/product_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => sl<ProductsCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'Vazirmatn',
          ),
          title: 'Koueider App',
          debugShowCheckedModeBanner: false,
          locale: Locale('ar', 'EG'),
          supportedLocales: [
            Locale('ar', 'EG'),
            Locale('en', 'US'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.home,
        ),
      ),
    );
  }
}
