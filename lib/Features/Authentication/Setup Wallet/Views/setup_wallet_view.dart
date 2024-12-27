import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
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
  String nameTextFieldHintText = "Name";
  String addWalletButtonText = "Add Wallet";
  String walletText = "Wallet";
  String walletOptionsAccountBalanceKey = "Balance";
  String walletOptionsAccountTypeKey = "Account Type";
  String walletOptionsBankPictureKey = "Picture";

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
          Balance(),
          Expanded(
            child: Container(
              width: double.infinity,
              height: height * 0.4,
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
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomDropDown(
                    buttonsBottomHight: 0,
                    buttonText: addWalletButtonText,
                    buttonWidth: width * 0.3,
                    bottomSheetHight: height * 0.38,
                    hintText: walletText,
                    showSelectedItemOnHintText: ShowSelectedWallet(
                      accountName: viewModel
                          .storeSelectedWallet[Variables.universalItemKey],
                      width: width,
                    ),
                    storeSelectedItem: viewModel.storeSelectedWallet,
                    showItems: ShowItemsForWallet(
                      accountBalanceKey: walletOptionsAccountBalanceKey,
                      accountTypeKey: walletOptionsAccountTypeKey,
                      bankNamekey: walletText,
                      walletPictureKey: walletOptionsBankPictureKey,
                      updateHintText: (index) {
                        viewModel.updateWalletHintText(index: index);
                      },
                      width: width,
                      height: height,
                      walletOptions: Database.walletOptions,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
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
  Balance({super.key});

  String inputHintText = "Balance";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: width * 0.8, left: width * 0.05),
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

class ShowSelectedWallet extends StatelessWidget {
  final String accountName;
  final double width;
  const ShowSelectedWallet({
    super.key,
    required this.accountName,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      accountName,
      style: TextStyle(
        color: AppColors.primaryBlack,
        fontSize: width * 0.04,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ShowItemsForWallet extends StatefulWidget {
  final double width, height;
  final List<Map<String, dynamic>> walletOptions;
  final Function(int index) updateHintText;
  final String bankNamekey;
  final String accountBalanceKey;
  final String walletPictureKey;
  final String accountTypeKey;
  const ShowItemsForWallet(
      {super.key,
      required this.width,
      required this.height,
      required this.walletOptions,
      required this.updateHintText,
      required this.bankNamekey,
      required this.accountBalanceKey,
      required this.walletPictureKey,
      required this.accountTypeKey});

  @override
  State<ShowItemsForWallet> createState() => _ShowItemsForWalletState();
}

class _ShowItemsForWalletState extends State<ShowItemsForWallet> {
  int itemIndex = 0;
  String bankBalanceText = "Balance";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height * 0.3,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  itemIndex = value;
                });
              },
              itemCount: widget.walletOptions.length,
              itemBuilder: (context, index) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      widget.updateHintText(index);
                    },
                    child: SizedBox(
                      height: widget.height * 0.2,
                      width: widget.width * 0.7,
                      child: Card(
                        elevation: widget.width * 0.02,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(widget.width * 0.05),
                          side: BorderSide(
                            color: AppColors.light20,
                            width: widget.width * 0.0015,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: widget.height * 0.01),
                              child: Text(
                                widget.walletOptions[index][widget.bankNamekey],
                                style: TextStyle(
                                  color: AppColors.primaryBlack,
                                  fontSize: widget.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: widget.height * 0.04,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.width * 0.07),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        bankBalanceText,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: widget.width * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: widget.width * 0.07),
                                        child: Text(
                                          "${widget.walletOptions[index][widget.accountBalanceKey]}",
                                          style: TextStyle(
                                            color: AppColors.black50,
                                            fontWeight: FontWeight.w400,
                                            fontSize: widget.width * 0.04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: widget.height * 0.025,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.width * 0.07),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.walletOptions[index]
                                            [widget.accountTypeKey],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: widget.width * 0.04,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: widget.width * 0.06),
                                        child: SvgPicture.asset(
                                          widget.walletOptions[index]
                                              [widget.walletPictureKey],
                                          width: widget.width * 0.025,
                                          height: widget.height * 0.025,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: widget.height * 0.01, bottom: widget.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.walletOptions.length,
                (index) => Padding(
                  padding: EdgeInsets.all(index == itemIndex
                      ? widget.width * 0.01
                      : widget.width * 0.008),
                  child: CircleAvatar(
                    backgroundColor: index == itemIndex
                        ? AppColors.primaryViolet
                        : AppColors.violet20,
                    minRadius: index == itemIndex
                        ? widget.width * 0.015
                        : widget.width * 0.01,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
