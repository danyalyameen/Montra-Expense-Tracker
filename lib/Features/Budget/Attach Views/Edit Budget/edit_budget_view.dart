import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_delete.dart';
import 'package:montra_expense_tracker/Widgets/show_category.dart';
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
  String title = "Remove this Budget?";
  String subtitle = "Are you sure do you want to remove this budget?";

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
            child: InkWell(
              onTap: () {
                Delete.showSheet(
                  context: context,
                  width: width,
                  height: height,
                  title: title,
                  subtitle: subtitle,
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
          _RemainingBalance(
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            width: width,
            height: height,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          _BalancePercentageIndicator(
            width: width,
            height: height,
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            color: color,
          ),
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
