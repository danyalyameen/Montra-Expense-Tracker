import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details_view_model.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class AccountDetails extends StackedView<AccountDetailsViewModel> {
  final String walletName, icon;
  final int walletBalance;
  AccountDetails(this.walletName, this.walletBalance, this.icon, {super.key});

  String appBarTitle = "Account Details";

  @override
  Widget builder(
      BuildContext context, AccountDetailsViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: width * 0.05,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: Center(
          child: SizedBox(
            width: width * 0.07,
            height: width * 0.07,
            child: InkWell(
                onTap: () {
                  viewModel.navigationService.back();
                },
                child: SvgPicture.asset(IconsPath.backArrow)),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: SizedBox(
              width: width * 0.07,
              height: width * 0.07,
              child: SvgPicture.asset(IconsPath.edit),
            ),
          )
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
