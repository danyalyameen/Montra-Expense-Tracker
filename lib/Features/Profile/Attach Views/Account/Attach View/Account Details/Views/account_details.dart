import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/expense_item.dart';
import 'package:stacked/stacked.dart';

class AccountDetails extends StackedView<AccountDetailsViewModel> {
  final String walletName, icon;
  final int walletBalance;
  const AccountDetails(this.walletName, this.walletBalance, this.icon,
      {super.key});

  final String appBarTitle = "Account Details";
  final String titleKey = "Category";
  final String descriptionKey = "Description";
  final String timeKey = "Time";
  final String priceKey = "Expense";
  final String iconKey = "Icon";
  final String iconColorKey = "Icon-Color";
  final String iconBackgroundColor = "Icon-Background";

  @override
  Widget builder(
      BuildContext context, AccountDetailsViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () {
          viewModel.navigationService.back();
        },
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: SvgPicture.asset(
              IconsPath.edit,
              width: width * 0.07,
              height: width * 0.07,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.06),
          child: Column(
            children: [
              _WalletDetails(
                width: width,
                height: height,
                icon: icon,
                walletBalance: walletBalance,
                walletName: walletName,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    right: width * 0.72,
                    bottom: height * 0.01),
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
        ),
      ),
    );
  }

  @override
  AccountDetailsViewModel viewModelBuilder(BuildContext context) =>
      AccountDetailsViewModel();
}

class _WalletDetails extends StatelessWidget {
  final double width, height;
  final String icon, walletName;
  final int walletBalance;
  const _WalletDetails(
      {required this.width,
      required this.height,
      required this.icon,
      required this.walletName,
      required this.walletBalance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width * 0.12,
          height: width * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.04),
            color: AppColors.walletIconBackgroundColorProfile,
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: width * 0.04,
              height: width * 0.04,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          walletName,
          style: TextStyle(
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.w600,
              fontSize: width * 0.055),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          "\$$walletBalance",
          style: TextStyle(
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.w700,
              fontSize: width * 0.07),
        )
      ],
    );
  }
}
