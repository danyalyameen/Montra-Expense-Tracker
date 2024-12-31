import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_settings_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
import 'package:stacked/stacked.dart';

class NotificationSettingsView
    extends StackedView<NotificationSettingsViewModel> {
  const NotificationSettingsView({super.key});

  final String appBarTitle = 'Notification';
  final String expenseAlertTitle = "Expense Alert";
  final String expenseAlertSubtitle = "Get notification about your expense";
  final String budgetAlertTitle = "Budget";
  final String budgetAlertSubtitle =
      "Get notification when your budget exceed the limit";

  @override
  Widget builder(BuildContext context, NotificationSettingsViewModel viewModel,
      Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        height: height,
        width: width,
        onTap: () {
          viewModel.navigationService.back();
        },
      ),
      body: Column(
        children: [
          SwitchTile(
            value: viewModel.alertNotification,
            title: expenseAlertTitle,
            subtitle: expenseAlertSubtitle,
            onChanged: (value) {
              viewModel.updateExpense(value);
            },
          ),
          SwitchTile(
            value: viewModel.budgetAlertNotification,
            title: budgetAlertTitle,
            subtitle: budgetAlertSubtitle,
            onChanged: (value) {
              viewModel.updateBudget(value);
            },
          ),
        ],
      ),
    );
  }

  @override
  NotificationSettingsViewModel viewModelBuilder(BuildContext context) =>
      NotificationSettingsViewModel();
}
