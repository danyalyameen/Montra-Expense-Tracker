import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class CreateBudgetView extends StackedView<CreateBudgetViewModel> {
  CreateBudgetView({super.key});

  String buttonText = "Continue";
  String appBarTitle = "Create Budget";
  String alertTitle = "Receive Alert";
  String alertsubtitle = "Receive alert when it reaches some point.";
  String createCategoryText = "Create Category";
  String hintTextForDropDown = "Category";
  String categoryOptionsCategoryKey = "Category";
  String categoryOptionsColorKey = "Colors";
  String inputHintText = "How much do you want to spend?";

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
          BudgetBalance(
            inputHintText: inputHintText,
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
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.05),
                    child: CustomDropDown(
                      buttonsBottomHight: height * 0.035,
                      buttonText: createCategoryText,
                      buttonWidth: width * 0.38,
                      bottomSheetHight: height * 0.25,
                      hintText: hintTextForDropDown,
                      showItems: ShowItemsForCategory(
                        categoryKey: categoryOptionsCategoryKey,
                        colorsKey: categoryOptionsColorKey,
                        width: width,
                        height: height,
                        categoryOptions: Database.categoryOptions,
                        updateCategory: (index) {
                          viewModel.updateCategoryHintText(index: index);
                        },
                      ),
                      showSelectedItemOnHintText: ShowSelectedCategory(
                        colorsKey: categoryOptionsColorKey,
                        width: width,
                        height: height,
                        storeSelectedCategory: viewModel.storeSelectedCategory,
                      ),
                      storeSelectedItem: viewModel.storeSelectedCategory,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
                    child:
                        SwitchTile(title: alertTitle, subtitle: alertsubtitle, onChanged: () {
                          
                        },),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
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

class BudgetBalance extends StatelessWidget {
  final double height, width;
  final String inputHintText;
  const BudgetBalance(
      {super.key,
      required this.height,
      required this.width,
      required this.inputHintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.36, left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputHintText,
            style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
                color: AppColors.light80.withOpacity(0.6)),
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
                    hintText: "0",
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

class ShowSelectedCategory extends StatelessWidget {
  final double width, height;
  final Map<String, dynamic> storeSelectedCategory;
  final String colorsKey;
  const ShowSelectedCategory(
      {super.key,
      required this.width,
      required this.height,
      required this.storeSelectedCategory,
      required this.colorsKey});

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
                backgroundColor: storeSelectedCategory[colorsKey],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowItemsForCategory extends StatelessWidget {
  final double width, height;
  final List<Map<String, dynamic>> categoryOptions;
  final Function(int index) updateCategory;
  final String colorsKey;
  final String categoryKey;
  const ShowItemsForCategory({
    super.key,
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
                        categoryOptions[index]["Category"],
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
