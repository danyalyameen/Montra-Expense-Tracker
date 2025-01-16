import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Wallet/Views/setup_wallet_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

class SetupWalletView extends StackedView<SetupWalletViewModel> {
  const SetupWalletView({super.key});

  final String appBarTitle = "Add new Account";
  final String continueButtonText = "Continue";

  @override
  Widget builder(
      BuildContext context, SetupWalletViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryViolet,
      appBar: whiteAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        backgroundColor: AppColors.primaryViolet,
        leading: const SizedBox(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Balance(
            width: width,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.1),
                  topRight: Radius.circular(width * 0.1),
                ),
              ),
              child: Column(
                children: [
                  _InputFields(
                    width: width,
                    height: height,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  viewModel.selectedAccountType.isEmpty
                      ? const SizedBox()
                      : _SelectBankOrWallet(
                          width: width,
                          height: height,
                        ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  CustomElevatedButton(
                    width: width,
                    height: height,
                    backgroundColor: viewModel.showLoading
                        ? AppColors.violet20
                        : AppColors.primaryViolet,
                    onPressed: () => viewModel.allSetupNavigation(),
                    child: viewModel.showLoading
                        ? SpinKitThreeBounce(
                            color: AppColors.primaryViolet,
                            size: width * 0.06,
                          )
                        : Text(
                            continueButtonText,
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  SetupWalletViewModel viewModelBuilder(BuildContext context) =>
      SetupWalletViewModel();
}

class _Balance extends ViewModelWidget<SetupWalletViewModel> {
  final double width;
  const _Balance({
    required this.width,
  });

  final String balanceText = "Balance";
  final String balanceHintText = "0";

  @override
  Widget build(BuildContext context, SetupWalletViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(
        top: viewModel.isFocus
            ? viewModel.selectedAccountType.isEmpty
                ? width * 0.55
                : width * 0.56
            : viewModel.selectedAccountType.isEmpty
                ? width * 0.8
                : width * 0.64,
        left: width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            balanceText,
            style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
                color: AppColors.light80.withValues(alpha: 0.6)),
          ),
          Row(
            children: [
              Text(
                "\$",
                style: TextStyle(
                  fontSize: width * 0.16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.light80,
                ),
              ),
              Expanded(
                child: Form(
                  key: viewModel.balanceFormKey,
                  child: TextFormField(
                    showCursor: false,
                    keyboardType: TextInputType.number,
                    controller: viewModel.balanceController,
                    style: TextStyle(
                      fontSize: width * 0.16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.light80,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: balanceHintText,
                      hintStyle: TextStyle(
                        fontSize: width * 0.16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.light80,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _InputFields extends ViewModelWidget<SetupWalletViewModel> {
  final double width, height;
  const _InputFields({
    required this.width,
    required this.height,
  });

  final String nameTextFieldHintText = "Name";
  final String dropDownHintText = "Account Type";

  @override
  Widget build(BuildContext context, SetupWalletViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.05),
          child: Form(
            key: viewModel.nameFormKey,
            child: CustomTextFormField(
              width: width,
              height: height,
              hintText: nameTextFieldHintText,
              controller: viewModel.nameController,
              validator: (value) => viewModel.validateName(value),
              onTap: () => viewModel.onTap(),
              onTapOutside: (event) => viewModel.onTapOutside(context),
              onComplete: () => viewModel.onComplete(context),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        DropDown(
          width: width,
          height: height,
          hintText: dropDownHintText,
          selectedItem: viewModel.selectedAccountType,
          items: Database.accountTypes,
          onChanged: (value) => viewModel.onChanged(value),
        ),
      ],
    );
  }
}

class _SelectBankOrWallet extends ViewModelWidget<SetupWalletViewModel> {
  final double width, height;
  const _SelectBankOrWallet({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context, SetupWalletViewModel viewModel) {
    return SizedBox(
      width: width * 0.9,
      height: height * 0.12,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          return Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(width * 0.02),
              onTap: () {
                viewModel.updateCurrentIndex(index);
              },
              child: Container(
                width: width * 0.2,
                height: height * 0.045,
                margin: EdgeInsets.only(top: height * 0.005),
                decoration: BoxDecoration(
                  color: index == viewModel.currentIndex
                      ? AppColors.violet20
                      : AppColors.walletIconBackgroundColorProfile,
                  borderRadius: BorderRadius.circular(width * 0.02),
                  border: Border.all(
                    width: width * 0.002,
                    color: index == viewModel.currentIndex
                        ? AppColors.primaryViolet
                        : AppColors.walletIconBackgroundColorProfile,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    viewModel.selectedAccountType.isNotEmpty &&
                            viewModel.selectedAccountType == "Bank"
                        ? IconsPath.ubl
                        : IconsPath.jazzcash,
                    width: width * 0.02,
                    height: height * 0.02,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
