import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view_model.dart';
import 'package:montra_expense_tracker/Widgets/user_transactions.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  void onViewModelReady(DashboardViewModel viewModel) {
    // Change Notification Bar Color
    viewModel.notificationBarService.blackNotificationBar();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, DashboardViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // Navigation of Different UIs
      body: Stack(
        children: [
          Database
              .bottomNavigationViews[viewModel.currentIndexForBottomNavigation],
          // Show or Hide the Three Items
          _ShowOrHide(
            width: width,
            height: height,
            navigationService: viewModel.navigationService,
          ),
        ],
      ),
      // Floating Action Button Location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Floating Action Button
      floatingActionButton: _FAB(
        width: width,
        height: height,
        onPressed: () {
          viewModel.showOrHideItems();
        },
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        height: height * 0.0956,
        child: _BottomNavigation(
          width: width,
          height: height,
        ),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();
}

class DashboardUI extends ViewModelWidget<DashboardViewModel> {
  const DashboardUI({super.key});

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Background Gradient
        Container(
          height: height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.customColorBrown,
                AppColors.customColorWhite.withValues(alpha: 0),
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
              // Top Navigation
              _TopNavigation(
                height: height,
                width: width,
                navigationNotification: viewModel.notificationNavigation,
              ),
              // For Spacing
              SizedBox(
                height: height * 0.01,
              ),
              // Account Details like Balance
              _ShowAcccount(
                height: height,
                width: width,
              ),
              // For Spacing
              SizedBox(
                height: height * 0.03,
              ),
              // Recent Transactions
              _RecentTransactions(
                width: width,
                height: height,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopNavigation extends ViewModelWidget<DashboardViewModel> {
  final double height, width;
  final Function navigationNotification;
  const _TopNavigation({
    required this.height,
    required this.width,
    required this.navigationNotification,
  });

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Account Picture
          FutureBuilder(
              future: Future.wait([
                precacheImage(
                    NetworkImage(
                      viewModel.imageService.getImage(
                        userPicture: true,
                        imageName: Variables.userPictureName,
                      ),
                    ),
                    context),
                viewModel.getFirstLetterOfName()
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.light80,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: width * 0.008,
                          color: AppColors.violet60,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryViolet,
                        radius: width * 0.04,
                      ),
                    ),
                  );
                }
                // First Letter of Name
                var data = snapshot.data![1] as String;
                return Container(
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
                      // User Image
                      backgroundImage: NetworkImage(
                        viewModel.imageService.getImage(
                          userPicture: true,
                          imageName: Variables.userPictureName,
                        ),
                      ),
                      child: viewModel.imageError
                          ? ClipOval(
                              child: Container(
                                color: AppColors.primaryViolet,
                                child: Center(
                                  child: Text(
                                    data,
                                    style: TextStyle(
                                      color: AppColors.primaryLight,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null,
                      // Show First Letter Incase of No Profile Picture
                      onBackgroundImageError: (exception, stackTrace) {
                        viewModel.imageError = true;
                        viewModel.notifyListeners();
                      },
                    ),
                  ),
                );
              }),
          // Screen Name
          Text(
            "Dashboard",
            style: TextStyle(
              color: AppColors.primaryBlack,
              fontSize: width * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Notification
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(width),
              onTap: () => navigationNotification(),
              child: SvgPicture.asset(
                IconsPath.notification,
                width: width * 0.08,
                height: width * 0.08,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryViolet,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ShowAcccount extends ViewModelWidget<DashboardViewModel> {
  final double height, width;
  const _ShowAcccount({
    required this.height,
    required this.width,
  });

  // Variables
  final String accountTitle = "Account Balance";
  final String incomeText = "Income";
  final String expenseText = "Expense";

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Column(
      children: [
        // Title
        Text(
          accountTitle,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Balance
        FutureBuilder(
          future: viewModel.getBalance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loading Effect
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: width * 0.3,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                ),
              );
            }
            // Balance
            return Text(
              "${Variables.currency}${snapshot.data}",
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: width * 0.12,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Income and Expense
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Income Background Color
              FutureBuilder(
                future: viewModel.getTotalIncome(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Loading Effect
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: width * 0.425,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(width * 0.06),
                        ),
                      ),
                    );
                  }
                  return Container(
                    width: width * 0.425,
                    height: height * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(width * 0.06),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Income Icon
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
                        // For Spacing
                        SizedBox(
                          width: width * 0.02,
                        ),
                        // Income Text and Balance
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Income Text
                            Text(
                              incomeText,
                              style: TextStyle(
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.035,
                              ),
                            ),
                            // For Spacing
                            SizedBox(
                              height: height * 0.005,
                            ),
                            // Income Balance
                            Text(
                              "${Variables.currency}${snapshot.data}",
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
                  );
                },
              ),
              // For Spacing
              SizedBox(
                width: width * 0.05,
              ),
              // Expense Background Color
              FutureBuilder(
                future: viewModel.getTotalExpense(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Loading Effect
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: width * 0.425,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(width * 0.06),
                        ),
                      ),
                    );
                  } else {
                    // Background Red Container
                    return Container(
                      width: width * 0.425,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.primaryRed,
                        borderRadius: BorderRadius.circular(width * 0.06),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Expense Icon
                          Container(
                            width: width * 0.135,
                            height: width * 0.135,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(width * 0.04),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                IconsPath.expense,
                                width: width * 0.08,
                                height: width * 0.08,
                                colorFilter: ColorFilter.mode(
                                  AppColors.primaryRed,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          // For Spacing
                          SizedBox(
                            width: width * 0.02,
                          ),
                          // Expense Text and Balance
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Expense Text
                              Text(
                                expenseText,
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.w400,
                                  fontSize: width * 0.035,
                                ),
                              ),
                              // For Spacing
                              SizedBox(
                                height: height * 0.005,
                              ),
                              // Expense Balance
                              Text(
                                "${Variables.currency}${snapshot.data}",
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
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _RecentTransactions extends ViewModelWidget<DashboardViewModel> {
  final double width, height;
  const _RecentTransactions({
    required this.width,
    required this.height,
  });

  // Variables
  final String transactionsTitle = "Recent Transactions";
  final String seeAllTransactionsText = "See All";

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Transactions Title
              Text(
                transactionsTitle,
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // See All Button
              InkWell(
                onTap: () {
                  viewModel.currentIndexForBottomNavigation = 1;
                  viewModel.notifyListeners();
                },
                child: Container(
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
              ),
            ],
          ),
        ),
        // Transactions
        UserTransactions(
          itemCount: 4,
          transactions: viewModel.transactionsService.getTransactions(),
          icons: viewModel.transactionsService.getTransactionIcons(),
          navigationService: viewModel.navigationService,
        ),
      ],
    );
  }
}

class _FAB extends StatelessWidget {
  final VoidCallback onPressed;
  final double width, height;
  const _FAB(
      {required this.onPressed, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    // Floating Action Button
    return FloatingActionButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.1)),
      backgroundColor: AppColors.primaryViolet,
      // Icon
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

class _ShowOrHide extends ViewModelWidget<DashboardViewModel> {
  final double width, height;
  final NavigationService navigationService;
  const _ShowOrHide(
      {required this.navigationService,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return ValueListenableBuilder(
      valueListenable: viewModel.showItems,
      builder: (context, value, child) {
        return value
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  // Gradient
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryViolet.withValues(alpha: 0.45),
                      AppColors.primaryViolet.withValues(alpha: 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.68),
                  child: Column(
                    children: [
                      // Transfer View Widget Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              viewModel.showItems.value = false;
                              await navigationService.navigateToTransferView();
                              viewModel.notifyListeners();
                            },
                            child: CircleAvatar(
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
                            ),
                          )
                        ],
                      ),
                      // For Spacing
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // Income View Widget Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              navigationService.navigateToIncomeView();
                              viewModel.showItems.value = false;
                            },
                            child: CircleAvatar(
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
                          ),
                          // For Spacing
                          SizedBox(
                            width: width * 0.25,
                          ),
                          // Expense View Widget Icon
                          InkWell(
                            onTap: () {
                              navigationService.navigateToExpenseView();
                              viewModel.showItems.value = false;
                            },
                            child: CircleAvatar(
                              radius: width * 0.07,
                              backgroundColor: AppColors.primaryRed,
                              child: SvgPicture.asset(
                                IconsPath.expense,
                                width: width * 0.09,
                                height: width * 0.09,
                                colorFilter: ColorFilter.mode(
                                    AppColors.primaryLight, BlendMode.srcIn),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class _BottomNavigation extends ViewModelWidget<DashboardViewModel> {
  final double width, height;
  _BottomNavigation({
    required this.width,
    required this.height,
  });

  // Variables
  final String iconKey = "Icon";
  final String titleKey = "Title";
  final List<Map<String, dynamic>> data = Database.bottomNavigationData;
  final List viewsData = Database.bottomNavigationViews;

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Bottom Navigation First Half Icons
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
                  onTap: () {
                    viewModel.updateIndexForBottomNavigation(index);
                  },
                  child: Column(
                    children: [
                      // Icon
                      SvgPicture.asset(
                        data[index][iconKey],
                        colorFilter: ColorFilter.mode(
                            index == viewModel.currentIndexForBottomNavigation
                                ? AppColors.primaryViolet
                                : AppColors.grey,
                            BlendMode.srcIn),
                        width: width * 0.08,
                        height: width * 0.08,
                      ),
                      // For Spacing
                      SizedBox(
                        height: height * 0.004,
                      ),
                      // Title
                      Text(
                        data[index][titleKey],
                        style: TextStyle(
                          color:
                              index == viewModel.currentIndexForBottomNavigation
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
        // Bottom Navigation Second Half Icons
        SizedBox(
          width: width * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length ~/ 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 2 ? width * 0.012 : width * 0.08,
                    top: index == 0 ? height * 0.012 : height * 0.005),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    viewModel.updateIndexForBottomNavigation(index + 2);
                  },
                  child: Column(
                    children: [
                      // Icon
                      SvgPicture.asset(
                        data[index + 2][iconKey],
                        colorFilter: ColorFilter.mode(
                            index + 2 ==
                                    viewModel.currentIndexForBottomNavigation
                                ? AppColors.primaryViolet
                                : AppColors.grey,
                            BlendMode.srcIn),
                        width: index == 0 ? width * 0.06 : width * 0.08,
                        height: index == 0 ? width * 0.06 : width * 0.08,
                      ),
                      // For Spacing
                      SizedBox(
                        height: height * 0.004,
                      ),
                      // Title
                      Text(
                        data[index + 2][titleKey],
                        style: TextStyle(
                          color: index + 2 ==
                                  viewModel.currentIndexForBottomNavigation
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
