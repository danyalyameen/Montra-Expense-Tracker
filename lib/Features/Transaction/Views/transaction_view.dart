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

  // Variables
  final String title = "This Month";

  @override
  Widget builder(
      BuildContext context, TransactionViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          // Top Navigation
          _TopNavigation(
            width: width,
            height: height,
          ),
          // Financial Report
          _SeeFinancialReport(
            width: width,
            height: height,
            navigationService: viewModel.navigationService,
          ),
          // User Transactions Text
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
          // User Transactions
          UserTransactions(
            height: height * 0.62,
            icons: viewModel.transactionsService.getTransactionIcons(),
            transactions: viewModel.transactionsService.getTransactions(),
            navigationService: viewModel.navigationService,
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

  // Variables
  final String appBarTitle = "Transactions";
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
        children: [
          // Filter
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
                // Filter Icon
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
          // For Spacing
          SizedBox(
            width: width * 0.2,
          ),
          // App Bar Title
          Center(
            child: Text(
              appBarTitle,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowFilter {
  // Variables
  static const String title = "Filter Transaction";
  static const String resetButtonText = "Reset";
  static const String subtitleFilter = "Filter by";
  static const String subtitleSort = "Sort by";
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
            maxHeight: height * 0.62,
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
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // Reset Button
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
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Filter by Text
                  Text(
                    subtitleFilter,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Filter By Options
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
                              // Text
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
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Sort By Text
                  Text(
                    subtitleSort,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Sort By Options
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
                              // Text
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
                  // For Spacing
                  SizedBox(
                    height: height * 0.04,
                  ),
                  // Category Text
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

  // Variables
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
              // Text
              Text(
                report,
                style: TextStyle(
                  color: AppColors.primaryViolet,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Arrow Icon
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
