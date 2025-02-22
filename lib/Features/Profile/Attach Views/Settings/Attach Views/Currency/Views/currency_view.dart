import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

class CurrencyView extends StackedView<CurrencyViewModel> {
  const CurrencyView({super.key});
  final String appBarTitle = "Currency";

  @override
  Widget builder(
      BuildContext context, CurrencyViewModel viewModel, Widget? child) {
    // Get Screen Size of a Device
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
          // Top Line
          Divider(
            color: AppColors.light20,
            thickness: width * 0.002,
          ),
          // Currency Items
          _CurrencyItems(
            width: width,
            height: height,
            markSelected: ({required index}) {
              viewModel.markSelected(index, context);
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

class _CurrencyItems extends StatelessWidget {
  final double width, height;
  final Function({required int index}) markSelected;
  _CurrencyItems(
      {required this.width, required this.height, required this.markSelected});
  
  // Variables
  final String currencyKey = "Currency";
  final String isSelectKey = "isSelect";
  final List<Map<String, dynamic>> data = Database.currencyData;

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
              // Title
              title: Text(
                data[index][currencyKey],
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Trailing Icon of Tick
              trailing: data[index][isSelectKey] == true
                  ? SvgPicture.asset(
                      IconsPath.success,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryViolet,
                        BlendMode.srcIn,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
