import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/bloc/bloc_observer.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/login_screen.dart';
import 'package:sweetella/firebase_options.dart';
import 'package:sweetella/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  Bloc.observer = AppBlocObserver();
  runApp(DevicePreview(enabled: true, builder: (context) => DonutApp()));
}

class DonutApp extends StatelessWidget {
  const DonutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
      title: 'Sweetella Donuts',
      home: const LoginScreen(),
    );
  }
}
