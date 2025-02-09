import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20PIN/Views/setup_pin_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SetupPinView extends StackedView<SetupPinViewModel> {
  const SetupPinView({super.key});

  @override
  void onViewModelReady(SetupPinViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.notificationBarService.whiteNotificationBar();
    // Check Pin is already setup or not
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(Variables.setupPinKey) == true) {
      viewModel.title = "Enter Pin";
      viewModel.notifyListeners();
    }
  }

  @override
  Widget builder(
      BuildContext context, SetupPinViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryViolet,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
          children: [
            // Title
            Center(
              child: Text(
                viewModel.title,
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // For Spacing
            SizedBox(
              height: height * 0.08,
            ),
            // Input Pin Means Circles
            _InputPin(
              width: width,
              height: height,
            ),
            // Input Digits Means Number Pad
            Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: _InputDigits(
                width: width,
                height: height,
                addPin: (value) => viewModel.addPin(value),
                removePin: viewModel.removePin,
                setupPin: viewModel.storePin,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  SetupPinViewModel viewModelBuilder(BuildContext context) =>
      SetupPinViewModel();
}

class _InputPin extends ViewModelWidget<SetupPinViewModel> {
  final double width, height;
  const _InputPin({required this.width, required this.height});

  @override
  Widget build(BuildContext context, SetupPinViewModel viewModel) {
    return SizedBox(
      width: width,
      height: height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) {
            return Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Container(
                width: width * 0.08,
                height: width * 0.08,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    // Check the Digit is Entered or Not and Change the Border Color
                    color: index < viewModel.enteredPin.length
                        ? AppColors.primaryLight
                        : AppColors.violet20,
                    width: width * 0.01,
                  ),
                  // Check the Digit is Entered or Not and Change the Fill Color
                  color: index < viewModel.enteredPin.length
                      ? AppColors.primaryLight
                      : Colors.transparent,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InputDigits extends StatelessWidget {
  final double width, height;
  final Function(String value) addPin;
  final Function removePin, setupPin;
  const _InputDigits(
      {required this.width,
      required this.height,
      required this.addPin,
      required this.removePin,
      required this.setupPin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Build Digits From 1 to 9
        SizedBox(
          width: width * 0.9,
          height: height * 0.4,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: width * 0.01,
              crossAxisSpacing: width * 0.01,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(width * 0.1),
                  onTap: () {
                    // Add Digit into the Entered Pin
                    addPin("${index + 1}");
                  },
                  child: SizedBox(
                    width: width * 0.2,
                    height: width * 0.2,
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.03,
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.15,
            ),
            // Remove Pin Widget
            SizedBox(
              width: width * 0.12,
              height: width * 0.12,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => removePin(),
                child: Transform.rotate(
                  angle: 3.14,
                  child: SvgPicture.asset(
                    IconsPath.deleteCharacter,
                    width: width * 0.12,
                    height: width * 0.12,
                    colorFilter: ColorFilter.mode(
                        AppColors.primaryLight, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            // For Spacing
            SizedBox(
              width: width * 0.125,
            ),
            // 0 Digit Widget
            InkWell(
              borderRadius: BorderRadius.circular(width),
              onTap: () {
                addPin("0");
              },
              child: SizedBox(
                width: width * 0.2,
                height: width * 0.2,
                child: Center(
                  child: Text(
                    "0",
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.14,
                    ),
                  ),
                ),
              ),
            ),
            // For Spacing
            SizedBox(
              width: width * 0.125,
            ),
            // Setup Pin Widget
            SizedBox(
              width: width * 0.15,
              height: width * 0.15,
              child: Transform.rotate(
                angle: 3.14,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => setupPin(),
                  child: SvgPicture.asset(
                    IconsPath.backArrow,
                    width: width * 0.14,
                    height: width * 0.14,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryLight,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
