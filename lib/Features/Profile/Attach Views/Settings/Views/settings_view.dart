import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({super.key});
  final String appBarTitle = "Settings";

  @override
  Widget builder(
      BuildContext context, SettingsViewModel viewModel, Widget? child) {
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
          _SettingsItems(
            width: width,
            height: height,
            navigate: ({required index}) {
              viewModel.navigation(index: index);
            },
          ),
        ],
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) =>
      SettingsViewModel();
}

class _SettingsItems extends StatelessWidget {
  final double width, height;
  final Function({required int index}) navigate;
  _SettingsItems(
      {required this.width,
      required this.height,
      required this.navigate});

  final String titleKey = "Title";
  final String defaultSelectionKey = "Default-Selection";
  final List<Map<String, dynamic>> data = Database.settingsData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              navigate(index: index);
            },
            child: ListTile(
              title: Text(
                data[index][titleKey],
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${data[index][defaultSelectionKey]}",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: width * 0.04,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  SvgPicture.asset(
                    IconsPath.rightArrow,
                    colorFilter: ColorFilter.mode(
                        AppColors.primaryViolet, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
