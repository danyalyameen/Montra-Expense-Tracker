import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view_model.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BudgetView extends StackedView<BudgetViewModel> {
  const BudgetView({super.key});

  final String buttonText = "Create a budget";

  @override
  Widget builder(
      BuildContext context, BudgetViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryViolet,
      appBar: whiteAppBar(
        toolBarHight: height * 0.12,
        backgroundColor: AppColors.primaryViolet,
        title: Database.months[viewModel.index],
        width: width,
        height: height,
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
            Expanded(
              child: _BudgetItemUI(
                height: height,
                width: width,
                data: viewModel.budgetService.fetchBudget(),
                navigationService: viewModel.navigationService,
              ),
            ),
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
  final NavigationService navigationService;
  final Future<List<Budget>> data;
  const _BudgetItemUI({
    required this.data,
    required this.width,
    required this.height,
    required this.navigationService,
  });

  final String titleOnEmptyList =
      "You don't have a budget. \n Let's make one so you in control.";
  final String warning = "You've exceed the limit";

  @override
  Widget build(BuildContext context, BudgetViewModel viewModel) {
    return FutureBuilder(
      future: data,
      builder: (context, budgets) {
        if (budgets.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryViolet,
            ),
          );
        }
        if (budgets.data == null) {
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
          return ListView.builder(
            itemCount: budgets.data!.length,
            itemBuilder: (context, index) {
              final budget = budgets.data![index];
              return FutureBuilder(
                future: viewModel.budgetService.spend(
                  category: budget.category!,
                  month: viewModel.index + 1,
                ),
                builder: (context, spend) {
                  if (budgets.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryViolet,
                      ),
                    );
                  }
                  if (spend.data != null) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? height * 0.04 : height * 0.02,
                        bottom: height * 0.02,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: width * 0.9,
                          height: spend.data! > budget.balance!
                              ? height * 0.24
                              : height * 0.2,
                          child: InkWell(
                            onTap: () {
                              // navigationService.navigateToEditBudgetView(
                              //     color: data[index][colorKey],
                              //     category: data[index][categoryKey],
                              //     spendBalance: data[index][spendKey],
                              //     limitBalance: data[index][limitKey],
                              //     backgroundColor: data[index]
                              //         [iconBackgroundColorKey],
                              //     icon: data[index][iconKey],
                              //     iconColor: data[index][iconColorKey]);
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
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
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
                                        spend.data! > budget.balance!
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
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.04),
                                    child: Text(
                                      spend.data! > budget.balance!
                                          ? "Remaining \$0"
                                          : "Remaining \$${budget.balance! - spend.data!}",
                                      style: TextStyle(
                                        color: AppColors.primaryBlack,
                                        fontSize: width * 0.06,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: width * 0.8,
                                      child: Stack(
                                        children: [
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
                                          Container(
                                            width: width *
                                                0.8 *
                                                viewModel.percentage(
                                                    index: index,
                                                    spend: spend.data!,
                                                    limit: budget.balance!),
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.01, left: width * 0.04),
                                    child: Text(
                                      "\$${spend.data} of \$${budget.balance}",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: width * 0.045,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  spend.data! > budget.balance!
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
