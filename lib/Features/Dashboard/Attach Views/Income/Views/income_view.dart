import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view_model.dart';
import 'package:montra_expense_tracker/Widgets/category_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:montra_expense_tracker/Widgets/wallet_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

class IncomeView extends StackedView<IncomeViewModel> {
  const IncomeView({super.key});

  final String appBarTitle = "Income";
  final String descriptionTextFieldHintText = "Description";
  final String continueButtonText = "Continue";

  @override
  Widget builder(
      BuildContext context, IncomeViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryGreen,
      appBar: whiteAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        backgroundColor: AppColors.primaryGreen,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Balance(
            width: width,
            balanceController: viewModel.balanceController,
          ),
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
                  CategoryBottomSheet(
                      fetchingCategoryOptions:
                          viewModel.fetchingIncomeOptions()),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Form(
                    key: viewModel.descriptionFormKey,
                    child: CustomTextFormField(
                      width: width,
                      height: height,
                      controller: viewModel.descriptionController,
                      hintText: descriptionTextFieldHintText,
                      validator: (String? value) =>
                          viewModel.validateDescription(value),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const WalletBottomSheet(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  FileInserter(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomElevatedButton(
                    width: width,
                    height: height,
                    backgroundColor: viewModel.showLoading
                        ? AppColors.violet20
                        : AppColors.primaryViolet,
                    onPressed: () => viewModel.addIncomeCompleted(),
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
  IncomeViewModel viewModelBuilder(BuildContext context) => IncomeViewModel();
}

class _Balance extends StatelessWidget {
  final double width;
  final TextEditingController balanceController;
  const _Balance({required this.width, required this.balanceController});
  final String inputHintText = "How much?";
  final String balanceHintText = "0";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: width * 0.3, left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputHintText,
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
                    color: AppColors.light80),
              ),
              Expanded(
                child: TextField(
                  showCursor: false,
                  keyboardType: TextInputType.number,
                  controller: balanceController,
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
              )
            ],
          )
        ],
      ),
    );
  }
}
