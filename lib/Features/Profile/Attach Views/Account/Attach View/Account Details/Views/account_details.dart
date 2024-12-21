import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class AccountDetails extends StackedView<AccountDetailsViewModel> {
  final String walletName, icon;
  final int walletBalance;
  AccountDetails(this.walletName, this.walletBalance, this.icon, {super.key});

  String appBarTitle = "Account Details";
  String titleKey = "Category";
  String descriptionKey = "Description";
  String timeKey = "Time";
  String priceKey = "Expense";
  String iconKey = "Icon";
  String iconColorKey = "Icon-Color";
  String iconBackgroundColor = "Icon-Background";

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
              WalletDetails(
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
              ExpensesList(
                width: width,
                height: height,
                titleKey: titleKey,
                descriptionKey: descriptionKey,
                timeKey: timeKey,
                priceKey: priceKey,
                iconKey: iconKey,
                iconColorKey: iconColorKey,
                iconBackgroundColor: iconBackgroundColor,
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

class WalletDetails extends StatelessWidget {
  final double width, height;
  final String icon, walletName;
  final int walletBalance;
  const WalletDetails(
      {super.key,
      required this.width,
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
              color: AppColors.light20,
              borderRadius: BorderRadius.circular(width * 0.04)),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: width * 0.06,
              height: width * 0.06,
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

class ExpensesList extends StatelessWidget {
  final double width, height;
  final String titleKey,
      descriptionKey,
      timeKey,
      priceKey,
      iconKey,
      iconColorKey,
      iconBackgroundColor;
  const ExpensesList(
      {super.key,
      required this.width,
      required this.height,
      required this.titleKey,
      required this.descriptionKey,
      required this.timeKey,
      required this.priceKey,
      required this.iconKey,
      required this.iconColorKey,
      required this.iconBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: Database.todayExpenseDatabase.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: height * 0.01),
              width: width * 0.9,
              height: height * 0.1,
              decoration: BoxDecoration(
                color: AppColors.light80,
                borderRadius: BorderRadius.circular(width * 0.04),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Container(
                      width: width * 0.15,
                      height: width * 0.15,
                      decoration: BoxDecoration(
                        color: Database.todayExpenseDatabase[index]
                            [iconBackgroundColor],
                        borderRadius: BorderRadius.circular(width * 0.04),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Database.todayExpenseDatabase[index][iconKey],
                          colorFilter: ColorFilter.mode(
                              Database.todayExpenseDatabase[index]
                                  [iconColorKey],
                              BlendMode.srcIn),
                          width: width * 0.09,
                          height: width * 0.09,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.02, left: width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Database.todayExpenseDatabase[index][titleKey],
                          style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: width * 0.042,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.002,
                        ),
                        Text(
                          Database.todayExpenseDatabase[index][descriptionKey]
                                      .length >
                                  20
                              ? Database.todayExpenseDatabase[index]
                                          [descriptionKey]
                                      .substring(0, 20) +
                                  "..."
                              : Database.todayExpenseDatabase[index]
                                  [descriptionKey],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.04, top: height * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Database.todayExpenseDatabase[index][priceKey],
                          style: TextStyle(
                            color: AppColors.primaryRed,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          Database.todayExpenseDatabase[index][timeKey],
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: width * 0.032,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
