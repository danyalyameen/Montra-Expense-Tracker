import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_theme.dart';
import 'package:montra_expense_tracker/Features/Splash%20Screen/Views/splash_screen_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      theme: AppTheme().lightTheme,
      home: const SplashScreenView(),
    );
  }
}
