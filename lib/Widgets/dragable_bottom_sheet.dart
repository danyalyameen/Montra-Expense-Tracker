import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

// ignore: must_be_immutable
class DragableBottomSheet extends StatelessWidget {
  final List<Widget> children;
  const DragableBottomSheet({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          child: Column(children: children),
        );
      },
    );
  }
}
