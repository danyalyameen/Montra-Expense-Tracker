import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
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
            icons: viewModel.isApply
                ? viewModel.transactionsService.getTransactionIcons(
                    userTransactions: viewModel.sortTransactions)
                : viewModel.transactionsService.getTransactionIcons(),
            transactions: viewModel.isApply
                ? viewModel.filter()
                : viewModel.transactionsService.getTransactions(),
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

class _TopNavigation extends ViewModelWidget<TransactionViewModel> {
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
  Widget build(BuildContext context, TransactionViewModel viewModel) {
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
              // Open Bottom Sheet
              _ShowFilter.bottomSheet(
                context: context,
                width: width,
                height: height,
                onFilterChanged: (value) {
                  viewModel.onChangeFilter(value);
                },
                onSortChanged: (value) {
                  viewModel.onChangeSort(value);
                },
                onApply: () async {
                  await viewModel.filter();
                  viewModel.notifyListeners();
                },
              );
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
  static String selectedFilter = Database.sortbyData[0];
  static String selectedSort = Database.sortbyData[0];
  static ValueNotifier<bool> showLoading = ValueNotifier(false);
  // Bottom Sheet Function
  static Future<void> bottomSheet({
    required BuildContext context,
    required double width,
    required double height,
    required void Function(String value) onFilterChanged,
    required void Function(String value) onSortChanged,
    required VoidCallback? onApply,
  }) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                          InkWell(
                            borderRadius: BorderRadius.circular(width * 0.06),
                            onTap: () {
                              setState(
                                () {
                                  selectedFilter = "";
                                  onFilterChanged(selectedFilter);
                                  onSortChanged(Database.sortbyData[2]);
                                },
                              );
                            },
                            child: Container(
                              width: width * 0.2,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                color: AppColors.violet20,
                                borderRadius:
                                    BorderRadius.circular(width * 0.06),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        spacing: width * 0.04,
                        children: List.generate(
                          Database.filterbyData.length,
                          (index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(width),
                              onTap: () {
                                // Select Filter and store its value
                                setState(() {
                                  selectedFilter = Database.filterbyData[index];
                                  onFilterChanged(selectedFilter);
                                });
                              },
                              child: Container(
                                width: width * 0.26,
                                height: height * 0.06,
                                decoration: BoxDecoration(
                                  color: selectedFilter ==
                                          Database.filterbyData[index]
                                      ? AppColors.violet20
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: selectedFilter ==
                                            Database.filterbyData[index]
                                        ? AppColors.primaryViolet
                                        : AppColors.light40,
                                    width: width * 0.004,
                                  ),
                                  borderRadius: BorderRadius.circular(width),
                                ),
                                child: Center(
                                  // Text
                                  child: Text(
                                    Database.filterbyData[index],
                                    style: TextStyle(
                                      color: selectedFilter ==
                                              Database.filterbyData[index]
                                          ? AppColors.primaryViolet
                                          : AppColors.primaryBlack,
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
                        spacing: width * 0.04,
                        children: List.generate(
                          Database.sortbyData.length,
                          (index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(width),
                              onTap: () {
                                // Store Sort Value and Update UI
                                setState(
                                  () {
                                    selectedSort = Database.sortbyData[index];
                                    onSortChanged(selectedSort);
                                  },
                                );
                              },
                              child: Container(
                                width: width * 0.26,
                                height: height * 0.06,
                                decoration: BoxDecoration(
                                  color:
                                      selectedSort == Database.sortbyData[index]
                                          ? AppColors.violet20
                                          : Colors.transparent,
                                  border: Border.all(
                                    color: selectedSort ==
                                            Database.sortbyData[index]
                                        ? AppColors.primaryViolet
                                        : AppColors.light40,
                                    width: width * 0.004,
                                  ),
                                  borderRadius: BorderRadius.circular(width),
                                ),
                                child: Center(
                                  // Text
                                  child: Text(
                                    Database.sortbyData[index],
                                    style: TextStyle(
                                      color: selectedSort ==
                                              Database.sortbyData[index]
                                          ? AppColors.primaryViolet
                                          : AppColors.primaryBlack,
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
                      // Apply Button
                      ValueListenableBuilder(
                        valueListenable: showLoading,
                        builder: (context, value, child) {
                          return CustomElevatedButton(
                            width: width,
                            height: height,
                            backgroundColor: value
                                ? AppColors.violet20
                                : AppColors.primaryViolet,
                            onPressed: () async {
                              showLoading.value = true;
                              onApply!.call();
                              showLoading.value = false;
                              locator<NavigationService>().back();
                            },
                            child: value
                                ? SpinKitThreeBounce(
                                    color: AppColors.primaryViolet,
                                    size: width * 0.06,
                                  )
                                : Text(
                                    buttonText,
                                    style: TextStyle(
                                      color: AppColors.primaryLight,
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
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
