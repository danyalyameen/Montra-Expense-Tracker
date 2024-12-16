import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Widgets/custom_drop_down.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';

class DragableBottomSheet extends StatelessWidget {
  final TextEditingController descriptionController;
  final String text;
  const DragableBottomSheet(
      {super.key, required this.descriptionController, required this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
      initialChildSize: 1,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.1),
                  topRight: Radius.circular(width * 0.1))),
          child: Column(
            children: [
              const CustomDropDown(),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                controller: descriptionController,
                width: width,
                text: text,
                height: height,
              )
            ],
          ),
        );
      },
    );
  }
}
