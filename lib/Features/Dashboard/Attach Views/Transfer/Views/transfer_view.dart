import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view_model.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:montra_expense_tracker/Widgets/wallet_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class TransferView extends StackedView<TransferViewModel> {
  const TransferView({super.key});

  // Variables
  final String appBarTitle = "Transfer";
  final String continueButtonText = "Continue";
  final String descriptionTextFieldHintText = "Description";

  @override
  Widget builder(
      BuildContext context, TransferViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryBlue,
      appBar: whiteAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        backgroundColor: AppColors.primaryBlue,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance
          _Balance(
            width: width,
            height: height,
            balanceController: viewModel.balanceController,
          ),
          // White Background Color Container
          Expanded(
            child: Container(
              width: double.infinity,
              height: height * 0.3,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.1),
                  topRight: Radius.circular(width * 0.1),
                ),
              ),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    // Transfer Text Field
                    _TransferTextField(
                      height: height,
                      width: width,
                    ),
                    // Description Text Field
                    CustomTextFormField(
                      width: width,
                      height: height,
                      controller: viewModel.descriptionController,
                      hintText: descriptionTextFieldHintText,
                      validator: (value) =>
                          viewModel.validateDescription(value),
                    ),
                    // For Spacing
                    SizedBox(
                      height: height * 0.02,
                    ),
                    // Wallet
                    WalletBottomSheet(
                        storeSelectedWallet: viewModel.storeSelectedWallet),
                    // For Spacing
                    SizedBox(
                      height: height * 0.04,
                    ),
                    // Attach File
                    const FileInserter(),
                    // For Spacing
                    SizedBox(
                      height: height * 0.04,
                    ),
                    // Button
                    CustomElevatedButton(
                      width: width,
                      height: height,
                      backgroundColor: viewModel.showLoading
                          ? AppColors.violet20
                          : AppColors.primaryViolet,
                      onPressed: () =>
                          viewModel.addTransferTransactionCompleted(),
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
          ),
        ],
      ),
    );
  }

  @override
  TransferViewModel viewModelBuilder(BuildContext context) =>
      TransferViewModel();

  @override
  void onDispose(TransferViewModel viewModel) {
    viewModel.balanceController.dispose();
    viewModel.descriptionController.dispose();
    viewModel.fromController.dispose();
    viewModel.toController.dispose();
    super.onDispose(viewModel);
  }
}

class _Balance extends StatelessWidget {
  final double width, height;
  final TextEditingController balanceController;
  const _Balance(
      {required this.width,
      required this.height,
      required this.balanceController});

  // Variables
  final String inputHintText = "How much?";

  @override
  Widget build(BuildContext context) {
    // Providers
    var currencyProvider = Provider.of<CurrencyProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: height * 0.15, left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input Hint
          Text(
            inputHintText,
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
              color: AppColors.light80.withValues(alpha: 0.6),
            ),
          ),
          // Balance
          Row(
            children: [
              // Currency
              Text(
                currencyProvider.currency,
                style: TextStyle(
                  fontSize: width * 0.16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.light80,
                ),
              ),
              // Text Field
              Expanded(
                child: TextField(
                  showCursor: false,
                  controller: balanceController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: width * 0.16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.light80,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "0",
                    hintStyle: TextStyle(
                      fontSize: width * 0.16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.light80,
                    ),
                  ),
                  onTap: () {
                    balanceController.selection = TextSelection.fromPosition(
                      TextPosition(offset: balanceController.text.length),
                    );
                  },
                  onChanged: (value) {
                    balanceController.selection = TextSelection.fromPosition(
                      TextPosition(offset: value.length),
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

class _TransferTextField extends ViewModelWidget<TransferViewModel> {
  final double width, height;
  const _TransferTextField({
    required this.width,
    required this.height,
  });

  // Variables
  final String fromText = "From";
  final String toText = "To";

  @override
  Widget build(BuildContext context, TransferViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // From Text Field
          SizedBox(
            width: width * 0.4,
            height: height * 0.1,
            child: CustomTextFormField(
              width: width,
              height: height,
              hintText: fromText,
              controller: viewModel.fromController,
              validator: (value) => viewModel.validateFrom(value),
            ),
          ),
          // Transaction Icon
          Container(
            decoration: BoxDecoration(
              color: AppColors.light80,
              border: Border.all(color: AppColors.light60, width: width * 0.02),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              IconsPath.transaction,
              width: width * 0.03,
              height: height * 0.03,
            ),
          ),
          // To Text Field
          SizedBox(
            width: width * 0.4,
            height: height * 0.1,
            child: CustomTextFormField(
              width: width,
              height: height,
              hintText: toText,
              controller: viewModel.toController,
              validator: (value) => viewModel.validateTo(value),
            ),
          ),
        ],
      ),
    );
  }
}
