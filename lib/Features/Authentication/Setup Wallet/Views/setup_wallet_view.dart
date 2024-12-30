import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Wallet/Views/setup_wallet_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class SetupWalletView extends StackedView<SetupWalletViewModel> {
  SetupWalletView({super.key});

  String appBarTitle = "Add new Account";
  String continueButtonText = "Continue";

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
                    nameController: viewModel.nameController,
                    selectedAccountType: viewModel.selectedAccountType,
                    onTap: viewModel.onTap,
                    onTapOutside: (context) => viewModel.onTapOutside(context),
                    onCompleted: (context) => viewModel.onComplete(context),
                    onChanged: (value) => viewModel.onChanged(value),
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
                    text: continueButtonText,
                    onPressed: () => viewModel.allSetupNavigation(),
                  ),
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
  final String balance = "0";

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
                color: AppColors.light80.withOpacity(0.6)),
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
                child: TextField(
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
                    hintText: balance,
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

class _InputFields extends StatelessWidget {
  final double width, height;
  final String selectedAccountType;
  final TextEditingController nameController;
  final Function onTap;
  final Function(BuildContext context) onTapOutside, onCompleted;
  final Function(String value) onChanged;
  const _InputFields(
      {required this.width,
      required this.height,
      required this.nameController,
      required this.selectedAccountType,
      required this.onTap,
      required this.onTapOutside,
      required this.onCompleted,
      required this.onChanged});

  final String nameTextFieldHintText = "Name";
  final String dropDownHintText = "Account Type";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.05),
          child: CustomTextField(
            width: width,
            height: height,
            hintText: nameTextFieldHintText,
            controller: nameController,
            onTap: () => onTap(),
            onTapOutside: (event) => onTapOutside(context),
            onCompleted: () => onCompleted(context),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        DropDown(
          width: width,
          height: height,
          hintText: dropDownHintText,
          selectedItem: selectedAccountType,
          items: Database.accountTypes,
          onChanged: (value) => onChanged(value),
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
          return index == 7
              ? InkWell(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  onTap: () {
                    _SelectBankBottomSheet.showSheet(
                      context: context,
                      width: width,
                      height: height,
                      searchController: viewModel.searchController,
                      selectedAccountType: viewModel.selectedAccountType,
                    );
                  },
                  child: Center(
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.045,
                      margin: EdgeInsets.only(top: height * 0.005),
                      decoration: BoxDecoration(
                        color: AppColors.violet20,
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      child: Center(
                        child: Text(
                          "See other",
                          style: TextStyle(
                            color: AppColors.primaryViolet,
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
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

class _SelectBankBottomSheet {
  static void showSheet({
    required BuildContext context,
    required double width,
    required double height,
    required searchController,
    required String selectedAccountType,
  }) {
    String dropDownHintText = "Account Type";
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          showDragHandle: true,
          shadowColor: AppColors.primaryBlack,
          dragHandleColor: AppColors.violet40,
          dragHandleSize: Size(width * 0.2, height * 0.005),
          backgroundColor: AppColors.primaryLight,
          elevation: width * 0.02,
          constraints: BoxConstraints(minHeight: height * 0.4, minWidth: width),
          onClosing: () {},
          builder: (context) {
            return Column(
              children: [
                CustomTextField(
                  controller: searchController,
                  width: width,
                  hintText: dropDownHintText,
                  height: height,
                  borderRadius: width * 0.08,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          width: width * 0.9,
                          height: height * 0.068,
                          padding: EdgeInsets.only(left: width * 0.03),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                selectedAccountType.isNotEmpty &&
                                        selectedAccountType == "Wallet"
                                    ? IconsPath.easypaisa
                                    : IconsPath.ubl,
                                width: width * 0.06,
                                height: width * 0.06,
                              ),
                              SizedBox(
                                width: width * 0.06,
                              ),
                              Text(
                                selectedAccountType.isNotEmpty &&
                                        selectedAccountType == "Wallet"
                                    ? "Easypaisa"
                                    : "UBL",
                                style: TextStyle(
                                  color: AppColors.primaryBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width * 0.045,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
