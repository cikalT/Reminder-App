import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_reminder_app/configs/app_cubit.dart';
import 'package:its_reminder_app/utils/app_routes.dart';
import 'package:its_reminder_app/utils/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes().router,
        title: 'I' 'ts Time',
        theme: lightTheme,
      ),
    );
  }
}
