import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Wallet/Views/setup_wallet_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

class SetupWalletView extends StackedView<SetupWalletViewModel> {
  const SetupWalletView({super.key});

  // Variables
  final String appBarTitle = "Add new Account";
  final String continueButtonText = "Continue";

  @override
  Widget builder(
      BuildContext context, SetupWalletViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
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
      body: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Input Field
            _Balance(
              width: width,
              height: height,
            ),
            // Background White Box of Text Fields
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
                    // Input Fields
                    _InputFields(
                      width: width,
                      height: height,
                    ),
                    // For Spacing
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // Continue Button
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
      ),
    );
  }

  @override
  SetupWalletViewModel viewModelBuilder(BuildContext context) =>
      SetupWalletViewModel();
}

class _Balance extends ViewModelWidget<SetupWalletViewModel> {
  final double width, height;
  const _Balance({
    required this.width,
    required this.height,
  });

  // Variables
  final String balanceText = "Balance";
  final String balanceHintText = "0";

  @override
  Widget build(BuildContext context, SetupWalletViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(
        top: viewModel.isFocus ? height * 0.24 : height * 0.32,
        left: width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Title
          Text(
            balanceText,
            style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
                color: AppColors.light80.withValues(alpha: 0.6)),
          ),
          // Balance
          Row(
            children: [
              // Currency Symbol
              Text(
                Variables.currency,
                style: TextStyle(
                  fontSize: width * 0.16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.light80,
                ),
              ),
              // Input Field of Balance
              Expanded(
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
                  onTap: () {
                    // Always move cursor to the end
                    viewModel.balanceController.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                          offset: viewModel.balanceController.text.length),
                    );
                  },
                  onChanged: (text) {
                    // Ensure cursor is always at the end
                    viewModel.balanceController.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: text.length),
                    );
                  },
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

  // Variables
  final String nameTextFieldHintText = "Name";
  final String dropDownHintText = "Account Type";

  @override
  Widget build(BuildContext context, SetupWalletViewModel viewModel) {
    return Column(
      children: [
        // Wallet Name Input Field
        Padding(
          padding: EdgeInsets.only(top: height * 0.05),
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
        // For Spacing
        SizedBox(
          height: height * 0.02,
        ),
        // Drop Down
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
