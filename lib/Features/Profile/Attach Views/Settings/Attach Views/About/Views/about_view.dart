import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class AboutView extends StackedView<AboutViewModel> {
  AboutView({super.key});

  String appBarTitle = "About";

  @override
  Widget builder(
      BuildContext context, AboutViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () => viewModel.navigationService.back(),
      ),
    );
  }

  @override
  AboutViewModel viewModelBuilder(BuildContext context) => AboutViewModel();
}
