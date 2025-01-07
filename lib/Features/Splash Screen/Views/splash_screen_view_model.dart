import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class SplashScreenViewModel extends ViewModel {
  navigation() async {
    await Future.delayed(const Duration(seconds: 3));
    navigationService.replaceWithOnBoardingView();
  }
}
