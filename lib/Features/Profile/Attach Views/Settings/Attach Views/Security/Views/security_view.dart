import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Security/Views/security_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

class SecurityView extends StackedView<SecurityViewModel> {
  const SecurityView({super.key});
  final String appBarTitle = "Security";

  @override
  Widget builder(
      BuildContext context, SecurityViewModel viewModel, Widget? child) {
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
          _SecurityItems(
            width: width,
            height: height,
            markSelected: ({required index}) {
              viewModel.markSelected(index);
            },
          ),
        ],
      ),
    );
  }

  @override
  SecurityViewModel viewModelBuilder(BuildContext context) =>
      SecurityViewModel();
}

class _SecurityItems extends StatelessWidget {
  final double width, height;
  final Function({required int index}) markSelected;
  _SecurityItems(
      {required this.width, required this.height, required this.markSelected});

  final List<Map<String, dynamic>> data = Database.securityData;
  final String securityKey = "Security";
  final String isSelectKey = "isSelect";

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
                data[index][securityKey],
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: data[index][isSelectKey] == true
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
