import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view_model.dart';
import 'package:montra_expense_tracker/Models/default_options_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

class CreateBudgetView extends StackedView<CreateBudgetViewModel> {
  const CreateBudgetView({super.key});

  final String appBarTitle = "Create Budget";
  final String buttonText = "Continue";

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
      body: Form(
        key: viewModel.formKey,
        child: Column(
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
                    _Category(
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
                child: TextFormField(
                  showCursor: false,
                  keyboardType: TextInputType.number,
                  controller: viewModel.balanceController,
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

class _Category extends ViewModelWidget<CreateBudgetViewModel> {
  final double width, height;
  const _Category({required this.width, required this.height});

  final String createCategory = "Create Category";
  final String dropDownText = "Category";

  @override
  Widget build(BuildContext context, CreateBudgetViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: CustomBottomSheet(
        buttonsBottomHight: height * 0.08,
        buttonText: createCategory,
        buttonWidth: width * 0.38,
        bottomSheetHight: height * 0.29,
        hintText: dropDownText,
        storeSelectedItem: viewModel.storeSelectedCategory,
        showItems: _ShowItemsForCategory(
          width: width,
          height: height,
          data: viewModel.fetchingCategoryOptions(),
          updateCategory: (index) {
            viewModel.updateCategoryHintText(index: index);
          },
        ),
        showSelectedItemOnHintText: _ShowSelectedCategory(
          width: width,
          height: height,
          storeSelectedCategory: viewModel.storeSelectedCategory,
        ),
      ),
    );
  }
}

class _ShowSelectedCategory extends StatelessWidget {
  final double width, height;
  final Map<String, dynamic> storeSelectedCategory;
  const _ShowSelectedCategory({
    required this.width,
    required this.height,
    required this.storeSelectedCategory,
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
              padding: EdgeInsets.all(width * 0.02),
              child: Text(
                storeSelectedCategory["option"],
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
                backgroundColor:
                    Color(int.parse(storeSelectedCategory["color"])),
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
  final Function(int index) updateCategory;
  final Future<DefaultOptionsModel> data;
  const _ShowItemsForCategory({
    required this.width,
    required this.height,
    required this.updateCategory,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: FutureBuilder<DefaultOptionsModel>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.defaultExpenseOptions!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.defaultExpenseOptions![index];
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
                      borderRadius: BorderRadius.circular(width * 0.08),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            data.option!,
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
                            backgroundColor: Color(int.parse(data.color!)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
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
