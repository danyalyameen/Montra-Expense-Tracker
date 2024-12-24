import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class EditBudgetView extends StackedView<EditBudgetViewModel> {
  final Color color;
  final String category, icon;
  final int spendBalance, limitBalance;
  final Color iconColor, backgroundColor;
  EditBudgetView(this.color, this.category, this.spendBalance,
      this.limitBalance, this.backgroundColor, this.iconColor, this.icon,
      {super.key});

  String appBarTitle = "Budget Details";
  String warning = "You've exceed the limit";

  @override
  Widget builder(
      BuildContext context, EditBudgetViewModel viewModel, Widget? child) {
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
            child: SvgPicture.asset(
              IconsPath.delete,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryRed, BlendMode.srcIn),
              width: width * 0.04,
              height: height * 0.04,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          ShowCategory(
            width: width,
            height: height,
            category: category,
            iconColor: iconColor,
            backgroundColor: backgroundColor,
            icon: icon,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          RemainingBalance(
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            width: width,
            height: height,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          BalancePercentageIndicator(
            width: width,
            height: height,
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            color: color,
          ),
          Warning(
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

class ShowCategory extends StatelessWidget {
  final double width, height;
  final String category, icon;
  final Color iconColor, backgroundColor;
  const ShowCategory(
      {super.key,
      required this.width,
      required this.height,
      required this.category,
      required this.iconColor,
      required this.backgroundColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                Padding(
                  padding: EdgeInsets.only(left: width * 0.01),
                  child: Container(
                    width: width * 0.11,
                    height: width * 0.11,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        icon,
                        colorFilter:
                            ColorFilter.mode(iconColor, BlendMode.srcIn),
                        width: width * 0.065,
                        height: width * 0.065,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
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
    );
  }
}

class RemainingBalance extends StatelessWidget {
  final int spendBalance, limitBalance;
  final double width, height;
  const RemainingBalance(
      {super.key,
      required this.spendBalance,
      required this.limitBalance,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Remaining",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: width * 0.06,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
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

class BalancePercentageIndicator extends StatelessWidget {
  final double width, height;
  final int spendBalance, limitBalance;
  final Color color;
  const BalancePercentageIndicator(
      {super.key,
      required this.width,
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
            Container(
              width: width * 0.8,
              height: height * 0.018,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.06),
                color: AppColors.light40,
              ),
            ),
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

class Warning extends StatelessWidget {
  final int spendBalance, limitBalance;
  final double width, height;
  final String warning;
  const Warning(
      {super.key,
      required this.spendBalance,
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
                  SvgPicture.asset(
                    IconsPath.warning,
                    colorFilter: ColorFilter.mode(
                        AppColors.primaryLight, BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
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
