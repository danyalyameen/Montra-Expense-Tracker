import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view_model.dart';
import 'package:montra_expense_tracker/Widgets/show_category.dart';
import 'package:stacked/stacked.dart';

class FinancialReportSummaryView
    extends StackedView<FinancialReportSummaryViewModel> {
  const FinancialReportSummaryView({super.key});

  final String backgroundColorKey = "Background";

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
            _Indicators(
              width: width,
              height: height,
            ),
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

  @override
  bool get reactive => false;
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

class _ReportSummaryUI extends ViewModelWidget<FinancialReportSummaryViewModel> {
  final double width, height;
  _ReportSummaryUI({required this.width, required this.height});

  final List<Map<String, dynamic>> data = Database.financialReport;
  final String titleKey = "Title";
  final String descriptionKey = "Description";
  final String spendKey = "Spend";
  final String categoryKey = "Category";
  final String iconKey = "Icon";
  final String iconColorKey = "Icon-Color";
  final String iconBackgroundColorKey = "Icon-Background";

  @override
  Widget build(
      BuildContext context, FinancialReportSummaryViewModel viewModel) {
    return Expanded(
      child: PageView.builder(
        itemCount: data.length,
        onPageChanged: (value) {
          viewModel.onChanged(value);
        },
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          index = viewModel.currentIndex;
          return Column(
            children: [
              Text(
                data[index][titleKey],
                style: TextStyle(
                  color: AppColors.primaryLight.withValues(alpha: 0.6),
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Text(
                data[index][descriptionKey],
                style: TextStyle(
                  color: AppColors.light80,
                  fontSize: width * 0.09,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "\$${data[index][spendKey]}",
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w700,
                  fontSize: width * 0.16,
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              _BiggestSpend(
                width: width,
                height: height,
                index: index,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BiggestSpend extends StatelessWidget {
  final double width, height;
  final int index;
  _BiggestSpend(
      {required this.width, required this.height, required this.index});

  final List<Map<String, dynamic>> data = Database.financialReport;
  final String titleKey = "Title";
  final String biggestSpendKey = "Biggest-Spending";
  final String categoryKey = "Category";
  final String iconKey = "Icon";
  final String iconColorKey = "Icon-Color";
  final String iconBackgroundColorKey = "Icon-Background";

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
            data[index][titleKey],
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
            category: data[index][categoryKey],
            icon: data[index][iconKey],
            iconColor: data[index][iconColorKey],
            backgroundColor: data[index][iconBackgroundColorKey],
          ),
          Text(
            "\$ ${data[index][biggestSpendKey]}",
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
