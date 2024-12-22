import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// ignore: must_be_immutable
class AccountView extends StackedView<AccountViewModel> {
  AccountView({super.key});

  String appBarTitle = "Account";
  String accountBalanceTitle = "Account Balance";
  String walletPictureKey = "Picture";
  String walletNameKey = "Wallet";
  String walletBalanceKey = "Balance";
  String buttonText = " + Add new wallet";

  @override
  Widget builder(
      BuildContext context, AccountViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Column(
          children: [
            AccountBalance(
              width: width,
              height: height,
              accountBalanceTitle: accountBalanceTitle,
              balance: Variables.balance,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            AddedWallets(
              width: width,
              height: height,
              walletPictureKey: walletPictureKey,
              walletNameKey: walletNameKey,
              walletBalanceKey: walletBalanceKey,
              navigationService: viewModel.navigationService,
            ),
            SizedBox(
              height: height * 0.06,
            ),
            SizedBox(
              width: width * 0.9,
              height: height * 0.075,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: width * 0.045),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  AccountViewModel viewModelBuilder(BuildContext context) => AccountViewModel();
}

class AccountBalance extends StatelessWidget {
  final double width, height, balance;
  final String accountBalanceTitle;
  const AccountBalance(
      {super.key,
      required this.width,
      required this.height,
      required this.accountBalanceTitle,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SvgPicture.asset(
            IconsPath.accountBackground,
            width: double.infinity,
            height: height * 0.27,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            width: double.infinity,
            height: height * 0.27,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.04),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  accountBalanceTitle,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.035,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "\$${balance.ceil()}",
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.1,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class AddedWallets extends StatelessWidget {
  final double width, height;
  final String walletPictureKey, walletNameKey, walletBalanceKey;
  final NavigationService navigationService;
  const AddedWallets(
      {super.key,
      required this.width,
      required this.height,
      required this.walletPictureKey,
      required this.walletNameKey,
      required this.walletBalanceKey,
      required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      height: height * 0.4,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              navigationService.navigateToAccountDetails(
                  walletName: Database.walletOptions[index][walletNameKey],
                  walletBalance: Database.walletOptions[index]
                      [walletBalanceKey],
                  icon: Database.walletOptions[index][walletPictureKey]);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Database.walletOptions[index][walletPictureKey],
                        width: width * 0.04,
                        height: width * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Text(
                    Database.walletOptions[index][walletNameKey],
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "\$${Database.walletOptions[index][walletBalanceKey]}",
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: width * 0.001,
            color: AppColors.light20,
            height: height * 0.001,
          );
        },
        itemCount: Database.walletOptions.length,
      ),
    );
  }
}
