import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

class AccountView extends StackedView<AccountViewModel> {
  const AccountView({super.key});

  final String appBarTitle = "Account";
  final String buttonText = " + Add new wallet";

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
            _AccountBalance(
              width: width,
              height: height,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            // _AddedWallets(
            //   width: width,
            //   height: height,
            //   navigationService: viewModel.navigationService,
            // ),
            SizedBox(
              height: height * 0.04,
            ),
            SizedBox(
              width: width * 0.9,
              height: height * 0.075,
              child: CustomElevatedButton(
                width: width,
                height: height,
                text: buttonText,
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

class _AccountBalance extends StatelessWidget {
  final double width, height;
  const _AccountBalance({
    required this.width,
    required this.height,
  });

  final String accountBalanceTitle = "Account Balance";
  final String balance = "0";

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
              color: Colors.white.withValues(alpha: 0.1),
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
                  "\$$balance",
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

// class _AddedWallets extends StatelessWidget {
//   final double width, height;
//   final NavigationService navigationService;
//   _AddedWallets(
//       {required this.width,
//       required this.height,
//       required this.navigationService});

//   final String walletNameKey = "Wallet";
//   final String walletPictureKey = "Picture";
//   final String walletBalanceKey = "Balance";
//   final List<Map<String, dynamic>> data = Database.walletOptions;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width * 0.9,
//       height: height * 0.4,
//       child: ListView.separated(
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               navigationService.navigateToAccountDetails(
//                   walletName: data[index][walletNameKey],
//                   walletBalance: data[index][walletBalanceKey],
//                   icon: data[index][walletPictureKey]);
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: height * 0.02),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: width * 0.12,
//                     height: width * 0.12,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(width * 0.04),
//                       color: AppColors.walletIconBackgroundColorProfile,
//                     ),
//                     child: Center(
//                       child: SvgPicture.asset(
//                         data[index][walletPictureKey],
//                         width: width * 0.04,
//                         height: width * 0.04,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: width * 0.04,
//                   ),
//                   Text(
//                     data[index][walletNameKey],
//                     style: TextStyle(
//                       color: AppColors.primaryBlack,
//                       fontSize: width * 0.045,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "\$${data[index][walletBalanceKey]}",
//                     style: TextStyle(
//                       color: AppColors.primaryBlack,
//                       fontSize: width * 0.045,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (context, index) {
//           return Divider(
//             thickness: width * 0.001,
//             color: AppColors.light20,
//             height: height * 0.001,
//           );
//         },
//         itemCount: data.length,
//       ),
//     );
//   }
// }
