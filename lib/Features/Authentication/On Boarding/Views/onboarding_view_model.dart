import 'dart:async';

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class OnBoardingViewModel extends ViewModel {
  // Final Values
  final PageController _pageController = PageController();
  // Get Final Values
  PageController get pageController => _pageController;
  // Non Final Values
  int _currentIndex = 0;
  late Timer _timer;
  // Get Non Final Values
  int get currentIndex => _currentIndex;
  Timer get timer => _timer;

  // Update Index to change dot indicator color & size
  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Automatic Go To Next Page After 3 seconds
  void automaticChangePage() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // Check Index either the item is last or not
      if (_currentIndex < Database.onBoardingData.length - 1) {
        // Increasing Index
        _currentIndex++;
        // Changing Page
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        // Updating UI
        notifyListeners();
      } else {
        // Reset Index
        _currentIndex = 0;
        // Go to First Page
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        // Updating UI
        notifyListeners();
      }
    });
  }

  // Navigate to SignUp View
  void navigationSignUp() {
    navigationService.replaceWithSignUpView();
  }

  // Navigate to Login View
  void navigationLogin() {
    navigationService.replaceWithLoginView();
  }
}
