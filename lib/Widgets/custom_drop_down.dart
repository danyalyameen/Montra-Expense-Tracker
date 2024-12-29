import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

class DropDown extends StatelessWidget {
  final double width, height;
  final String hintText, selectedItem;
  final List<String> items;
  final Function(String value) onChanged;
  const DropDown({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
    required this.onChanged,
    required this.selectedItem,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        width: width * 0.9,
        height: height * 0.068,
        padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
        decoration: BoxDecoration(
          border: Border.all(
            width: width * 0.004,
            color: AppColors.light60,
          ),
          borderRadius: BorderRadius.circular(width * 0.04),
        ),
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(width * 0.04),
          hint: Text(
            selectedItem.isEmpty ? hintText : selectedItem,
            style: TextStyle(
              color: selectedItem.isEmpty
                  ? AppColors.grey
                  : AppColors.primaryBlack,
              fontSize: width * 0.0405,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: SvgPicture.asset(
            IconsPath.dropdownArrow,
            colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
          ),
          items: items.map<DropdownMenuItem<String>>(
            (e) {
              return DropdownMenuItem(
                value: e.toString(),
                child: Text(
                  e.toString(),
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (value) => onChanged(value!),
        ),
      ),
    );
  }
}
