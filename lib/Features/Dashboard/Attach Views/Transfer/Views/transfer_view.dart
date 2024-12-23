import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class TransferView extends StackedView<TransferViewModel> {
  TransferView({super.key});

  String continueButtonText = "Continue";
  String appBarTitle = "Transfer";
  String descriptionTextFieldHintText = "Description";
  String addWalletButtonText = "Add Wallet";
  String walletDropDownHintText = "Wallet";
  String walletOptionsBankNameKey = "Wallet";
  String walletOptionsAccountBalanceKey = "Balance";
  String walletOptionsAccountTypeKey = "Account Type";
  String walletOptionsBankPictureKey = "Picture";
  String fromTextFieldHintText = "From";
  String toTextFieldHintText = "To";

  @override
  Widget builder(
      BuildContext context, TransferViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryBlue,
      appBar: whiteAppBar(
          title: appBarTitle,
          width: width,
          height: height,
          backgroundColor: AppColors.primaryBlue),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Balance(),
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
              child: Column(
                children: [
                  TransferTextField(
                    fromController: viewModel.fromController,
                    toController: viewModel.toController,
                    fromTextFieldHintText: fromTextFieldHintText,
                    toTextFieldHintText: toTextFieldHintText,
                    height: height,
                    width: width,
                  ),
                  CustomTextField(
                    controller: viewModel.descriptionController,
                    width: width,
                    hintText: descriptionTextFieldHintText,
                    height: height,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomDropDown(
                    buttonsBottomHight: 0,
                    buttonText: addWalletButtonText,
                    buttonWidth: width * 0.3,
                    bottomSheetHight: height * 0.38,
                    hintText: walletDropDownHintText,
                    showSelectedItemOnHintText: ShowSelectedWallet(
                      accountName: viewModel
                          .storeSelectedWallet[Variables.universalItemKey],
                      width: width,
                    ),
                    storeSelectedItem: viewModel.storeSelectedWallet,
                    showItems: ShowItemsForWallet(
                      accountBalanceKey: walletOptionsAccountBalanceKey,
                      accountTypeKey: walletOptionsAccountTypeKey,
                      bankNamekey: walletOptionsBankNameKey,
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
                    height: height * 0.02,
                  ),
                  FileInserter(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        continueButtonText,
                        style: TextStyle(fontSize: width * 0.05),
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
  TransferViewModel viewModelBuilder(BuildContext context) =>
      TransferViewModel();
}

// ignore: must_be_immutable
class Balance extends StatelessWidget {
  Balance({super.key});

  String inputHintText = "How much?";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.15, left: width * 0.05),
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
                  keyboardType: const TextInputType.numberWithOptions(),
                  style: TextStyle(
                    fontSize: width * 0.16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.light80,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "${Variables.balance.ceil()}",
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

class TransferTextField extends StatelessWidget {
  final double width, height;
  final TextEditingController fromController, toController;
  final String toTextFieldHintText, fromTextFieldHintText;
  const TransferTextField(
      {super.key,
      required this.width,
      required this.height,
      required this.fromController,
      required this.toController,
      required this.toTextFieldHintText,
      required this.fromTextFieldHintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: width * 0.42,
                  height: height * 0.1,
                  child: CustomTextField(
                      controller: fromController,
                      width: width,
                      hintText: fromTextFieldHintText,
                      height: height)),
              SizedBox(
                width: width * 0.05,
              ),
              SizedBox(
                  width: width * 0.42,
                  height: height * 0.1,
                  child: CustomTextField(
                      controller: toController,
                      width: width,
                      hintText: toTextFieldHintText,
                      height: height)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.light80,
                    border: Border.all(
                        color: AppColors.light60, width: width * 0.02),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlack,
                        blurRadius: width * 0.001,
                        blurStyle: BlurStyle.outer,
                      )
                    ]),
                child: SvgPicture.asset(
                  IconsPath.transaction,
                  width: width * 0.03,
                  height: height * 0.03,
                ),
              ),
            ),
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
