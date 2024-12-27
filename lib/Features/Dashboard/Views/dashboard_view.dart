import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/image_path.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view_model.dart';
import 'package:montra_expense_tracker/Widgets/expense_item.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class DashboardView extends StackedView<DashboardViewModel> {
  DashboardView({super.key});

  String monthText = "Month";
  String accountTitle = "Account Balance";
  int balance = 9450;
  String incomeText = "Income";
  int incomeBalance = 5000;
  String expenseText = "Expense";
  int expenseBalance = 1200;
  String transactionsTitle = "Recent Transactions";
  String seeAllTransactionsText = "See All";
  String titleKey = "Category";
  String descriptionKey = "Description";
  String timeKey = "Time";
  String priceKey = "Expense";
  String iconKey = "Icon";
  String iconColorKey = "Icon-Color";
  String iconBackgroundColorKey = "Icon-Background";
  String bottomNavigationIconKey = "Icon";
  String bottomNavigationTitleKey = "Title";

  @override
  Widget builder(
      BuildContext context, DashboardViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.customColorBrown,
                  AppColors.customColorWhite.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.005),
            child: ListView(
              children: [
                TopNavigation(
                    height: height, width: width, monthText: monthText),
                SizedBox(
                  height: height * 0.01,
                ),
                ShowAcccount(
                  title: accountTitle,
                  balance: balance,
                  height: height,
                  width: width,
                  incomeText: incomeText,
                  incomeBalance: incomeBalance,
                  expenseText: expenseText,
                  expenseBalance: expenseBalance,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ShowGraph(
                  width: width,
                  height: height,
                  data: Database.time,
                  updateIndex: (index) {
                    viewModel.updateIndex(index);
                  },
                  currentIndex: viewModel.currentIndex,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                RecentTransactions(
                  width: width,
                  height: height,
                  transactionsTitle: transactionsTitle,
                  seeAllTransactionsText: seeAllTransactionsText,
                  descriptionKey: descriptionKey,
                  iconBackgroundColorKey: iconBackgroundColorKey,
                  iconColorKey: iconColorKey,
                  iconKey: iconKey,
                  priceKey: priceKey,
                  timeKey: timeKey,
                  titleKey: titleKey,
                ),
              ],
            ),
          ),
          viewModel.showItems
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryViolet.withOpacity(0.45),
                        AppColors.primaryViolet.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.72),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: width * 0.07,
                              backgroundColor: AppColors.primaryBlue,
                              child: Center(
                                child: SvgPicture.asset(
                                  IconsPath.currencyExchange,
                                  width: width * 0.09,
                                  height: width * 0.09,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.primaryLight, BlendMode.srcIn),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: width * 0.07,
                              backgroundColor: AppColors.primaryGreen,
                              child: Center(
                                child: SvgPicture.asset(
                                  IconsPath.income,
                                  width: width * 0.09,
                                  height: width * 0.09,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.primaryLight, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.25,
                            ),
                            CircleAvatar(
                              radius: width * 0.07,
                              backgroundColor: AppColors.primaryRed,
                              child: SvgPicture.asset(
                                IconsPath.expense,
                                width: width * 0.09,
                                height: width * 0.09,
                                colorFilter: ColorFilter.mode(
                                    AppColors.primaryLight, BlendMode.srcIn),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FAB(
        width: width,
        height: height,
        onPressed: () {
          viewModel.showOrHideItems();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryLight,
        shape: const CircularNotchedRectangle(),
        notchMargin: width * 0.02,
        height: height * 0.0956,
        child: BottomNavigation(
          width: width,
          height: height,
          data: Database.bottomNavigationData,
          iconKey: iconKey,
          titleKey: bottomNavigationTitleKey,
          updateIndex: (index) {
            viewModel.updateIndexForBottomNavigation(index);
          },
          currentIndex: viewModel.currentIndexForBottomNavigation,
        ),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();
}

class TopNavigation extends StatelessWidget {
  final double height, width;
  final String monthText;
  const TopNavigation(
      {super.key,
      required this.height,
      required this.width,
      required this.monthText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.violet60,
                width: width * 0.006,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.005),
              child: CircleAvatar(
                radius: width * 0.04,
                backgroundImage: AssetImage(ImagePath.userImage),
              ),
            ),
          ),
          Container(
            width: width * 0.25,
            height: height * 0.045,
            padding: EdgeInsets.only(left: width * 0.02),
            margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.06),
              border: Border.all(
                width: width * 0.002,
                color: AppColors.light20,
              ),
              color: Colors.transparent,
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
                  monthText,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                )
              ],
            ),
          ),
          Center(
            child: SvgPicture.asset(
              IconsPath.notification,
              colorFilter: ColorFilter.mode(
                AppColors.primaryViolet,
                BlendMode.srcIn,
              ),
              width: width * 0.08,
              height: width * 0.08,
            ),
          )
        ],
      ),
    );
  }
}

