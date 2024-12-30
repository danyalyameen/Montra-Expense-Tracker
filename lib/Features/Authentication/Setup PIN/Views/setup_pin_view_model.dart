import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class SetupPinViewModel extends ViewModel {
  final bool _isFocus = true;
  String _enteredPin = "";

  bool get isFocus => _isFocus;
  String get enteredPin => _enteredPin;

  void addPin(String value) {
    if (_enteredPin.length < 4) {
      _enteredPin += value;
    }
    notifyListeners();
  }

  void removePin() {
    if (_enteredPin.isNotEmpty) {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    }
    notifyListeners();
  }

  void setupAccountNavigation() {
    navigationService.replaceWithSetupAccountView();
  }
}
