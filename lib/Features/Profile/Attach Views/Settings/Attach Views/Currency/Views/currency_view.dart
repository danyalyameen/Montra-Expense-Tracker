import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class CurrencyView extends StackedView<CurrencyViewModel> {
  CurrencyView({super.key});
  String appBarTitle = "Currency";
  String currencyKey = "Currency";
  String isSelectKey = "isSelect";

  @override
  Widget builder(
      BuildContext context, CurrencyViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () => viewModel.navigationService.back(),
      ),
      body: Column(
        children: [
          Divider(
            color: AppColors.light20,
            thickness: width * 0.002,
          ),
          CurrencyItems(
            data: Database.currencyData,
            width: width,
            height: height,
            currencyKey: currencyKey,
            isSelectKey: isSelectKey,
            markSelected: ({required index}) {
              viewModel.markSelected(index);
            },
          ),
        ],
      ),
    );
  }

  @override
  CurrencyViewModel viewModelBuilder(BuildContext context) =>
      CurrencyViewModel();
}

class CurrencyItems extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double width, height;
  final String currencyKey, isSelectKey;
  final Function({required int index}) markSelected;
  const CurrencyItems(
      {super.key,
      required this.data,
      required this.width,
      required this.height,
      required this.currencyKey,
      required this.isSelectKey,
      required this.markSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              markSelected(index: index);
            },
            child: ListTile(
              title: Text(
                data[index][currencyKey],
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: data[index]["isSelect"] == true
                  ? SvgPicture.asset(
                      IconsPath.success,
                      colorFilter: ColorFilter.mode(
                          AppColors.primaryViolet, BlendMode.srcIn),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