class ShowAcccount extends StatelessWidget {
  final double height, width;
  final int balance;
  final String title, incomeText, expenseText;
  final int incomeBalance, expenseBalance;
  const ShowAcccount(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.balance,
      required this.incomeText,
      required this.incomeBalance,
      required this.expenseText,
      required this.expenseBalance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          "\$$balance",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: width * 0.12,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.425,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(width * 0.06),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.135,
                      height: width * 0.135,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(width * 0.04),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          IconsPath.income,
                          width: width * 0.08,
                          height: width * 0.08,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryGreen,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          incomeText,
                          style: TextStyle(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.035),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          "\$$incomeBalance",
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              Container(
                width: width * 0.425,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(width * 0.06),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.135,
                      height: width * 0.135,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(width * 0.04),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          IconsPath.income,
                          width: width * 0.08,
                          height: width * 0.08,
                          colorFilter: ColorFilter.mode(
                            AppColors.primaryRed,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expenseText,
                          style: TextStyle(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.035),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          "\$$expenseBalance",
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ShowGraph extends StatelessWidget {
  final double width, height;
  final List<String> data;
  final int currentIndex;
  final Function(int index) updateIndex;
  const ShowGraph(
      {super.key,
      required this.width,
      required this.height,
      required this.data,
      required this.updateIndex,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Text(
            "Spend Frequency",
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.04,
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
              backgroundColor: Colors.transparent,
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(
                show: false,
              ),
              lineBarsData: [
                LineChartBarData(
                  dotData: const FlDotData(
                    show: false,
                  ),
                  spots: const [
                    FlSpot(0, 3),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 3.1),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                  barWidth: width * 0.015,
                  color: AppColors.primaryViolet,
                  isCurved: true,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.violet40.withOpacity(0.8),
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
        SizedBox(
          height: height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              data.length,
              (index) {
                return InkWell(
                  onTap: () => updateIndex(index),
                  borderRadius: BorderRadius.circular(width * 0.06),
                  child: Container(
                    width: width * 0.2,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? AppColors.yellow20
                          : Colors.transparent,
                      borderRadius: index == currentIndex
                          ? BorderRadius.circular(width * 0.06)
                          : BorderRadius.zero,
                    ),
                    child: Center(
                      child: Text(
                        data[index],
                        style: TextStyle(
                          color: index == currentIndex
                              ? AppColors.primaryYellow
                              : AppColors.grey,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class RecentTransactions extends StatelessWidget {
  final double width, height;
  final String transactionsTitle,
      seeAllTransactionsText,
      titleKey,
      descriptionKey,
      priceKey,
      timeKey,
      iconKey,
      iconColorKey,
      iconBackgroundColorKey;
  const RecentTransactions(
      {super.key,
      required this.width,
      required this.height,
      required this.transactionsTitle,
      required this.seeAllTransactionsText,
      required this.titleKey,
      required this.priceKey,
      required this.timeKey,
      required this.iconKey,
      required this.iconColorKey,
      required this.iconBackgroundColorKey,
      required this.descriptionKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transactionsTitle,
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: width * 0.2,
                height: height * 0.04,
                decoration: BoxDecoration(
                  color: AppColors.violet20,
                  borderRadius: BorderRadius.circular(width * 0.06),
                ),
                child: Center(
                  child: Text(
                    seeAllTransactionsText,
                    style: TextStyle(
                      color: AppColors.primaryViolet,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.5,
          width: width * 0.9,
          child: ListView.builder(
            itemCount: Database.todayExpenseDatabase.length,
            itemBuilder: (context, index) {
              return ExpenseItem(
                width: width,
                height: height,
                titleKey: titleKey,
                descriptionKey: descriptionKey,
                timeKey: timeKey,
                priceKey: priceKey,
                iconKey: iconKey,
                iconColorKey: iconColorKey,
                iconBackgroundColor: iconBackgroundColorKey,
                index: index,
                data: Database.todayExpenseDatabase,
              );
            },
          ),
        )
      ],
    );
  }
}

class FAB extends StatelessWidget {
  final VoidCallback onPressed;
  final double width, height;
  const FAB(
      {super.key,
      required this.onPressed,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.1)),
      backgroundColor: AppColors.primaryViolet,
      child: Transform.rotate(
        angle: 45 * 3.14 / 180,
        child: SvgPicture.asset(
          IconsPath.close,
          colorFilter: ColorFilter.mode(
            AppColors.primaryLight,
            BlendMode.srcIn,
          ),
          width: width * 0.1,
          height: width * 0.1,
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final double width, height;
  final List<Map<String, dynamic>> data;
  final String iconKey, titleKey;
  final Function(int index) updateIndex;
  final int currentIndex;
  const BottomNavigation(
      {super.key,
      required this.width,
      required this.height,
      required this.data,
      required this.iconKey,
      required this.titleKey,
      required this.updateIndex,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length ~/ 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 1 ? width * 0.08 : width * 0.01,
                    top: height * 0.005),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => updateIndex(index),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        data[index][iconKey],
                        colorFilter: ColorFilter.mode(
                            index == currentIndex
                                ? AppColors.primaryViolet
                                : AppColors.grey,
                            BlendMode.srcIn),
                        width: width * 0.08,
                        height: width * 0.08,
                      ),
                      SizedBox(
                        height: height * 0.004,
                      ),
                      Text(
                        data[index][titleKey],
                        style: TextStyle(
                          color: index == currentIndex
                              ? AppColors.primaryViolet
                              : AppColors.grey,
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: width * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length ~/ 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 2 ? width * 0.01 : width * 0.08,
                    top: height * 0.005),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => updateIndex(index + 2),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        data[index + 2][iconKey],
                        colorFilter: ColorFilter.mode(
                            index + 2 == currentIndex
                                ? AppColors.primaryViolet
                                : AppColors.grey,
                            BlendMode.srcIn),
                        width: width * 0.08,
                        height: width * 0.08,
                      ),
                      SizedBox(
                        height: height * 0.004,
                      ),
                      Text(
                        data[index + 2][titleKey],
                        style: TextStyle(
                          color: index + 2 == currentIndex
                              ? AppColors.primaryViolet
                              : AppColors.grey,
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
