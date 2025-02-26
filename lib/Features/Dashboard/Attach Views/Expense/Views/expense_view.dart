import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view_model.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:montra_expense_tracker/Widgets/add_options.dart';
import 'package:montra_expense_tracker/Widgets/category_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:montra_expense_tracker/Widgets/wallet_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ExpenseView extends StackedView<ExpenseViewModel> {
  const ExpenseView({super.key});

  // Variables
  final String appBarTitle = "Expense";
  final String continueButtonText = "Continue";
  final String descriptionText = "Description";

  @override
  Widget builder(
      BuildContext context, ExpenseViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryRed,
      appBar: whiteAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        backgroundColor: AppColors.primaryRed,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance
          _Balance(
            width: width,
            balanceController: viewModel.balanceController,
          ),
          // White Color Background Container
          Expanded(
            child: Container(
              width: double.infinity,
              height: height * 0.6,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.1),
                  topRight: Radius.circular(width * 0.1),
                ),
              ),
              child: Column(
                children: [
                  // Category Bottom Sheet
                  CategoryBottomSheet(
                    fetchingCategoryOptions:
                        viewModel.optionService.getExpenseOptions(),
                    storeSelectedCategory: viewModel.storeSelectedCategory,
                    dropDown: "Category",
                    onPressed: () {
                      addOption(
                        width: width,
                        height: height,
                        context: context,
                        title: "Create Category",
                        addExpense: true,
                      );
                    },
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Description
                  Form(
                    key: viewModel.descriptionFormKey,
                    child: CustomTextFormField(
                      width: width,
                      height: height,
                      controller: viewModel.descriptionController,
                      hintText: descriptionText,
                      validator: (value) =>
                          viewModel.validateDescription(value),
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Wallet Bottom Sheet
                  WalletBottomSheet(
                    storeSelectedWallet: viewModel.storeSelectedWallet,
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // To Import Images
                  const FileInserter(),
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Continue Button
                  CustomElevatedButton(
                    width: width,
                    height: height,
                    backgroundColor: viewModel.showLoading
                        ? AppColors.violet20
                        : AppColors.primaryViolet,
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
                    onPressed: () => viewModel.addExpenseTransactionCompleted(
                        context: context),
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
  ExpenseViewModel viewModelBuilder(BuildContext context) => ExpenseViewModel();

  @override
  void onDispose(ExpenseViewModel viewModel) {
    viewModel.balanceController.dispose();
    viewModel.descriptionController.dispose();
    super.onDispose(viewModel);
  }
}

class _Balance extends StatelessWidget {
  final double width;
  final TextEditingController balanceController;
  const _Balance({required this.width, required this.balanceController});

  // Variables
  final String inputHintText = "How much?";

  @override
  Widget build(BuildContext context) {
    // Providers
    var currencyProvider = Provider.of<CurrencyProvider>(context, listen: true);
    return Padding(
      padding: EdgeInsets.only(top: width * 0.3, left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input Hint Text
          Text(
            inputHintText,
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
              color: AppColors.light80.withValues(alpha: 0.6),
            ),
          ),
          // Balance Text Field
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
              // Balance Text Field
              Expanded(
                child: TextField(
                  controller: balanceController,
                  showCursor: false,
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
