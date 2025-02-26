import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details_view_model.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/delete_sheet.dart';
import 'package:montra_expense_tracker/Widgets/user_transactions.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class AccountDetails extends StackedView<AccountDetailsViewModel> {
  final String walletName, icon;
  final int walletBalance;
  const AccountDetails(this.walletName, this.walletBalance, this.icon,
      {super.key});

  // Variables
  final String appBarTitle = "Account Details";

  @override
  Widget builder(
      BuildContext context, AccountDetailsViewModel viewModel, Widget? child) {
    // Get Screen Size of a Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
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
            child: InkWell(
              onTap: () {
                Delete.showSheet(
                  context: context,
                  width: width,
                  height: height * 0.8,
                  title: "Delete Wallet",
                  subtitle: "Are you sure you want to delete this wallet?",
                  onPressed: () async {
                    viewModel.walletService.deleteWallet(name: walletName);
                    viewModel.navigationService.back();
                    await Future.delayed(const Duration(seconds: 2));
                    viewModel.navigationService.back();
                  },
                );
              },
              child: SvgPicture.asset(
                IconsPath.delete,
                width: width * 0.07,
                height: width * 0.07,
                colorFilter:
                    ColorFilter.mode(AppColors.primaryRed, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.06),
          child: Column(
            children: [
              // Wallet Details
              _WalletDetails(
                width: width,
                height: height,
                icon: icon,
                walletBalance: walletBalance,
                walletName: walletName,
              ),
              // User Transactions Title
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.03,
                  right: width * 0.6,
                  bottom: height * 0.01,
                ),
                child: Text(
                  "This Month",
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // User Transactions
              UserTransactions(
                icons: viewModel.walletService
                    .getWalletTransactionsIcons(walletName: walletName),
                transactions: viewModel.walletService
                    .getWalletTransactions(walletName: walletName),
                navigationService: viewModel.navigationService,
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
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    return Column(
      children: [
        // Wallet Icon
        Container(
          width: width * 0.12,
          height: width * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.04),
            color: AppColors.violet20,
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: width * 0.06,
              height: width * 0.06,
              colorFilter: ColorFilter.mode(
                AppColors.primaryViolet,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Wallet Name
        Text(
          walletName,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.055,
          ),
        ),
        // For Spacing
        SizedBox(
          height: height * 0.01,
        ),
        // Wallet Balance
        Text(
          "${currencyProvider.currency}$walletBalance",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.w700,
            fontSize: width * 0.07,
          ),
        )
      ],
    );
  }
}
