import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view_model.dart';
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

class _ReportSummaryUI
    extends ViewModelWidget<FinancialReportSummaryViewModel> {
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
                Padding(
                  padding: EdgeInsets.only(left: width * 0.01),
                  child: Container(
                    width: width * 0.11,
                    height: width * 0.11,
                    decoration: BoxDecoration(
                      color: data[index][iconBackgroundColorKey],
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        data[index][iconKey],
                        colorFilter:
                            ColorFilter.mode(data[index][iconColorKey], BlendMode.srcIn),
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
                  data[index][categoryKey],
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
