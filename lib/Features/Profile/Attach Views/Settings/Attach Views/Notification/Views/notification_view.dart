import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_view_model.dart';
import 'package:stacked/stacked.dart';

class NotificationView extends StackedView<NotificationViewModel> {
  const NotificationView({super.key});

  @override
  Widget builder(
      BuildContext context, NotificationViewModel viewModel, Widget? child) {
    return const Scaffold();
  }

  @override
  NotificationViewModel viewModelBuilder(BuildContext context) =>
      NotificationViewModel();
}
