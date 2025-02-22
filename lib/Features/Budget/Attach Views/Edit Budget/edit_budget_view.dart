import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/delete_sheet.dart';
import 'package:stacked/stacked.dart';

class EditBudgetView extends StackedView<EditBudgetViewModel> {
  final Color color;
  final String category, icon;
  final int spendBalance, limitBalance, index, month;
  final Color iconColor, backgroundColor;
  const EditBudgetView(
      {required this.month,
      required this.color,
      required this.category,
      required this.spendBalance,
      required this.limitBalance,
      required this.backgroundColor,
      required this.iconColor,
      required this.icon,
      required this.index,
      super.key});

  // Variables
  final String appBarTitle = "Budget Details";
  final String warning = "You've exceed the limit";
  final String title = "Remove this Budget?";
  final String subtitle = "Are you sure do you want to remove this budget?";

  @override
  Widget builder(
      BuildContext context, EditBudgetViewModel viewModel, Widget? child) {
    // Get Screen Size of a Device
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () => viewModel.navigationService.back(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: InkWell(
              onTap: () {
                // Delete Sheet
                Delete.showSheet(
                  context: context,
                  width: width,
                  height: height,
                  title: title,
                  subtitle: subtitle,
                  onPressed: () async {
                    await viewModel.budgetService.deleteBudget(
                      month: month,
                      index: index,
                    );
                    viewModel.navigationService.back();
                    viewModel.navigationService.back();
                  },
                );
              },
              child: SvgPicture.asset(
                IconsPath.delete,
                colorFilter:
                    ColorFilter.mode(AppColors.primaryRed, BlendMode.srcIn),
                width: width * 0.04,
                height: height * 0.04,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Budget Category
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                height: height * 0.08,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: width * 0.001,
                    color: AppColors.light20,
                  ),
                  borderRadius: BorderRadius.circular(width * 0.07),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: width * 0.001, horizontal: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Icon of Category
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.01),
                        child: Container(
                          width: width * 0.11,
                          height: width * 0.11,
                          decoration: BoxDecoration(
                            color: icon == IconsPath.other
                                ? AppColors.red20
                                : backgroundColor,
                            borderRadius: BorderRadius.circular(width * 0.04),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              icon,
                              colorFilter: icon == IconsPath.other
                                  ? null
                                  : ColorFilter.mode(
                                      iconColor, BlendMode.srcIn),
                              width: width * 0.065,
                              height: width * 0.065,
                            ),
                          ),
                        ),
                      ),
                      // For Spacing
                      SizedBox(
                        width: width * 0.02,
                      ),
                      // Category Name
                      Text(
                        category,
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
            ],
          ),
          // For Spacing
          SizedBox(
            height: height * 0.01,
          ),
          // Remaining Balance
          _RemainingBalance(
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            width: width,
            height: height,
          ),
          // For Spacing
          SizedBox(
            height: height * 0.01,
          ),
          // Progress Bar or Spend Bar
          _BalancePercentageIndicator(
            width: width,
            height: height,
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            color: icon == IconsPath.other ? AppColors.primaryRed : color,
          ),
          // Warning
          _Warning(
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            width: width,
            height: height,
            warning: warning,
          ),
        ],
      ),
    );
  }

  @override
  EditBudgetViewModel viewModelBuilder(BuildContext context) =>
      EditBudgetViewModel();
}

class _RemainingBalance extends StatelessWidget {
  final double width, height;
  final int spendBalance, limitBalance;
  const _RemainingBalance(
      {required this.spendBalance,
      required this.limitBalance,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Remaining
        Text(
          "Remaining",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: width * 0.06,
            fontWeight: FontWeight.w600,
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Remaining Balance
        Text(
          spendBalance > limitBalance
              ? "\$0"
              : "\$${limitBalance - spendBalance}",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: width * 0.15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _BalancePercentageIndicator extends StatelessWidget {
  final double width, height;
  final int spendBalance, limitBalance;
  final Color color;
  const _BalancePercentageIndicator(
      {required this.width,
      required this.height,
      required this.spendBalance,
      required this.limitBalance,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width * 0.8,
        child: Stack(
          children: [
            // Background
            Container(
              width: width * 0.8,
              height: height * 0.018,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.06),
                color: AppColors.light40,
              ),
            ),
            // Progress Bar
            Container(
              width: (width * 0.8) * (spendBalance / limitBalance),
              height: height * 0.018,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.06),
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Warning
class _Warning extends StatelessWidget {
  final int spendBalance, limitBalance;
  final double width, height;
  final String warning;
  const _Warning(
      {required this.spendBalance,
      required this.limitBalance,
      required this.width,
      required this.height,
      required this.warning});

  @override
  Widget build(BuildContext context) {
    return spendBalance > limitBalance
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Container(
              width: width * 0.6,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.circular(width * 0.06),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  SvgPicture.asset(
                    IconsPath.warning,
                    colorFilter: ColorFilter.mode(
                        AppColors.primaryLight, BlendMode.srcIn),
                  ),
                  // For Spacing
                  SizedBox(
                    width: width * 0.04,
                  ),
                  // Warning Text
                  Text(
                    warning,
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
