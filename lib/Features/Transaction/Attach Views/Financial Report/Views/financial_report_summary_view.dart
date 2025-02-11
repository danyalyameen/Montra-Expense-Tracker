import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class FinancialReportSummaryView
    extends StackedView<FinancialReportSummaryViewModel> {
  const FinancialReportSummaryView({super.key});

  // Variables
  final String backgroundColorKey = "Background";

  @override
  void onViewModelReady(FinancialReportSummaryViewModel viewModel) {
    // Change Notification Bar Color
    viewModel.notificationBarService.whiteNotificationBar();
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(FinancialReportSummaryViewModel viewModel) {
    // Change Notification Bar Color
    viewModel.notificationBarService.blackNotificationBar();
    super.onDispose(viewModel);
  }

  @override
  Widget builder(BuildContext context,
      FinancialReportSummaryViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: viewModel.currentIndex == 0
          ? AppColors.primaryRed
          : AppColors.primaryGreen,
      body: GestureDetector(
        onTapUp: (details) {
          // Switching between Two UIs
          viewModel.swithingViews(details: details, deviceWidth: width);
        },
        child: Column(
          children: [
            // Top White Indicators
            _Indicators(
              width: width,
              height: height,
            ),
            // The Summary of the Report
            _ReportSummaryUI(
              width: width,
              height: height,
            ),
          ],
        ),
      ),
    );
  }

  @override
  FinancialReportSummaryViewModel viewModelBuilder(BuildContext context) =>
      FinancialReportSummaryViewModel();
}

class _Indicators extends ViewModelWidget<FinancialReportSummaryViewModel> {
  final double width, height;
  const _Indicators({required this.width, required this.height});

  @override
  Widget build(
      BuildContext context, FinancialReportSummaryViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          Database.financialReport.length,
          (index) {
            return Padding(
              padding: EdgeInsets.only(
                top: height * 0.04,
                left: width * 0.01,
                right: width * 0.01,
              ),
              child: Container(
                width: (width * 0.82) / Database.financialReport.length,
                height: height * 0.006,
                decoration: BoxDecoration(
                  color: viewModel.currentIndex == index
                      ? AppColors.primaryLight
                      : AppColors.light30,
                  borderRadius: BorderRadius.circular(width * 0.06),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ReportSummaryUI
    extends ViewModelWidget<FinancialReportSummaryViewModel> {
  final double width, height;
  const _ReportSummaryUI({required this.width, required this.height});

  // Variables
  final String appBarTitle = "This Month";
  final String spendTitle = "You Spend 💸";
  final String incomeTitle = "You Earned 💰";

  @override
  Widget build(
      BuildContext context, FinancialReportSummaryViewModel viewModel) {
    return Expanded(
      child: FutureBuilder(
        future: Future.wait([
          viewModel.getTotalSpend(),
          viewModel.getBiggestSpend(),
          viewModel.getTotalIncome(),
          viewModel.getBiggestIncome()
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                // Title Means This Month
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                  ),
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.2,
                ),
                // Description Means You Spend or You Earn
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                  ),
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.01,
                ),
                // Spend
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                  ),
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.15,
                ),
                // Biggest Spend
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.3,
                    padding: EdgeInsets.only(
                        top: height * 0.02,
                        left: width * 0.18,
                        right: width * 0.18),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(width * 0.06),
                    ),
                  ),
                ),
              ],
            );
          }
          // Data
          int totalSpend = snapshot.data![0] as int;
          Map<String, dynamic> biggestSpendAndCategory =
              snapshot.data![1] as Map<String, dynamic>;
          int totalIncome = snapshot.data![2] as int;
          Map<String, dynamic> biggestIncomeAndCategory =
              snapshot.data![3] as Map<String, dynamic>;
          return PageView.builder(
            itemCount: 2,
            onPageChanged: (value) {
              viewModel.onChanged(value);
            },
            // So that It can't scroll
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              index = viewModel.currentIndex;
              return Column(
                children: [
                  // Title Means This Month
                  Text(
                    appBarTitle,
                    style: TextStyle(
                      color: AppColors.primaryLight.withValues(alpha: 0.6),
                      fontSize: width * 0.065,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.2,
                  ),
                  // Description Means You Spend or You Earn
                  Text(
                    index == 0 ? spendTitle : incomeTitle,
                    style: TextStyle(
                      color: AppColors.light80,
                      fontSize: width * 0.09,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Spend
                  Text(
                    "${Variables.currency}${index == 0 ? totalSpend : totalIncome}",
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w700,
                      fontSize: width * 0.16,
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.15,
                  ),
                  // Biggest Spend
                  _BiggestSpend(
                    width: width,
                    height: height,
                    index: index,
                    category: index == 0
                        ? biggestSpendAndCategory
                        : biggestIncomeAndCategory,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _BiggestSpend extends StatelessWidget {
  final double width, height;
  final int index;
  final Map<String, dynamic> category;
  const _BiggestSpend(
      {required this.width,
      required this.height,
      required this.index,
      required this.category});

  // Variables
  final String biggestSpendTitle = "Biggest Spend";
  final String biggestIncomeTitle = "Biggest Income";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
      height: height * 0.3,
      padding: EdgeInsets.only(
          top: height * 0.02, left: width * 0.18, right: width * 0.18),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(width * 0.06),
      ),
      child: Column(
        children: [
          // Title
          Text(
            index == 0 ? biggestSpendTitle : biggestIncomeTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontSize: width * 0.065,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Category
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
                      // Icon
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.01),
                        child: Container(
                          width: width * 0.11,
                          height: width * 0.11,
                          decoration: BoxDecoration(
                            color: category["iconBackgroundColor"],
                            borderRadius: BorderRadius.circular(width * 0.04),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              category["icon"],
                              colorFilter: category["icon"] != IconsPath.other
                                  ? ColorFilter.mode(
                                      category["iconColor"],
                                      BlendMode.srcIn,
                                    )
                                  : null,
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
                      // Category
                      Text(
                        category["category"],
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
          // Biggest Spend
          Text(
            "${Variables.currency}${category["largestNumber"]}",
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontSize: width * 0.08,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
