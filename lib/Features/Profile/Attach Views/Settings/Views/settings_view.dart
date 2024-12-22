import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class SettingsView extends StackedView<SettingsViewModel> {
  SettingsView({super.key});
  String appBarTitle = "Settings";
  String titleKey = "Title";
  String defaultSelectionKey = "Default-Selection";

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
          SettingsItems(
            data: Database.settingsData,
            width: width,
            height: height,
            titleKey: titleKey,
            defaultSelectionKey: defaultSelectionKey,
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

class SettingsItems extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double width, height;
  final String titleKey, defaultSelectionKey;
  final Function({required int index}) navigate;
  const SettingsItems(
      {super.key,
      required this.data,
      required this.width,
      required this.height,
      required this.titleKey,
      required this.defaultSelectionKey,
      required this.navigate});

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
