import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view_model.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class BudgetView extends StackedView<BudgetViewModel> {
  const BudgetView({super.key});

  // Variables
  final String buttonText = "Create a budget";

  @override
  void onViewModelReady(BudgetViewModel viewModel) {
    viewModel.index = DateTime.now().month - 1;
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, BudgetViewModel viewModel, Widget? child) {
    // Get Screen Size of a Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryViolet,
      appBar: whiteAppBar(
        toolBarHight: height * 0.12,
        backgroundColor: AppColors.primaryViolet,
        // Months
        title: Database.months[viewModel.index],
        width: width,
        height: height,
        // Months Decrement
        leading: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(width * 0.06),
            onTap: () {
              viewModel.decrementIndex();
            },
            child: SvgPicture.asset(
              IconsPath.leftArrow,
              width: width * 0.05,
              height: height * 0.05,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
            ),
          ),
        ),
        // Months Increment
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: InkWell(
              borderRadius: BorderRadius.circular(width * 0.08),
              onTap: () {
                viewModel.incrementIndex();
              },
              child: SvgPicture.asset(
                IconsPath.rightArrow,
                width: width * 0.05,
                height: height * 0.05,
                colorFilter:
                    ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      // Background Container
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.06),
            topRight: Radius.circular(width * 0.06),
          ),
        ),
        child: Column(
          children: [
            // Budgets
            Expanded(
              child: _BudgetItemUI(
                height: height,
                width: width,
              ),
            ),
            // Create Budget
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.05),
              child: CustomElevatedButton(
                width: width,
                height: height,
                text: buttonText,
                onPressed: () {
                  viewModel.navigationService.navigateToCreateBudgetView();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  BudgetViewModel viewModelBuilder(BuildContext context) => BudgetViewModel();
}

class _BudgetItemUI extends ViewModelWidget<BudgetViewModel> {
  final double width, height;
  const _BudgetItemUI({
    required this.width,
    required this.height,
  });

  // Variables
  final String titleOnEmptyList =
      "You don't have a budget. \n Let's make one so you in control.";
  final String warning = "You've exceed the limit";

  @override
  Widget build(BuildContext context, BudgetViewModel viewModel) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    return FutureBuilder(
      future: viewModel.budgetService.fetchBudget(month: viewModel.index + 1),
      builder: (context, budgets) {
        // Loading State
        if (budgets.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: List.generate(
                2,
                (index) {
                  return Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: width * 0.9,
                        height: height * 0.24,
                        decoration: BoxDecoration(
                          color: AppColors.light80,
                          borderRadius: BorderRadius.circular(width * 0.06),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        // Empty Data State
        if (budgets.data!.isEmpty) {
          return Center(
            child: Text(
              titleOnEmptyList,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        } else {
          // Non Empty State
          return ListView.builder(
            itemCount: budgets.data!.length,
            itemBuilder: (context, itemIndex) {
              final budget = budgets.data![itemIndex];
              // Fetching whole month spend
              return FutureBuilder(
                future: Future.wait([
                  viewModel.budgetService.spend(
                    category: budget.category!,
                    month: viewModel.index + 1,
                  ),
                  viewModel.budgetService.getBudgetIcons(
                    month: viewModel.index + 1,
                  )
                ]),
                builder: (context, snapshot) {
                  // Loading State
                  if (budgets.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        children: List.generate(
                          2,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(top: height * 0.02),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: width * 0.9,
                                  height: height * 0.24,
                                  decoration: BoxDecoration(
                                    color: AppColors.light80,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.06),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  // If spend Data is Not Null
                  if (snapshot.data?[1] != null) {
                    var spend = snapshot.data![0] as int;
                    var icons = snapshot.data![1] as List<Map<String, dynamic>>;
                    var icon = icons[itemIndex]["icon"];
                    return Padding(
                      padding: EdgeInsets.only(
                        top: itemIndex == 0 ? height * 0.04 : height * 0.02,
                        bottom: height * 0.02,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: width * 0.9,
                          height: spend > budget.balance!
                              ? height * 0.24
                              : height * 0.2,
                          child: InkWell(
                            onTap: () async {
                              await viewModel.navigationService
                                  .navigateToEditBudgetView(
                                color: Color(int.parse(budget.color!)),
                                category: budget.category!,
                                spendBalance: spend,
                                limitBalance: budget.balance!,
                                backgroundColor: Color(int.parse(budget.color!))
                                    .withAlpha(20),
                                icon: icon,
                                iconColor: Color(int.parse(budget.color!)),
                                index: itemIndex,
                                month: viewModel.index + 1,
                              );
                              viewModel.notifyListeners();
                            },
                            child: Card(
                              color: AppColors.light80,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.06),
                              ),
                              elevation: width * 0.002,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top Things like Category and Warning Signs
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.02,
                                      left: width * 0.04,
                                      right: width * 0.04,
                                      bottom: height * 0.01,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Category
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: width * 0.001,
                                              color: AppColors.primaryBlack,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                width * 0.04),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: width * 0.001,
                                                horizontal: width * 0.03),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                // Circle Color
                                                SizedBox(
                                                  width: width * 0.035,
                                                  height: height * 0.035,
                                                  child: CircleAvatar(
                                                    backgroundColor: Color(
                                                      int.parse(
                                                        budget.color!,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // For Spacing
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                // Category
                                                Text(
                                                  budget.category!,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryBlack,
                                                    fontSize: width * 0.038,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Warning
                                        spend > budget.balance!
                                            ? SvgPicture.asset(
                                                IconsPath.warning,
                                                colorFilter: ColorFilter.mode(
                                                    AppColors.primaryRed,
                                                    BlendMode.srcIn),
                                              )
                                            : const Spacer(),
                                      ],
                                    ),
                                  ),
                                  // Budget Balance
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.04),
                                    child: Text(
                                      spend > budget.balance!
                                          ? "Remaining ${currencyProvider.currency}0"
                                          : "Remaining ${currencyProvider.currency}${budget.balance! - spend}",
                                      style: TextStyle(
                                        color: AppColors.primaryBlack,
                                        fontSize: width * 0.06,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  // For Spacing
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  // Progress Bar
                                  Center(
                                    child: SizedBox(
                                      width: width * 0.8,
                                      child: Stack(
                                        children: [
                                          // Back Color Means Light Back Color
                                          Container(
                                            width: width * 0.8,
                                            height: height * 0.018,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.06),
                                              color: AppColors.light40,
                                            ),
                                          ),
                                          // Progress Bar
                                          Container(
                                            width: width *
                                                0.8 *
                                                viewModel.percentage(
                                                  index: itemIndex,
                                                  spend: spend,
                                                  limit: budget.balance!,
                                                ),
                                            height: height * 0.018,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.06),
                                              color: Color(
                                                int.parse(budget.color!),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Spend
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.01, left: width * 0.04),
                                    child: Text(
                                      "${currencyProvider.currency}$spend of ${currencyProvider.currency}${budget.balance}",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: width * 0.045,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  // Warning
                                  spend > budget.balance!
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.04,
                                              top: height * 0.01),
                                          child: Text(
                                            warning,
                                            style: TextStyle(
                                                color: AppColors.primaryRed,
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      : const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
