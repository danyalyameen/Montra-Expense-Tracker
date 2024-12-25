import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Attach%20Views/Report/Views/report_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/expense_item.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class ReportView extends StackedView<ReportViewModel> {
  ReportView({super.key});

  String appBarTitle = "Financial Report";
  String month = "Month";
  String spendKey = "Spend";
  String incomeKey = "Income";
  String iconKey = "Icon";
  String dropDownKey = "Drop-Down-Arrow";

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
          Graph(
            width: width,
            height: height,
            spendKey: spendKey,
            month: month,
            dropDownIconKey: dropDownKey,
            iconKey: iconKey,
            currentIndex: viewModel.currentIndex,
            switchBetweenGraphs: (int index) {
              viewModel.switchBetweenGraphs(index: index);
            },
          ),
          SizedBox(
            height: height * 0.02,
          ),
          ReportDetails(
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

// ignore: must_be_immutable
class Graph extends StatelessWidget {
  final double width, height;
  final String spendKey, month, dropDownIconKey, iconKey;
  int currentIndex;
  String dropDownText = "Month";
  final Function(int index) switchBetweenGraphs;
  Graph(
      {super.key,
      required this.width,
      required this.height,
      required this.spendKey,
      required this.month,
      required this.dropDownIconKey,
      required this.iconKey,
      required this.currentIndex,
      required this.switchBetweenGraphs});

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
              Row(
                children: List.generate(
                  Database.graphData.length,
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
                            Database.graphData[index][iconKey],
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
            ? Column(
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
                            barWidth: width * 0.025,
                            color: AppColors.primaryViolet,
                            isCurved: true,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.violet60,
                                  AppColors.primaryLight,
                                ],
                              ),
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (touchedSpot) =>
                                AppColors.primaryViolet,
                            getTooltipItems:
                                (List<LineBarSpot> touchedBarSpots) {
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
              )
            : SizedBox(
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
              ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ReportDetails extends StatelessWidget {
  final double width, height;
  final int indexForButtons;
  final Function onTapExpense, onTapIncome;
  ReportDetails(
      {super.key,
      required this.width,
      required this.height,
      required this.indexForButtons,
      required this.onTapExpense,
      required this.onTapIncome});

  String expenseButtonText = "Expense";
  String incomeButtonText = "Income";
  String dropDownText = "Sort";

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.34,
                    child: ListView.builder(
                      itemCount: Database.todayExpenseDatabase.length,
                      itemBuilder: (context, index) {
                        return ExpenseItem(
                          width: width,
                          height: height,
                          titleKey: "Category",
                          descriptionKey: "Description",
                          timeKey: "Time",
                          priceKey: "Expense",
                          iconKey: "Icon",
                          iconColorKey: "Icon-Color",
                          iconBackgroundColor: "Icon-Background",
                          index: index,
                          data: Database.todayExpenseDatabase,
                        );
                      },
                    ),
                  )
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
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.34,
                    child: ListView.builder(
                      itemCount: Database.incomeDatabase.length,
                      itemBuilder: (context, index) {
                        return ExpenseItem(
                          width: width,
                          height: height,
                          titleKey: "Category",
                          descriptionKey: "Description",
                          timeKey: "Time",
                          priceKey: "Expense",
                          iconKey: "Icon",
                          iconColorKey: "Icon-Color",
                          iconBackgroundColor: "Icon-Background",
                          index: index,
                          data: Database.incomeDatabase,
                          priceColor: AppColors.primaryGreen,
                        );
                      },
                    ),
                  )
                ],
              )
      ],
    );
  }
}
