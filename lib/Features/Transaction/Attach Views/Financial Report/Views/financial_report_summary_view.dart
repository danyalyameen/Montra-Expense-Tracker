import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view_model.dart';
import 'package:montra_expense_tracker/Widgets/show_category.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class FinancialReportSummaryView
    extends StackedView<FinancialReportSummaryViewModel> {
  FinancialReportSummaryView({super.key});

  String backgroundColorKey = "Background";
  String titleKey = "Title";
  String descriptionKey = "Description";
  String spendKey = "Spend";
  String biggestSpendingTitleKey = "Biggest-Spending-Title";
  String biggestSpendingKey = "Biggest-Spending";
  String categoryKey = "Category";
  String iconKey = "Icon";
  String iconColorKey = "Icon-Color";
  String iconBackgroundColorKey = "Icon-Background";

  @override
  Widget builder(BuildContext context,
      FinancialReportSummaryViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Database.financialReport[viewModel.currentIndex]
          [backgroundColorKey],
      body: GestureDetector(
        onTapUp: (details) {
          viewModel.swithingViews(details: details, deviceWidth: width);
        },
        child: Column(
          children: [
            Padding(
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
                          width:
                              (width * 0.82) / Database.financialReport.length,
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
                  )),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: Database.financialReport.length,
                onPageChanged: (value) {
                  viewModel.currentIndex == value;
                  viewModel.rebuildUi();
                },
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  index = viewModel.currentIndex;
                  return Column(
                    children: [
                      Text(
                        Database.financialReport[index][titleKey],
                        style: TextStyle(
                          color: AppColors.primaryLight.withOpacity(0.6),
                          fontSize: width * 0.065,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.2,
                      ),
                      Text(
                        Database.financialReport[index][descriptionKey],
                        style: TextStyle(
                          color: AppColors.light80,
                          fontSize: width * 0.09,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "\$${Database.financialReport[index][spendKey]}",
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w700,
                          fontSize: width * 0.16,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                      BiggestSpend(
                        title: biggestSpendingTitleKey,
                        category: categoryKey,
                        icon: iconKey,
                        iconColor: iconColorKey,
                        iconBackgroundColor: iconBackgroundColorKey,
                        biggestSpend: biggestSpendingKey,
                        width: width,
                        height: height,
                        index: index,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  FinancialReportSummaryViewModel viewModelBuilder(BuildContext context) =>
      FinancialReportSummaryViewModel();
}

class BiggestSpend extends StatelessWidget {
  final double width, height;
  final int index;
  final String title,
      category,
      icon,
      iconColor,
      iconBackgroundColor,
      biggestSpend;
  const BiggestSpend(
      {super.key,
      required this.title,
      required this.category,
      required this.icon,
      required this.iconColor,
      required this.iconBackgroundColor,
      required this.biggestSpend,
      required this.width,
      required this.height,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
      height: height * 0.3,
      padding: EdgeInsets.only(
          top: height * 0.02, left: width * 0.18, right: width * 0.18),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      child: Column(
        children: [
          Text(
            Database.financialReport[index][title],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontSize: width * 0.065,
              fontWeight: FontWeight.w600,
            ),
          ),
          ShowCategory(
            width: width,
            height: height,
            category: Database.financialReport[index][category],
            iconColor: Database.financialReport[index][iconColor],
            backgroundColor: Database.financialReport[index]
                [iconBackgroundColor],
            icon: Database.financialReport[index][icon],
          ),
          Text(
            "\$ ${Database.financialReport[index][biggestSpend]}",
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
