import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class SwitchTile extends StatefulWidget {
  final String title, subtitle;
  final Function(bool)? onChanged;
  final bool value;
  const SwitchTile(
      {super.key,
      required this.title,
      required this.subtitle,
      this.onChanged,
      required this.value});

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SwitchListTile(
      thumbColor: WidgetStatePropertyAll(AppColors.primaryLight),
      activeTrackColor: AppColors.primaryViolet,
      inactiveTrackColor: AppColors.violet40,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      title: Text(
        widget.title,
        style: TextStyle(
          color: AppColors.primaryBlack,
          fontSize: width * 0.04,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: TextStyle(
          color: AppColors.grey,
          fontSize: width * 0.035,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
