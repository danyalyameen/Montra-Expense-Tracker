import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Attach%20Views/Report/Views/report_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/user_transactions.dart';
import 'package:stacked/stacked.dart';

class ReportView extends StackedView<ReportViewModel> {
  const ReportView({super.key});

  final String appBarTitle = "Financial Report";

  @override
  Widget builder(
      BuildContext context, ReportViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Column(
        children: [
          _Graph(
            width: width,
            height: height,
            currentIndex: viewModel.currentIndex,
            switchBetweenGraphs: (int index) {
              viewModel.switchBetweenGraphs(index: index);
            },
          ),
          SizedBox(
            height: height * 0.02,
          ),
          _ReportDetails(
            width: width,
            height: height,
            indexForButtons: viewModel.indexForButtons,
            onTapExpense: viewModel.onTapExpense,
            onTapIncome: viewModel.onTapIncome,
          ),
        ],
      ),
    );
  }

  @override
  ReportViewModel viewModelBuilder(BuildContext context) => ReportViewModel();
}

class _Graph extends StatelessWidget {
  final double width, height;
  final int currentIndex;
  final Function(int index) switchBetweenGraphs;
  _Graph(
      {required this.width,
      required this.height,
      required this.currentIndex,
      required this.switchBetweenGraphs});

  final List<Map<String, dynamic>> data = Database.graphData;
  final String month = "Month";
  final String iconKey = "Icon";
  final String dropDownKey = "Drop-Down-Arrow";
  final String spendKey = "Spend";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.23,
                height: height * 0.045,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.06),
                  border: Border.all(
                    width: width * 0.002,
                    color: AppColors.light20,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.006),
                      child: SvgPicture.asset(
                        IconsPath.dropdownArrow,
                        width: width * 0.07,
                        height: width * 0.07,
                        colorFilter: ColorFilter.mode(
                          AppColors.primaryViolet,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      month,
                      style: TextStyle(
                        color: AppColors.primaryBlack,
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  data.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        switchBetweenGraphs(index);
                      },
                      child: Container(
                        width: width * 0.1,
                        height: width * 0.1,
                        decoration: BoxDecoration(
                            color: currentIndex == index
                                ? AppColors.primaryViolet
                                : AppColors.light60,
                            borderRadius: BorderRadius.circular(width * 0.02)),
                        child: Center(
                          child: SvgPicture.asset(
                            data[index][iconKey],
                            colorFilter: ColorFilter.mode(
                              index == currentIndex
                                  ? AppColors.primaryLight
                                  : AppColors.primaryViolet,
                              BlendMode.srcIn,
                            ),
                            width: width * 0.07,
                            height: width * 0.07,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        currentIndex == 0
            ? _LineGraph(
                width: width,
                height: height,
                spendKey: spendKey,
              )
            : _CicleGraph(
                height: height,
                width: width,
                spendKey: spendKey,
              ),
      ],
    );
  }
}

class _LineGraph extends StatelessWidget {
  final double width, height;
  final String spendKey;
  const _LineGraph(
      {required this.width, required this.height, required this.spendKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Text(
            "\$ ${Database.graphData[0][spendKey]}",
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontSize: width * 0.08,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: height * 0.2,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 6,
              backgroundColor: AppColors.primaryLight,
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(
                show: false,
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 3),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 3.1),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                  dotData: const FlDotData(
                    show: false,
                  ),
                  barWidth: width * 0.015,
                  color: AppColors.primaryViolet,
                  isCurved: true,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.violet40.withValues(alpha: 0.8),
                        AppColors.primaryLight,
                      ],
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => AppColors.primaryViolet,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      return LineTooltipItem(
                        '${barSpot.y.toInt()}',
                        TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CicleGraph extends StatelessWidget {
  final double width, height;
  final String spendKey;
  const _CicleGraph(
      {required this.width, required this.height, required this.spendKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.28,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: height * 0.3,
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                centerSpaceColor: AppColors.primaryLight,
                centerSpaceRadius: double.infinity,
                sectionsSpace: 0,
                sections: [
                  PieChartSectionData(
                    showTitle: false,
                    color: AppColors.primaryYellow,
                    value: 50,
                    radius: width * 0.07,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    color: AppColors.primaryViolet,
                    value: 30,
                    radius: width * 0.07,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    color: AppColors.primaryRed,
                    value: 20,
                    radius: width * 0.07,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              "\$ ${Database.graphData[0][spendKey]}",
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: width * 0.08,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportDetails extends ViewModelWidget<ReportViewModel> {
  final double width, height;
  final int indexForButtons;
  final Function onTapExpense, onTapIncome;
  const _ReportDetails({
    required this.width,
    required this.height,
    required this.indexForButtons,
    required this.onTapExpense,
    required this.onTapIncome,
  });

  final String expenseButtonText = "Expense";
  final String incomeButtonText = "Income";
  final String dropDownText = "Sort";
  final String titleKey = "Category";
  final String descriptionKey = "Description";
  final String timeKey = "Time";
  final String priceKey = "Expense";
  final String iconKey = "Icon";
  final String iconColorKey = "Icon-Color";
  final String iconBackgroundColorKey = "Icon-Background";

  @override
  Widget build(BuildContext context, ReportViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * 0.88,
          height: height * 0.07,
          decoration: BoxDecoration(
            color: AppColors.light60,
            borderRadius: BorderRadius.circular(width * 0.08),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  onTapExpense();
                },
                child: Container(
                  width: indexForButtons == 0
                      ? width * 0.46
                      : (width * 0.88) / 2.5,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      color: indexForButtons == 0
                          ? AppColors.primaryViolet
                          : AppColors.light60,
                      borderRadius: BorderRadius.circular(width * 0.08)),
                  child: Center(
                    child: Text(
                      expenseButtonText,
                      style: TextStyle(
                        color: indexForButtons == 0
                            ? AppColors.light60
                            : AppColors.primaryBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onTapIncome();
                },
                child: Container(
                  width: indexForButtons == 1
                      ? width * 0.46
                      : (width * 0.88) / 2.5,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      color: indexForButtons == 1
                          ? AppColors.primaryViolet
                          : AppColors.light60,
                      borderRadius: BorderRadius.circular(width * 0.08)),
                  child: Center(
                    child: Text(
                      incomeButtonText,
                      style: TextStyle(
                        color: indexForButtons == 1
                            ? AppColors.light60
                            : AppColors.primaryBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        indexForButtons == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.22,
                    height: height * 0.045,
                    padding: EdgeInsets.only(left: width * 0.02),
                    margin: EdgeInsets.only(
                        top: height * 0.01, bottom: height * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.06),
                      border: Border.all(
                        width: width * 0.002,
                        color: AppColors.light20,
                      ),
                      color: AppColors.primaryLight,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconsPath.dropdownArrow,
                          width: width * 0.07,
                          height: width * 0.07,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryViolet,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          dropDownText,
                          style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  UserTransactions(
                    width: width * 0.9,
                    height: height * 0.34,
                icons: viewModel.transactionsService.transactionIcons(),
                transactions: viewModel.transactionsService.fetchTransactions(),
              ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.22,
                    height: height * 0.045,
                    padding: EdgeInsets.only(left: width * 0.02),
                    margin: EdgeInsets.only(
                        top: height * 0.01, bottom: height * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.06),
                      border: Border.all(
                        width: width * 0.002,
                        color: AppColors.light20,
                      ),
                      color: AppColors.primaryLight,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconsPath.dropdownArrow,
                          width: width * 0.07,
                          height: width * 0.07,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryViolet,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          dropDownText,
                          style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  UserTransactions(
                    width: width * 0.9,
                    height: height * 0.34,
                icons: viewModel.transactionsService.transactionIcons(),
                transactions: viewModel.transactionsService.fetchTransactions(),
              ),
                ],
              ),
      ],
    );
  }
}
