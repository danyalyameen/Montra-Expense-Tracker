import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  FirebaseAuth authService = FirebaseAuth.instance;
  FirebaseFirestore database = FirebaseFirestore.instance;
}
