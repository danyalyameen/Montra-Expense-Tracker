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
import 'package:stacked_services/stacked_services.dart';

// ignore: must_be_immutable
class SetupWalletView extends StackedView<SetupWalletViewModel> {
  SetupWalletView({super.key});

  String appBarTitle = "Add new Account";
  String continueButtonText = "Continue";
  String nameTextFieldHintText = "Name";
  String dropDownHintText = "Account Type";
  String bottomSheetTitle = "Select Bank";
  String bottomSheetTextFieldHintText = "Search";

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
          Balance(
            width: width,
            isFocus: viewModel.focus,
            selectedAccountType: viewModel.selectedAccountType,
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
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.05),
                    child: CustomTextField(
                      controller: viewModel.nameController,
                      width: width,
                      hintText: nameTextFieldHintText,
                      height: height,
                      onTap: () => viewModel.isFocus(),
                      onTapOutside: (event) => viewModel.onTapOutside(context),
                      onCompleted: () => viewModel.onComplete(context),
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
                    onChanged: (value) => viewModel.dropDownOnChanged(value),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  viewModel.selectedAccountType.isEmpty
                      ? const SizedBox()
                      : SelectBankOrWallet(
                          width: width,
                          height: height,
                          selectedAccountType: viewModel.selectedAccountType,
                          currentIndex: viewModel.currentIndex,
                          searchController: viewModel.searchController,
                          updateIndex: (index) =>
                              viewModel.updateCurrentIndex(index),
                          bottomSheetTitle: bottomSheetTitle,
                          bottomSheetTextFieldHintText:
                              bottomSheetTextFieldHintText,
                          navigationService: viewModel.navigationService,
                        ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  CustomElevatedButton(
                    width: width,
                    height: height,
                    text: continueButtonText,
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

// ignore: must_be_immutable
class Balance extends StatelessWidget {
  final double width;
  final bool isFocus;
  final String selectedAccountType;
  Balance(
      {super.key,
      required this.width,
      required this.isFocus,
      required this.selectedAccountType});

  String inputHintText = "Balance";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: isFocus
              ? selectedAccountType.isEmpty
                  ? width * 0.55
                  : width * 0.56
              : selectedAccountType.isEmpty
                  ? width * 0.8
                  : width * 0.64,
          left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputHintText,
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
                    color: AppColors.light80),
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
                    hintText: "0",
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

class SelectBankOrWallet extends StatelessWidget {
  final double width, height;
  final String selectedAccountType,
      bottomSheetTitle,
      bottomSheetTextFieldHintText;
  final int currentIndex;
  final Function(int index) updateIndex;
  final TextEditingController searchController;
  final NavigationService navigationService;
  const SelectBankOrWallet(
      {super.key,
      required this.width,
      required this.height,
      required this.selectedAccountType,
      required this.currentIndex,
      required this.updateIndex,
      required this.searchController,
      required this.bottomSheetTitle,
      required this.bottomSheetTextFieldHintText,
      required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      height: height * 0.12,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        addSemanticIndexes: false,
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 2),
        itemBuilder: (context, index) {
          return index == 7
              ? InkWell(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  onTap: () {
                    SelectBankBottomSheet.showSheet(
                      context: context,
                      width: width,
                      height: height,
                      searchController: searchController,
                      title: bottomSheetTitle,
                      hintText: bottomSheetTextFieldHintText,
                      navigationService: navigationService,
                      selectedAccountType: selectedAccountType,
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
                      updateIndex(index);
                    },
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.045,
                      margin: EdgeInsets.only(top: height * 0.005),
                      decoration: BoxDecoration(
                          color: index == currentIndex
                              ? AppColors.violet20
                              : AppColors.walletIconBackgroundColorProfile,
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(
                            width: width * 0.002,
                            color: index == currentIndex
                                ? AppColors.primaryViolet
                                : AppColors.walletIconBackgroundColorProfile,
                          )),
                      child: Center(
                        child: SvgPicture.asset(
                          selectedAccountType.isNotEmpty &&
                                  selectedAccountType == "Bank"
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

class SelectBankBottomSheet {
  static void showSheet({
    required BuildContext context,
    required double width,
    required double height,
    required searchController,
    required String hintText,
    required String title,
    required navigationService,
    required String selectedAccountType,
  }) {
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
                  hintText: hintText,
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
