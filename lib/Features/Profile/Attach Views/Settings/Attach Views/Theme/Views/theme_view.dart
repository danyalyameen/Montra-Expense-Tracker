import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Theme/Views/theme_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class ThemeView extends StackedView<ThemeViewModel> {
  ThemeView({super.key});
  String appBarTitle = "Theme";
  String themeKey = "Theme";
  String isSelectKey = "isSelect";

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
          ThemeItems(
            data: Database.themeData,
            width: width,
            height: height,
            themeKey: themeKey,
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
  ThemeViewModel viewModelBuilder(BuildContext context) => ThemeViewModel();
}

class ThemeItems extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double width, height;
  final String themeKey, isSelectKey;
  final Function({required int index}) markSelected;
  const ThemeItems(
      {super.key,
      required this.data,
      required this.width,
      required this.height,
      required this.themeKey,
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
                data[index][themeKey],
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
