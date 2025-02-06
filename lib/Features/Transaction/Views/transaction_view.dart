import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/user_transactions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TransactionView extends StackedView<TransactionViewModel> {
  const TransactionView({super.key});

  final String title = "Transactions";

  @override
  Widget builder(
      BuildContext context, TransactionViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          _TopNavigation(
            width: width,
            height: height,
          ),
          _SeeFinancialReport(
            width: width,
            height: height,
            navigationService: viewModel.navigationService,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.03,
              right: width * 0.6,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: UserTransactions(
              height: height * 0.62,
              icons: viewModel.transactionsService.transactionIcons(),
              transactions: viewModel.transactionsService.fetchTransactions(),
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

class _TopNavigation extends StatelessWidget {
  final double width, height;
  _TopNavigation({
    required this.width,
    required this.height,
  });

  final String monthText = "Month";
  final String dropDownArrow = IconsPath.dropdownArrow;
  final String filter = IconsPath.filter;

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
                    dropDownArrow,
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
                  monthText,
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
              _ShowFilter.bottomSheet(
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
                  filter,
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

class _ShowFilter {
  static const String title = "Filter Transaction";
  static const String resetButtonText = "Reset";
  static const String subtitleFilter = "Filter by";
  static const String subtitleSort = "Sort by";
  static const String subtitleCategory = "Category";
  static const String chooseCategory = "Choose Category";
  static const String selectedCategory = "0";
  static const String selectedText = "Selected";
  static const String buttonText = "Apply";
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
                          chooseCategory,
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
                                selectedCategory,
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
                                selectedText,
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
                    text: buttonText,
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

class _SeeFinancialReport extends StatelessWidget {
  final double width, height;
  final NavigationService navigationService;
  const _SeeFinancialReport(
      {required this.width,
      required this.height,
      required this.navigationService});

  final String report = "See your financial report.";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigationService.navigateToFinancialReportSummaryView(),
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
                colorFilter:
                    ColorFilter.mode(AppColors.primaryViolet, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
