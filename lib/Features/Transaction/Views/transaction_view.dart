import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view_model.dart';
import 'package:montra_expense_tracker/Widgets/expense_item.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class TransactionView extends StackedView<TransactionViewModel> {
  TransactionView({super.key});

  String monthText = "Month";
  String report = "See your financial report.";
  String titleKey = "Category";
  String descriptionKey = "Description";
  String timeKey = "Time";
  String priceKey = "Expense";
  String iconKey = "Icon";
  String iconColorKey = "Icon-Color";
  String iconBackgroundColor = "Icon-Background";

  @override
  Widget builder(
      BuildContext context, TransactionViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          TopNavigation(
            width: width,
            height: height,
            monthIcon: IconsPath.dropdownArrow,
            filterIcon: IconsPath.filter,
            monthText: monthText,
          ),
          InkWell(
            onTap: () => viewModel.navigationService
                .navigateToFinancialReportSummaryView(),
            child: Container(
              width: width * 0.9,
              height: height * 0.06,
              decoration: BoxDecoration(
                color: AppColors.violet20,
                borderRadius: BorderRadius.circular(width * 0.02),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      report,
                      style: TextStyle(
                        color: AppColors.primaryViolet,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SvgPicture.asset(
                      IconsPath.rightArrow,
                      colorFilter: ColorFilter.mode(
                          AppColors.primaryViolet, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.03,
              right: width * 0.72,
            ),
            child: Text(
              "Today",
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Database.todayExpenseDatabase.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ExpenseItem(
                    width: width,
                    height: height,
                    titleKey: titleKey,
                    descriptionKey: descriptionKey,
                    timeKey: timeKey,
                    priceKey: priceKey,
                    iconKey: iconKey,
                    iconColorKey: iconColorKey,
                    iconBackgroundColor: iconBackgroundColor,
                    index: index,
                    data: Database.todayExpenseDatabase,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  TransactionViewModel viewModelBuilder(BuildContext context) =>
      TransactionViewModel();
}

class TopNavigation extends StatelessWidget {
  final double width, height;
  final String monthText, monthIcon, filterIcon;
  const TopNavigation(
      {super.key,
      required this.width,
      required this.height,
      required this.monthText,
      required this.monthIcon,
      required this.filterIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: width * 0.04,
        left: width * 0.04,
        top: height * 0.04,
        bottom: height * 0.02,
      ),
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
                  "Month",
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: width * 0.1,
            height: width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.03),
              border: Border.all(
                color: AppColors.light20,
                width: width * 0.002,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                IconsPath.filter,
                colorFilter:
                    ColorFilter.mode(AppColors.primaryBlack, BlendMode.srcIn),
                width: width * 0.06,
                height: width * 0.06,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
