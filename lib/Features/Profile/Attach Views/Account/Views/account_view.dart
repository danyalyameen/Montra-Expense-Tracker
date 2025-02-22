import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountView extends StackedView<AccountViewModel> {
  const AccountView({super.key});

  // Variables
  final String appBarTitle = "Account";
  final String buttonText = " + Add new wallet";

  @override
  Widget builder(
      BuildContext context, AccountViewModel viewModel, Widget? child) {
    // Get Screen Size of a Device
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
            // Account Balance
            _AccountBalance(
              width: width,
              height: height,
            ),
            // For Spacing
            SizedBox(
              height: height * 0.04,
            ),
            _AddedWallets(
              width: width,
              height: height,
              navigationService: viewModel.navigationService,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            // Elevated Button
            SizedBox(
              width: width * 0.9,
              height: height * 0.075,
              child: CustomElevatedButton(
                width: width,
                height: height,
                text: buttonText,
                onPressed: () {
                  viewModel.navigationService.navigateToSetupWalletView();
                },
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

class _AccountBalance extends ViewModelWidget<AccountViewModel> {
  final double width, height;
  const _AccountBalance({
    required this.width,
    required this.height,
  });

  // Variables
  final String accountBalanceTitle = "Account Balance";
  final String balance = "0";

  @override
  Widget build(BuildContext context, AccountViewModel viewModel) {
    return Stack(
      children: [
        // Background
        Center(
          child: SvgPicture.asset(
            IconsPath.accountBackground,
            width: double.infinity,
            height: height * 0.27,
          ),
        ),
        // Account Balance
        FutureBuilder(
          future: viewModel.getBalance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.08,
                    margin: EdgeInsets.only(top: height * 0.04),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(top: height * 0.04),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      accountBalanceTitle,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: width * 0.035,
                      ),
                    ),
                    // For Spacing
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // Balance
                    Text(
                      "\$${snapshot.data}",
                      style: TextStyle(
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.1,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class _AddedWallets extends ViewModelWidget<AccountViewModel> {
  final double width, height;
  final NavigationService navigationService;
  const _AddedWallets(
      {required this.width,
      required this.height,
      required this.navigationService});

  // Variables
  final String walletNameKey = "Wallet";
  final String walletPictureKey = "Picture";
  final String walletBalanceKey = "Balance";

  @override
  Widget build(BuildContext context, AccountViewModel viewModel) {
    return SizedBox(
      width: width * 0.9,
      height: height * 0.38,
      child: FutureBuilder(
        future: viewModel.walletService.getWallets(),
        builder: (context, snapshot) {
          // Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: List.generate(
                3,
                (index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: height * 0.1,
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: AppColors.walletIconBackgroundColorProfile,
                        borderRadius: BorderRadius.circular(width * 0.04),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final wallet = snapshot.data![index];
              return InkWell(
                borderRadius: BorderRadius.circular(width * 0.04),
                onTap: () async {
                  await navigationService.navigateToAccountDetails(
                    walletName: wallet.walletName!,
                    walletBalance: wallet.balance!,
                    icon: wallet.accountType == "Wallet"
                        ? IconsPath.wallet
                        : IconsPath.bank,
                  );
                  viewModel.rebuildUi();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon
                      Container(
                        width: width * 0.12,
                        height: width * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          color: AppColors.violet20,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            wallet.accountType == "Wallet"
                                ? IconsPath.wallet
                                : IconsPath.bank,
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
                        width: width * 0.04,
                      ),
                      // Wallet Name
                      Text(
                        wallet.walletName!,
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // For Spacing
                      const Spacer(),
                      // Wallet Balance
                      Text(
                        "\$${wallet.balance}",
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
          );
        },
      ),
    );
  }
}
