import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view_model.dart';
import 'package:montra_expense_tracker/Widgets/add_options.dart';
import 'package:montra_expense_tracker/Widgets/category_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

class CreateBudgetView extends StackedView<CreateBudgetViewModel> {
  const CreateBudgetView({super.key});

  // Variables
  final String appBarTitle = "Create Budget";
  final String buttonText = "Continue";

  @override
  Widget builder(
      BuildContext context, CreateBudgetViewModel viewModel, Widget? child) {
    // Get Screen Size of a Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryViolet,
      appBar: whiteAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        backgroundColor: AppColors.primaryViolet,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Set Budget Balance
            _BudgetBalance(
              isOn: viewModel.isOn,
              height: height,
              width: width,
            ),
            // Round Background Color Container
            Expanded(
              child: Container(
                height: height * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.1),
                    topRight: Radius.circular(width * 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    // Select Category
                    CategoryBottomSheet(
                      dropDown: "Category",
                      fetchingCategoryOptions:
                          viewModel.optionService.getExpenseOptions(),
                      storeSelectedCategory: viewModel.storeSelectedCategory,
                      onPressed: () {
                        addOption(
                          width: width,
                          height: height,
                          title: "Create Category",
                          context: context,
                          addExpense: true,
                        );
                      },
                    ),
                    // Receive Alert Switch Tile
                    _SwitchTile(
                      width: width,
                      height: height,
                      isOn: viewModel.isOn,
                      updateSwitch: (value) => viewModel.updateSwitch(value),
                    ),
                    // Slider
                    viewModel.isOn
                        ? _Slider(
                            width: width,
                            height: height,
                          )
                        : const SizedBox(),
                    // Continue Button
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.05),
                      child: CustomElevatedButton(
                        width: width,
                        height: height,
                        backgroundColor: viewModel.showLoading
                            ? AppColors.violet20
                            : AppColors.primaryViolet,
                        onPressed: () => viewModel.addBudgetCompleted(),
                        child: viewModel.showLoading
                            ? SpinKitThreeBounce(
                                color: AppColors.primaryViolet,
                                size: width * 0.06,
                              )
                            : Text(
                                buttonText,
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CreateBudgetViewModel viewModelBuilder(BuildContext context) =>
      CreateBudgetViewModel();
}

class _BudgetBalance extends ViewModelWidget<CreateBudgetViewModel> {
  final double height, width;
  final bool isOn;
  const _BudgetBalance(
      {required this.height, required this.width, required this.isOn});

  // Variables
  final String inputHintText = "How much do you want to spend?";
  final String balanceHintText = "0";

  @override
  Widget build(BuildContext context, CreateBudgetViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(
          top: isOn ? height * 0.28 : height * 0.35, left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hint Text
          Text(
            inputHintText,
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
              color: AppColors.light80.withValues(alpha: 0.6),
            ),
          ),
          Row(
            children: [
              Text(
                Variables.currency,
                style: TextStyle(
                    fontSize: width * 0.16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.light80),
              ),
              Expanded(
                child: TextFormField(
                  showCursor: false,
                  keyboardType: TextInputType.number,
                  controller: viewModel.balanceController,
                  onTap: () {
                    viewModel.balanceController.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                          offset: viewModel.balanceController.text.length),
                    );
                  },
                  onChanged: (value) {
                    viewModel.balanceController.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: value.length),
                    );
                  },
                  style: TextStyle(
                    fontSize: width * 0.16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.light80,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: balanceHintText,
                    hintStyle: TextStyle(
                      fontSize: width * 0.16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.light80,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _SwitchTile extends ViewModelWidget<CreateBudgetViewModel> {
  final double width, height;
  final bool isOn;
  final Function(bool value) updateSwitch;
  const _SwitchTile(
      {required this.width,
      required this.height,
      required this.isOn,
      required this.updateSwitch});
  // Variables
  final String alertTitle = "Receive Alert";
  final String alertsubtitle = "Receive alert when it reaches some point.";

  @override
  Widget build(BuildContext context, CreateBudgetViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      child: SwitchTile(
        value: isOn,
        title: alertTitle,
        subtitle: alertsubtitle,
        onChanged: (value) {
          updateSwitch(value);
        },
      ),
    );
  }
}

class _Slider extends ViewModelWidget<CreateBudgetViewModel> {
  final double width, height;
  const _Slider({required this.width, required this.height});

  @override
  Widget build(BuildContext context, CreateBudgetViewModel viewModel) {
    return FlutterSlider(
      values: [viewModel.sliderValue],
      max: 100,
      min: 0,
      handlerHeight: height * 0.04,
      handlerWidth: width * 0.14,
      // Percentage Styling
      tooltip: FlutterSliderTooltip(
        textStyle: TextStyle(
          color: AppColors.primaryLight,
          fontSize: width * 0.0,
          fontWeight: FontWeight.w500,
        ),
        boxStyle: FlutterSliderTooltipBox(
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(width * 0.06),
          ),
        ),
      ),
      // Percentage
      handler: FlutterSliderHandler(
        decoration: BoxDecoration(
          color: AppColors.primaryViolet,
          borderRadius: BorderRadius.circular(width * 0.06),
          border: Border.all(
            width: width * 0.01,
            color: AppColors.primaryLight,
          ),
        ),
        child: Text(
          "${viewModel.sliderValue.toInt()}%",
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onDragging: (handlerIndex, lowerValue, upperValue) {
        viewModel.updateSlider(lowerValue);
      },
      // Track Bar Behind
      trackBar: FlutterSliderTrackBar(
        activeTrackBarHeight: height * 0.02,
        activeTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.06),
          color: AppColors.primaryViolet,
        ),
        inactiveTrackBarHeight: height * 0.02,
        inactiveTrackBar: BoxDecoration(
          color: AppColors.light40,
          borderRadius: BorderRadius.circular(width * 0.06),
        ),
      ),
    );
  }
}
