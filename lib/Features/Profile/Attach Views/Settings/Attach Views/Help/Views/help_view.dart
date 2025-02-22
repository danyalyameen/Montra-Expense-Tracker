import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:stacked/stacked.dart';

class HelpView extends StackedView<HelpViewModel> {
  const HelpView({super.key});

  final String appBarTitle = "Help";

  @override
  Widget builder(BuildContext context, HelpViewModel viewModel, Widget? child) {
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
  HelpViewModel viewModelBuilder(BuildContext context) => HelpViewModel();
}
