import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Wallets/wallet_service.dart';
import 'package:montra_expense_tracker/Widgets/custom_bottom_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

class WalletBottomSheet extends StatefulWidget {
  final Map<String, dynamic> storeSelectedWallet;
  const WalletBottomSheet({super.key, required this.storeSelectedWallet});

  @override
  State<WalletBottomSheet> createState() => _WalletState();
}

class _WalletState extends State<WalletBottomSheet> {
  final String createWallet = "Add Wallet";
  final String dropDownText = "Wallet";
  final NavigationService navigationService = locator<NavigationService>();
  final WalletService walletService = locator<WalletService>();
  final ValueNotifier itemIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return CustomBottomSheet(
      buttonsBottomHight: 0,
      buttonText: createWallet,
      buttonWidth: width * 0.3,
      bottomSheetHight: height * 0.44,
      hintText: dropDownText,
      storeSelectedItem: widget.storeSelectedWallet,
      showSelectedItemOnHintText: _ShowSelectedWallet(
        accountName: widget.storeSelectedWallet["option"],
        width: width,
      ),
      onPressed: () => navigationService.navigateToSetupWalletView(),
      showItems: SizedBox(
        height: height * 0.3,
        child: Column(
          children: [
            _ShowItemsForWallet(
              width: width,
              height: height,
              data: walletService.getWallets(),
              updateIndex: (value) {
                itemIndex.value = value;
              },
              updateHintText: (index) async {
                var data = await walletService.getWallets();
                widget.storeSelectedWallet["option"] = data[index].walletName;
                navigationService.back();
                setState(() {});
              },
            ),
            _Indicators(
              itemIndex: itemIndex,
              width: width,
              height: height,
              data: walletService.getWallets(),
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
  final Future<List<Wallets>> data;
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
      child: FutureBuilder<List<Wallets>>(
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
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
                                        colorFilter: ColorFilter.mode(
                                          AppColors.primaryViolet,
                                          BlendMode.srcIn,
                                        ),
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
  final Future<List<Wallets>> data;
  final ValueNotifier itemIndex;
  const _Indicators(
      {required this.data,
      required this.itemIndex,
      required this.width,
      required this.height});

  @override
  State<_Indicators> createState() => _IndicatorsState();
}

class _IndicatorsState extends State<_Indicators> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height * 0.04,
      child: FutureBuilder<List<Wallets>>(
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
                    snapshot.data!.length,
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
