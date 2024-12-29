import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
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
                  child: InkWell(
                    onTap: () {
                      viewModel.navigationService
                          .navigateToDetailsTransactionView(
                        balance: Database.todayExpenseDatabase[index][priceKey],
                        description: Database.todayExpenseDatabase[index]
                            [descriptionKey],
                        time: Database.todayExpenseDatabase[index][timeKey],
                        category: Database.todayExpenseDatabase[index]
                            [titleKey],
                        type: Database.todayExpenseDatabase[index][titleKey],
                        accountType: "Wallet",
                        color: AppColors.primaryRed,
                      );
                    },
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
          InkWell(
            borderRadius: BorderRadius.circular(width * 0.03),
            onTap: () {
              ShowFilter.bottomSheet(
                  context: context, width: width, height: height);
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}

class ShowFilter {
  static String title = "Filter Transaction";
  static String subtitleFilter = "Filter by";
  static String subtitleSort = "Sort by";
  static String subtitleCategory = "Category";
  static String buttonText = "Apply";
  static String resetButtonText = "Reset";
  static void bottomSheet({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BottomSheet(
          showDragHandle: true,
          dragHandleColor: AppColors.violet40,
          dragHandleSize: Size(width * 0.2, height * 0.005),
          backgroundColor: AppColors.primaryLight,
          enableDrag: false,
          constraints: BoxConstraints(
            maxHeight: height * 0.68,
            minWidth: width,
          ),
          onClosing: () {},
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w700,
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
                            resetButtonText,
                            style: TextStyle(
                              color: AppColors.primaryViolet,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    subtitleFilter,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: List.generate(
                      Database.filterbyData.length,
                      (index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            width: width * 0.26,
                            height: height * 0.06,
                            margin: index == 0
                                ? const EdgeInsets.all(0)
                                : EdgeInsets.only(left: width * 0.05),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.light40,
                                width: width * 0.004,
                              ),
                              borderRadius: BorderRadius.circular(width),
                            ),
                            child: Center(
                              child: Text(
                                Database.filterbyData[index],
                                style: TextStyle(
                                  color: AppColors.primaryBlack,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    subtitleSort,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: width * 0.04,
                    children: List.generate(
                      Database.sortbyData.length,
                      (index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            width: width * 0.26,
                            height: height * 0.06,
                            margin: index == 0 ||
                                    index == Database.sortbyData.length - 1
                                ? const EdgeInsets.all(0)
                                : EdgeInsets.only(left: width * 0.05),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.light40,
                                width: width * 0.004,
                              ),
                              borderRadius: BorderRadius.circular(width),
                            ),
                            child: Center(
                              child: Text(
                                Database.sortbyData[index],
                                style: TextStyle(
                                  color: AppColors.primaryBlack,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    subtitleCategory,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Category",
                          style: TextStyle(
                            color: AppColors.black75,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.25,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "0",
                                style: TextStyle(
                                  color: AppColors.black50,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "Selected",
                                style: TextStyle(
                                  color: AppColors.black50,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.06,
                                height: width * 0.06,
                                child: SvgPicture.asset(
                                  IconsPath.rightArrow,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.primaryViolet, BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomElevatedButton(
                    width: width,
                    height: height,
                    text: "Apply",
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
