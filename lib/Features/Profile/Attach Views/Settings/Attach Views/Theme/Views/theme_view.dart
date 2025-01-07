import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Theme/Views/theme_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

class ThemeView extends StackedView<ThemeViewModel> {
  const ThemeView({super.key});
  final String appBarTitle = "Theme";

  @override
  Widget builder(
      BuildContext context, ThemeViewModel viewModel, Widget? child) {
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
          _ThemeItems(
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
  ThemeViewModel viewModelBuilder(BuildContext context) => ThemeViewModel();
}

class _ThemeItems extends StatelessWidget {
  final double width, height;
  final Function({required int index}) markSelected;
  _ThemeItems(
      {required this.width, required this.height, required this.markSelected});

  final List<Map<String, dynamic>> data = Database.themeData;
  final String themeKey = "Theme";
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
                data[index][themeKey],
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
