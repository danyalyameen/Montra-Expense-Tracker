import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20PIN/Views/setup_pin_view_model.dart';
import 'package:stacked/stacked.dart';

class SetupPinView extends StackedView<SetupPinViewModel> {
  const SetupPinView({super.key});

  final String title = "Let's setup your PIN";

  @override
  Widget builder(
      BuildContext context, SetupPinViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryViolet,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.12,
            ),
            _InputPin(
              width: width,
              height: height,
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.1),
              child: _InputDigits(
                width: width,
                height: height,
                addPin: (value) => viewModel.addPin(value),
                removePin: viewModel.removePin,
                setupAccountNavigation: viewModel.setupAccountNavigation,
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

  @override
  bool get reactive => false;
}

class _InputPin extends ViewModelWidget<SetupPinViewModel> {
  final double width, height;
  const _InputPin({required this.width, required this.height});

  @override
  Widget build(BuildContext context, SetupPinViewModel viewModel) {
    return SizedBox(
      width: width,
      height: height * 0.1,
      child: Form(
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
                      color: index < viewModel.enteredPin.length
                          ? AppColors.primaryLight
                          : AppColors.violet20,
                      width: width * 0.01,
                    ),
                    color: index < viewModel.enteredPin.length
                        ? AppColors.primaryLight
                        : Colors.transparent,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InputDigits extends StatelessWidget {
  final double width, height;
  final Function(String value) addPin;
  final Function removePin, setupAccountNavigation;
  const _InputDigits(
      {required this.width,
      required this.height,
      required this.addPin,
      required this.removePin,
      required this.setupAccountNavigation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        SizedBox(
          height: height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => removePin(),
              child: Transform.rotate(
                angle: 3.14,
                child: SvgPicture.asset(
                  IconsPath.deleteCharacter,
                  width: width * 0.12,
                  height: width * 0.12,
                  colorFilter:
                      ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.19,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  addPin("0");
                },
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
            SizedBox(
              width: width * 0.17,
            ),
            Transform.rotate(
              angle: 3.14,
              child: InkWell(
                borderRadius: BorderRadius.circular(width),
                onTap: () => setupAccountNavigation(),
                child: SvgPicture.asset(
                  IconsPath.backArrow,
                  width: width * 0.14,
                  height: width * 0.14,
                  colorFilter:
                      ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
