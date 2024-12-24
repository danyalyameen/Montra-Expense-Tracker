import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// ignore: must_be_immutable
class BudgetView extends StackedView<BudgetViewModel> {
  BudgetView({super.key});

  String categoryKey = "Category";
  String colorKey = "Color";
  String limitKey = "Limit";
  String spendKey = "Spend";
  String iconKey = "Icon";
  String iconColorKey = "Icon-Color";
  String iconBackgroundColorKey = "Icon-Background";
  String titleOnEmptyList =
      "You don't have a budget. \n Let's make one so you in control.";
  String warning = "You've exceed the limit";
  String buttonText = "Create a budget";

  @override
  Widget builder(
      BuildContext context, BudgetViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryViolet,
      appBar: whiteAppBar(
          toolBarHight: height * 0.12,
          backgroundColor: AppColors.primaryViolet,
          title: Database.months[viewModel.index],
          width: width,
          height: height,
          leading: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(width * 0.06),
              onTap: () {
                viewModel.decrementIndex();
              },
              child: SvgPicture.asset(
                IconsPath.leftArrow,
                width: width * 0.05,
                height: height * 0.05,
                colorFilter:
                    ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: width * 0.02),
              child: InkWell(
                borderRadius: BorderRadius.circular(width * 0.08),
                onTap: () {
                  viewModel.incrementIndex();
                },
                child: SvgPicture.asset(
                  IconsPath.rightArrow,
                  width: width * 0.05,
                  height: height * 0.05,
                  colorFilter:
                      ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
                ),
              ),
            ),
          ]),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.06),
            topRight: Radius.circular(width * 0.06),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BudgetItemUI(
                warning: warning,
                height: height,
                width: width,
                titleOnEmptyList: titleOnEmptyList,
                categoryKey: categoryKey,
                colorKey: colorKey,
                limitKey: limitKey,
                spendKey: spendKey,
                percentage: (index) {
                  return viewModel.percentage(index: index);
                },
                navigationService: viewModel.navigationService, iconKey: iconKey, iconBackgroundColorKey: iconBackgroundColorKey, iconColorKey: iconColorKey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.05),
              child: CustomElevatedButton(
                width: width,
                height: height,
                text: buttonText,
                onPressed: () {
                  viewModel.navigationService.navigateToCreateBudgetView();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  BudgetViewModel viewModelBuilder(BuildContext context) => BudgetViewModel();
}

class BudgetItemUI extends StatelessWidget {
  final String titleOnEmptyList,
      categoryKey,
      colorKey,
      limitKey,
      spendKey,
      iconKey,
      iconColorKey,
      iconBackgroundColorKey,
      warning;
  final double width, height;
  final double Function(int index) percentage;
  final NavigationService navigationService;
  const BudgetItemUI(
      {super.key,
      required this.titleOnEmptyList,
      required this.width,
      required this.height,
      required this.categoryKey,
      required this.colorKey,
      required this.limitKey,
      required this.spendKey,
      required this.percentage,
      required this.warning,
      required this.navigationService, required this.iconKey, required this.iconColorKey, required this.iconBackgroundColorKey});

  @override
  Widget build(BuildContext context) {
    return Database.budgetData.isEmpty
        ? Center(
            child: Text(
              titleOnEmptyList,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.grey,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w500),
            ),
          )
        : ListView.builder(
            itemCount: Database.budgetData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? height * 0.04 : height * 0.02,
                  bottom: height * 0.02,
                ),
                child: Center(
                  child: SizedBox(
                    width: width * 0.9,
                    height: Database.budgetData[index][spendKey] >
                            Database.budgetData[index][limitKey]
                        ? height * 0.24
                        : height * 0.2,
                    child: InkWell(
                      onTap: () {
                        navigationService.navigateToEditBudgetView(
                            color: Database.budgetData[index][colorKey],
                            category: Database.budgetData[index][categoryKey],
                            spendBalance: Database.budgetData[index][spendKey],
                            limitBalance: Database.budgetData[index][limitKey], backgroundColor: Database.budgetData[index][iconBackgroundColorKey], icon: Database.budgetData[index][iconKey], iconColor: Database.budgetData[index][iconColorKey]);
                      },
                      child: Card(
                        color: AppColors.light80,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.06),
                        ),
                        elevation: width * 0.002,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.02,
                                left: width * 0.04,
                                right: width * 0.04,
                                bottom: height * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: width * 0.001,
                                        color: AppColors.primaryBlack,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(width * 0.04),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: width * 0.001,
                                          horizontal: width * 0.03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: width * 0.035,
                                            height: height * 0.035,
                                            child: CircleAvatar(
                                              backgroundColor: Database
                                                  .budgetData[index][colorKey],
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Text(
                                            Database.budgetData[index]
                                                [categoryKey],
                                            style: TextStyle(
                                              color: AppColors.primaryBlack,
                                              fontSize: width * 0.038,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Database.budgetData[index][spendKey] >
                                          Database.budgetData[index][limitKey]
                                      ? SvgPicture.asset(
                                          IconsPath.warning,
                                          colorFilter: ColorFilter.mode(
                                              AppColors.primaryRed,
                                              BlendMode.srcIn),
                                        )
                                      : const Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.04),
                              child: Text(
                                Database.budgetData[index][spendKey] >
                                        Database.budgetData[index][limitKey]
                                    ? "Remaining \$0"
                                    : "Remaining \$${Database.budgetData[index][limitKey] - Database.budgetData[index][spendKey]}",
                                style: TextStyle(
                                  color: AppColors.primaryBlack,
                                  fontSize: width * 0.06,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Center(
                              child: SizedBox(
                                width: width * 0.8,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: width * 0.8,
                                      height: height * 0.018,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.06),
                                        color: AppColors.light40,
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.8 * percentage(index),
                                      height: height * 0.018,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.06),
                                        color: Database.budgetData[index]
                                            [colorKey],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.01, left: width * 0.04),
                              child: Text(
                                "\$${Database.budgetData[index][spendKey]} of \$${Database.budgetData[index][limitKey]}",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Database.budgetData[index][spendKey] >
                                    Database.budgetData[index][limitKey]
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.04, top: height * 0.01),
                                    child: Text(
                                      warning,
                                      style: TextStyle(
                                          color: AppColors.primaryRed,
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
