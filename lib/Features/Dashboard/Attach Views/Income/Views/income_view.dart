import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
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
          backgroundColor: AppColors.primaryGreen),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Balance(
            width: width,
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
                  _Income(width, height),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    width: width,
                    height: height,
                    controller: viewModel.descriptionController,
                    hintText: descriptionTextFieldHintText,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  _Wallet(
                    width: width,
                    height: height,
                    itemIndex: viewModel.itemIndex,
                    updateIndex: (index) => viewModel.onPageChanged(index),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  FileInserter(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  _SwitchTile(width: width, height: height),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomElevatedButton(
                    width: width,
                    height: height,
                    text: continueButtonText,
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

  @override
  bool get reactive => false;
}

class _Balance extends StatelessWidget {
  final double width;
  const _Balance({required this.width});
  final String inputHintText = "How much?";
  final String balance = "0";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: width * 0.24, left: width * 0.05),
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

class _Income extends ViewModelWidget<IncomeViewModel> {
  final double width, height;
  const _Income(this.width, this.height);

  final String incomeDropDownHintText = "Income";
  final String addIncomeButtonText = "Add Income";

  @override
  Widget build(BuildContext context, IncomeViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: CustomBottomSheet(
        hintText: incomeDropDownHintText,
        bottomSheetHight: height * 0.29,
        buttonWidth: width * 0.38,
        buttonText: addIncomeButtonText,
        buttonsBottomHight: height * 0.08,
        showItems: _ShowItemsForIncome(
          width: width,
          height: height,
          updateIncome: (index) {
            viewModel.updateIncomeHintText(index: index);
          },
        ),
        showSelectedItemOnHintText: _ShowSelectedIncome(
          width: width,
          height: height,
          storeSelectedIncome: viewModel.storeSelectedIncome,
        ),
        storeSelectedItem: viewModel.storeSelectedIncome,
      ),
    );
  }
}

class _ShowItemsForIncome extends StatelessWidget {
  final double width, height;
  final Function(int index) updateIncome;
  _ShowItemsForIncome({
    required this.width,
    required this.height,
    required this.updateIncome,
  });

  final String incomeOptionsIncomeKey = "Income";
  final String incomeOptionsColorKey = "Colors";
  final List<Map<String, dynamic>> data = Database.incomeOptions;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.057),
            child: InkWell(
              onTap: () {
                updateIncome(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryBlack,
                    width: width * 0.002,
                  ),
                  borderRadius: BorderRadius.circular(width * 0.08),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        data[index][incomeOptionsIncomeKey],
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.04),
                      child: CircleAvatar(
                        maxRadius: width * 0.01,
                        backgroundColor: data[index][incomeOptionsColorKey],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ShowSelectedIncome extends StatelessWidget {
  final double width, height;
  final Map<String, dynamic> storeSelectedIncome;
  const _ShowSelectedIncome({
    required this.width,
    required this.height,
    required this.storeSelectedIncome,
  });

  final String incomeOptionsColorKey = "Colors";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.012, bottom: height * 0.012),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryBlack,
            width: width * 0.002,
          ),
          borderRadius: BorderRadius.circular(width * 0.08),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                storeSelectedIncome[Variables.universalItemKey],
                style: TextStyle(
                    color: AppColors.primaryBlack, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.04),
              child: CircleAvatar(
                maxRadius: width * 0.01,
                backgroundColor: storeSelectedIncome[incomeOptionsColorKey],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Wallet extends ViewModelWidget<IncomeViewModel> {
  final double width, height;
  final int itemIndex;
  final Function(int index) updateIndex;
  const _Wallet({required this.updateIndex, 
      required this.itemIndex, required this.width, required this.height});

  final String addWalletButtonText = "Add Wallet";
  final String walletDropDownHintText = "Wallet";

  @override
  Widget build(BuildContext context, IncomeViewModel viewModel) {
    return CustomBottomSheet(
      buttonsBottomHight: 0,
      buttonWidth: width * 0.3,
      bottomSheetHight: height * 0.42,
      buttonText: addWalletButtonText,
      hintText: walletDropDownHintText,
      storeSelectedItem: viewModel.storeSelectedWallet,
      showSelectedItemOnHintText: _ShowSelectedWallet(
        accountName: viewModel.storeSelectedWallet[Variables.universalItemKey],
        width: width,
      ),
      showItems: SizedBox(
        height: height * 0.3,
        child: Column(
          children: [
            _ShowItemsForWallet(
              width: width,
              height: height,
              updateIndex: (value) => updateIndex(value),
              updateHintText: (index) {
                viewModel.updateWalletHintText(index: index);
              },
            ),
            _Indicators(itemIndex: itemIndex, width: width, height: height)
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
  final Function(int index) updateHintText;
  final Function(int value) updateIndex;
  _ShowItemsForWallet({
    required this.width,
    required this.height,
    required this.updateHintText,
    required this.updateIndex,
  });

  final String bankNameKey = "Wallet";
  final String bankBalanceText = "Balance";
  final String accountBalanceKey = "Balance";
  final String accountTypeKey = "Account Type";
  final String wankPictureKey = "Picture";
  final List<Map<String, dynamic>> walletOptions = Database.walletOptions;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: PageView.builder(
        onPageChanged: (value) {
          updateIndex(value);
        },
        itemCount: walletOptions.length,
        itemBuilder: (context, index) {
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
                          walletOptions[index][bankNameKey],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  padding: EdgeInsets.only(right: width * 0.07),
                                  child: Text(
                                    "${walletOptions[index][accountBalanceKey]}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  walletOptions[index][accountTypeKey],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: width * 0.06),
                                  child: SvgPicture.asset(
                                    walletOptions[index][wankPictureKey],
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
      ),
    );
  }
}

class _Indicators extends ViewModelWidget<IncomeViewModel> {
  final double width, height;
  final int itemIndex;
  const _Indicators(
      {required this.itemIndex, required this.width, required this.height});

  @override
  Widget build(BuildContext context, IncomeViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          Database.walletOptions.length,
          (index) => Padding(
            padding: EdgeInsets.all(
                index == itemIndex ? width * 0.01 : width * 0.008),
            child: CircleAvatar(
              backgroundColor: index == itemIndex
                  ? AppColors.primaryViolet
                  : AppColors.violet20,
              minRadius: index == itemIndex ? width * 0.015 : width * 0.01,
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchTile extends ViewModelWidget<IncomeViewModel> {
  final double width, height;
  const _SwitchTile({required this.width, required this.height});

  final String switchTitleText = "Repeat";
  final String switchSubTitleText = "Repeat transaction";

  @override
  Widget build(BuildContext context, IncomeViewModel viewModel) {
    return SwitchTile(
      title: switchTitleText,
      subtitle: switchSubTitleText,
      value: viewModel.isRepeat,
      onChanged: (value) {
        Database.addDataToDates();
        viewModel.toggleSwitch(value);
        _RepeatDialog.bottomSheet(
          context: context,
          width: width,
          height: height,
          selectedItemForFrequency: viewModel.selectedItemForFrequency,
          selectedItemForMonth: viewModel.selectedItemForMonth,
          selectedItemForDates: viewModel.selectedItemForDate,
        );
      },
    );
  }
}

class _RepeatDialog {
  static void bottomSheet({
    required BuildContext context,
    required double width,
    required double height,
    required String selectedItemForFrequency,
    required String selectedItemForMonth,
    required String selectedItemForDates,
  }) {
    const String hintTextForFrequency = "Frequency";
    const String hintTextForMonth = "Month";
    const String hintTextForDate = "Date";
    const String continueButtonText = "Continue";

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          showDragHandle: true,
          dragHandleColor: AppColors.violet40,
          dragHandleSize: Size(width * 0.2, height * 0.005),
          backgroundColor: AppColors.primaryLight,
          constraints: BoxConstraints(maxHeight: height * 0.4, minWidth: width),
          onClosing: () {},
          builder: (context) {
            return Column(
              children: [
                DropDown(
                  height: height,
                  width: width,
                  hintText: hintTextForFrequency,
                  items: Database.frequencyData,
                  onChanged: (value) {},
                  selectedItem: selectedItemForFrequency,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                DropDown(
                  height: height,
                  width: width,
                  hintText: hintTextForMonth,
                  items: Database.months,
                  onChanged: (value) {},
                  selectedItem: selectedItemForMonth,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                DropDown(
                  height: height,
                  width: width,
                  hintText: hintTextForDate,
                  items: Database.dates,
                  onChanged: (value) {},
                  selectedItem: selectedItemForDates,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                  width: width,
                  height: height,
                  text: continueButtonText,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
