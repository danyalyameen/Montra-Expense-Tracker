import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view_model.dart';
import 'package:stacked/stacked.dart';

class AboutView extends StackedView<AboutViewModel> {
  const AboutView({super.key});

  @override
  Widget builder(
      BuildContext context, AboutViewModel viewModel, Widget? child) {
    return const Scaffold();
  }

  @override
  AboutViewModel viewModelBuilder(BuildContext context) => AboutViewModel();
}
