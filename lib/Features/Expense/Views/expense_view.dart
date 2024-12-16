import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Expense/Views/expense_view_model.dart';
import 'package:montra_expense_tracker/Widgets/dragable_bottom_sheet.dart';
import 'package:stacked/stacked.dart';

class ExpenseView extends StackedView<ExpenseViewModel> {
  const ExpenseView({super.key});

  @override
  Widget builder(
      BuildContext context, ExpenseViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryRed,
        appBar: AppBar(
          backgroundColor: AppColors.primaryRed,
          title: const Text("Expense"),
          leading: SvgPicture.asset(IconsPath.leftArrow),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Balance(),
            Expanded(
              child: DragableBottomSheet(
                descriptionController: viewModel.descriptionController,
                text: "Description",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ExpenseViewModel viewModelBuilder(BuildContext context) => ExpenseViewModel();
}

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: width * 0.3, left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How much?",
            style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
                color: AppColors.light80.withOpacity(0.6)),
          ),
          Text(
            "\$${Variables.balance.ceil()}",
            style: TextStyle(
                fontSize: width * 0.16,
                fontWeight: FontWeight.w600,
                color: AppColors.light80),
          ),
        ],
      ),
    );
  }
}
