import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class CreateBudgetView extends StackedView<CreateBudgetViewModel> {
  CreateBudgetView({super.key});

  String appBarTitle = "Create Budget";
  String buttonText = "Continue";

  @override
  Widget builder(
      BuildContext context, CreateBudgetViewModel viewModel, Widget? child) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BudgetBalance(
            isOn: viewModel.isOn,
            height: height,
            width: width,
          ),
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
                  _ShowCategory(
                    width: width,
                    height: height,
                  ),
                  _SwitchTile(
                    width: width,
                    height: height,
                    isOn: viewModel.isOn,
                    updateSwitch: (value) => viewModel.updateSwitch(value),
                  ),
                  viewModel.isOn
                      ? _Slider(
                          width: width,
                          height: height,
                        )
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.05),
                    child: CustomElevatedButton(
                      width: width,
                      height: height,
                      text: buttonText,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  CreateBudgetViewModel viewModelBuilder(BuildContext context) =>
      CreateBudgetViewModel();

}

class _BudgetBalance extends StatelessWidget {
  final double height, width;
  final bool isOn;
  const _BudgetBalance(
      {required this.height, required this.width, required this.isOn});

  final String inputHintText = "How much do you want to spend?";
  final String balance = "0";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: isOn ? height * 0.28 : height * 0.35, left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputHintText,
            style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
                color: AppColors.light80.withValues(alpha: 0.6)),
          ),
          Row(
            children: [
              Text(
                "\$",
                style: TextStyle(
                    fontSize: width * 0.16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.light80),
              ),
              Expanded(
                child: TextField(
                  showCursor: false,
                  keyboardType: const TextInputType.numberWithOptions(),
                  style: TextStyle(
                    fontSize: width * 0.16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.light80,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: balance,
                    hintStyle: TextStyle(
                      fontSize: width * 0.16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.light80,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ShowCategory extends ViewModelWidget<CreateBudgetViewModel> {
  final double width, height;
  const _ShowCategory({required this.width, required this.height});

  final String hintTextForDropDown = "Category";
  final String createCategoryText = "Create Category";
  final String categoryOptionsCategoryKey = "Category";
  final String categoryOptionsColorKey = "Colors";

  @override
  Widget build(BuildContext context, CreateBudgetViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: CustomBottomSheet(
        hintText: hintTextForDropDown,
        bottomSheetHight: height * 0.3,
        buttonText: createCategoryText,
        buttonsBottomHight: height * 0.09,
        buttonWidth: width * 0.38,
        showItems: _ShowItemsForCategory(
          categoryKey: categoryOptionsCategoryKey,
          colorsKey: categoryOptionsColorKey,
          width: width,
          height: height,
          categoryOptions: Database.categoryOptions,
          updateCategory: (index) {
            viewModel.updateCategoryHintText(index: index);
          },
        ),
        showSelectedItemOnHintText: _ShowSelectedCategory(
          width: width,
          height: height,
          colorKey: categoryOptionsColorKey,
          storeSelectedCategory: viewModel.storeSelectedCategory,
        ),
        storeSelectedItem: viewModel.storeSelectedCategory,
      ),
    );
  }
}

class _ShowSelectedCategory extends StatelessWidget {
  final double width, height;
  final Map<String, dynamic> storeSelectedCategory;
  final String colorKey;
  const _ShowSelectedCategory({
    required this.width,
    required this.height,
    required this.storeSelectedCategory,
    required this.colorKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryBlack,
            width: width * 0.002,
          ),
          borderRadius: BorderRadius.circular(width * 0.08),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                storeSelectedCategory[Variables.universalItemKey],
                style: TextStyle(
                    color: AppColors.primaryBlack, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.04),
              child: CircleAvatar(
                maxRadius: width * 0.01,
                backgroundColor: storeSelectedCategory[colorKey],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ShowItemsForCategory extends StatelessWidget {
  final double width, height;
  final List<Map<String, dynamic>> categoryOptions;
  final Function(int index) updateCategory;
  final String colorsKey;
  final String categoryKey;
  const _ShowItemsForCategory({
    required this.width,
    required this.height,
    required this.categoryOptions,
    required this.updateCategory,
    required this.colorsKey,
    required this.categoryKey,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryOptions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.057),
            child: InkWell(
              onTap: () {
                updateCategory(index);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryBlack,
                      width: width * 0.002,
                    ),
                    borderRadius: BorderRadius.circular(width * 0.08)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        categoryOptions[index][categoryKey],
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.04),
                      child: CircleAvatar(
                        maxRadius: width * 0.01,
                        backgroundColor: categoryOptions[index][colorsKey],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
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
