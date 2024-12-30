import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_settings_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/switch_tile.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class NotificationSettingsView extends StackedView<NotificationSettingsViewModel> {
  NotificationSettingsView({super.key});

  String appBarTitle = 'Notification';
  String expenseAlertTitle = "Expense Alert";
  String expenseAlertSubtitle = "Get notification about your expense";
  String budgetAlertTitle = "Budget";
  String budgetAlertSubtitle =
      "Get notification when your budget exceed the limit";
  bool alertNotification = false;
  bool budgetAlertNotification = false;

  @override
  Widget builder(
      BuildContext context, NotificationSettingsViewModel viewModel, Widget? child) {
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
            value: alertNotification,
            title: expenseAlertTitle,
            subtitle: expenseAlertSubtitle,
            onChanged: (value) {
              alertNotification = value;
              viewModel.notifyListeners();
            },
          ),
          SwitchTile(
            value: budgetAlertNotification,
            title: budgetAlertTitle,
            subtitle: budgetAlertSubtitle,
            onChanged: (value) {
              budgetAlertNotification = value;
              viewModel.notifyListeners();
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
