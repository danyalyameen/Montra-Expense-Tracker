import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view_model.dart';
import 'package:stacked/stacked.dart';

class HelpView extends StackedView<HelpViewModel> {
  const HelpView({super.key});

  @override
  Widget builder(BuildContext context, HelpViewModel viewModel, Widget? child) {
    return const Scaffold();
  }

  @override
  HelpViewModel viewModelBuilder(BuildContext context) => HelpViewModel();
}
