import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view_model.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

class TransferView extends StackedView<TransferViewModel> {
  const TransferView({super.key});

  final String continueButtonText = "Continue";
  final String appBarTitle = "Transfer";
  final String descriptionTextFieldHintText = "Description";

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
        backgroundColor: AppColors.primaryBlue,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Balance(
            width: width,
            height: height,
            balanceController: viewModel.balanceController,
          ),
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
                    _TransferTextField(
                      height: height,
                      width: width,
                    ),
                    CustomTextFormField(
                      width: width,
                      height: height,
                      controller: viewModel.descriptionController,
                      hintText: descriptionTextFieldHintText,
                      validator: (value) =>
                          viewModel.validateDescription(value),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    _Wallet(width: width, height: height),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    const FileInserter(),
                    SizedBox(
                      height: height * 0.04,
                    ),
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
}

class _Balance extends StatelessWidget {
  final double width, height;
  final TextEditingController balanceController;
  const _Balance(
      {required this.width,
      required this.height,
      required this.balanceController});

  final String inputHintText = "How much?";

  @override
  Widget build(BuildContext context) {
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
              color: AppColors.light80.withValues(alpha: 0.6),
            ),
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

  final String fromText = "From";
  final String toText = "To";

  @override
  Widget build(BuildContext context, TransferViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

class _Wallet extends ViewModelWidget<TransferViewModel> {
  final double width, height;
  const _Wallet({required this.width, required this.height});

  final String addWalletButtonText = "Add Wallet";
  final String walletDropDownHintText = "Wallet";

  @override
  Widget build(BuildContext context, TransferViewModel viewModel) {
    return CustomBottomSheet(
      buttonsBottomHight: 0,
      buttonWidth: width * 0.3,
      bottomSheetHight: height * 0.42,
      buttonText: addWalletButtonText,
      hintText: walletDropDownHintText,
      storeSelectedItem: viewModel.storeSelectedWallet,
      onPressed: () => viewModel.addTransferTransactionCompleted(),
      showSelectedItemOnHintText: _ShowSelectedWallet(
        accountName: viewModel.storeSelectedWallet["option"],
        width: width,
      ),
      showItems: SizedBox(
        height: height * 0.3,
        child: Column(
          children: [
            _ShowItemsForWallet(
              width: width,
              height: height,
              data: viewModel.fetchingWalletOptions(),
              updateIndex: (value) => viewModel.onPageChanged(value),
              updateHintText: (index) {
                viewModel.updateWalletHintText(index: index);
              },
            ),
            _Indicators(
              itemIndex: viewModel.itemIndex,
              width: width,
              height: height,
              viewModel.fetchingWalletOptions(),
            )
          ],
        ),
      ),
    );
  }
}

class _ShowSelectedWallet extends StatelessWidget {
  final String accountName;
  final double width;
  const _ShowSelectedWallet({
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

class _ShowItemsForWallet extends StatelessWidget {
  final double width, height;
  final Future<PersonData> data;
  final Function(int index) updateHintText;
  final Function(int value) updateIndex;
  const _ShowItemsForWallet({
    required this.width,
    required this.height,
    required this.updateHintText,
    required this.updateIndex,
    required this.data,
  });

  final String bankBalanceText = "Balance";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: FutureBuilder<PersonData>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return PageView.builder(
            onPageChanged: (value) {
              updateIndex(value);
            },
            itemCount: snapshot.data!.wallets!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.wallets![index];
              return Center(
                child: InkWell(
                  onTap: () {
                    updateHintText(index);
                  },
                  child: SizedBox(
                    height: height * 0.2,
                    width: width * 0.7,
                    child: Card(
                      elevation: width * 0.02,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.05),
                        side: BorderSide(
                          color: AppColors.light20,
                          width: width * 0.0015,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.01),
                            child: Text(
                              data.walletName!,
                              style: TextStyle(
                                color: AppColors.primaryBlack,
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.07),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      bankBalanceText,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: width * 0.07),
                                      child: Text(
                                        "${data.balance}",
                                        style: TextStyle(
                                          color: AppColors.black50,
                                          fontWeight: FontWeight.w400,
                                          fontSize: width * 0.04,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.07),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data.accountType!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: width * 0.06),
                                      child: SvgPicture.asset(
                                        IconsPath.wallet,
                                        width: width * 0.025,
                                        height: height * 0.025,
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
          );
        },
      ),
    );
  }
}

class _Indicators extends StatefulWidget {
  final double width, height;
  final Future<PersonData> data;
  final ValueNotifier itemIndex;
  const _Indicators(this.data,
      {required this.itemIndex, required this.width, required this.height});

  @override
  State<_Indicators> createState() => _IndicatorsState();
}

class _IndicatorsState extends State<_Indicators> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height * 0.04,
      child: FutureBuilder<PersonData>(
        future: widget.data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ValueListenableBuilder(
            valueListenable: widget.itemIndex,
            builder: (context, _, child) {
              return Padding(
                padding: EdgeInsets.only(
                    top: widget.height * 0.01, bottom: widget.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    snapshot.data!.wallets!.length,
                    (index) => Padding(
                      padding: EdgeInsets.all(index == widget.itemIndex.value
                          ? widget.width * 0.01
                          : widget.width * 0.008),
                      child: CircleAvatar(
                        backgroundColor: index == widget.itemIndex.value
                            ? AppColors.primaryViolet
                            : AppColors.violet20,
                        minRadius: index == widget.itemIndex.value
                            ? widget.width * 0.015
                            : widget.width * 0.01,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
