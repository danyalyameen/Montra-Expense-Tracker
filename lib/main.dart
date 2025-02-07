import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_theme.dart';
import 'package:montra_expense_tracker/Features/Authentication/User%20Picture/user_picture_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: "https://edvqlhrgrcqjcldncyyh.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVkdnFsaHJncmNxamNsZG5jeXloIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY2ODQ1NTAsImV4cCI6MjA1MjI2MDU1MH0.zfyrYng-SoBnHFhJ7eyT5n5aUrzFz-M-316cIujihz8",
  );
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
      home: const UserPictureView(),
    );
  }
}
