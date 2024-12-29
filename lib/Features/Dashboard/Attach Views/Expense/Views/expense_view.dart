import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_bottom_sheet.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
import 'package:montra_expense_tracker/Widgets/white_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class ExpenseView extends StackedView<ExpenseViewModel> {
  ExpenseView({super.key});

  String continueButtonText = "Continue";
  String appBarTitle = "Expense";
  String createCategoryButtonText = "Create Category";
  String categoryDropDownHintText = "Category";
  String descriptionTextFieldHintText = "Description";
  String addWalletButtonText = "Add Wallet";
  String walletDropDownHintText = "Wallet";
  String categoryOptionsCategoryKey = "Category";
  String categoryOptionsColorKey = "Colors";
  String walletOptionsBankNameKey = "Wallet";
  String walletOptionsAccountBalanceKey = "Balance";
  String walletOptionsAccountTypeKey = "Account Type";
  String walletOptionsBankPictureKey = "Picture";
  String switchTitleText = "Repeat";
  String switchSubTitleText = "Repeat transaction";
  String hintTextForFrequency = "Frequency";
  String hintTextForMonth = "Month";
  String hintTextForDate = "Date";

  @override
  Widget builder(
      BuildContext context, ExpenseViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primaryRed,
        appBar: whiteAppBar(
          title: appBarTitle,
          width: width,
          height: height,
          backgroundColor: AppColors.primaryRed,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Balance(),
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
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: CustomBottomSheet(
                        buttonsBottomHight: height * 0.035,
                        buttonText: createCategoryButtonText,
                        buttonWidth: width * 0.38,
                        bottomSheetHight: height * 0.25,
                        hintText: categoryDropDownHintText,
                        showItems: ShowItemsForCategory(
                          categoryKey: categoryOptionsCategoryKey,
                          colorsKey: categoryOptionsColorKey,
                          width: width,
                          height: height,
                          categoryOptions: Database.categoryOptions,
                          updateCategory: (index) {
                            viewModel.updateCategoryHintText(index: index);
                          },
                        ),
                        showSelectedItemOnHintText: ShowSelectedCategory(
                          colorsKey: categoryOptionsColorKey,
                          width: width,
                          height: height,
                          storeSelectedCategory:
                              viewModel.storeSelectedCategory,
                        ),
                        storeSelectedItem: viewModel.storeSelectedCategory,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
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
                    CustomBottomSheet(
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
                    SwitchTile(
                      title: switchTitleText,
                      subtitle: switchSubTitleText,
                      value: viewModel.isRepeat,
                      onChanged: (value) {
                        Database.addDataToDates();
                        viewModel.toggleSwitch(value);
                        RepeatDialog.bottomSheet(
                          context: context,
                          width: width,
                          height: height,
                          selectedItemForFrequency:
                              viewModel.selectedItemForFrequency,
                          selectedItemForMonth: viewModel.selectedItemForMonth,
                          selectedItemForDates: viewModel.selectedItemForDate,
                          hintTextForFrequency: hintTextForFrequency,
                          hintTextForMonth: hintTextForMonth,
                          hintTextForDate: hintTextForDate,
                          continueButtonHintText: continueButtonText,
                        );
                      },
                    ),
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
      ),
    );
  }

  @override
  ExpenseViewModel viewModelBuilder(BuildContext context) => ExpenseViewModel();
}

// ignore: must_be_immutable
class Balance extends StatelessWidget {
  Balance({super.key});

  String inputHintText = "How much?";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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

class ShowSelectedCategory extends StatelessWidget {
  final double width, height;
  final Map<String, dynamic> storeSelectedCategory;
  final String colorsKey;
  const ShowSelectedCategory(
      {super.key,
      required this.width,
      required this.height,
      required this.storeSelectedCategory,
      required this.colorsKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
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
                storeSelectedCategory[Variables.universalItemKey],
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
                backgroundColor: storeSelectedCategory[colorsKey],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowItemsForCategory extends StatelessWidget {
  final double width, height;
  final List<Map<String, dynamic>> categoryOptions;
  final Function(int index) updateCategory;
  final String colorsKey;
  final String categoryKey;
  const ShowItemsForCategory({
    super.key,
    required this.width,
    required this.height,
    required this.categoryOptions,
    required this.updateCategory,
    required this.colorsKey,
    required this.categoryKey,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryOptions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.057),
            child: InkWell(
              onTap: () {
                updateCategory(index);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryBlack,
                      width: width * 0.002,
                    ),
                    borderRadius: BorderRadius.circular(width * 0.08)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        categoryOptions[index]["Category"],
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
                        backgroundColor: categoryOptions[index][colorsKey],
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

class RepeatDialog {
  static void bottomSheet({
    required BuildContext context,
    required double width,
    required double height,
    required String selectedItemForFrequency,
    required String selectedItemForMonth,
    required String selectedItemForDates,
    required String hintTextForFrequency,
    required String hintTextForMonth,
    required String hintTextForDate,
    required String continueButtonHintText,
  }) {
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
                  text: continueButtonHintText,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
