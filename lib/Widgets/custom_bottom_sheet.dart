import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget showItems;
  final String hintText, buttonText;
  final Widget showSelectedItemOnHintText;
  final double bottomSheetHight, buttonWidth, buttonsBottomHight;
  final Map<String, dynamic> storeSelectedItem;
  final VoidCallback? onPressed;
  const CustomBottomSheet({
    super.key,
    required this.hintText,
    required this.showSelectedItemOnHintText,
    required this.storeSelectedItem,
    required this.showItems,
    required this.bottomSheetHight,
    required this.buttonText,
    required this.buttonWidth,
    required this.buttonsBottomHight,
    this.onPressed,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // Get Screen Size of a Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        BottomSheet.showBottomSheet(
          buttonsBottomHight: widget.buttonsBottomHight,
          buttonText: widget.buttonText,
          buttonWidth: widget.buttonWidth,
          showItems: widget.showItems,
          width: width,
          height: widget.bottomSheetHight,
          context: context,
          selectedCategory: widget.storeSelectedItem,
          onPressed: widget.onPressed,
        );
      },
      child: Container(
        width: width * 0.9,
        height: height * 0.07,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(width * 0.04),
          border: Border.all(color: AppColors.light60, width: width * 0.004),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Show Selected Category
            Padding(
              padding: EdgeInsets.only(left: width * 0.04),
              child: widget.storeSelectedItem["option"] == widget.hintText
                  ? Text(
                      widget.hintText,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : widget.showSelectedItemOnHintText,
            ),
            // Icon
            Padding(
              padding: EdgeInsets.only(right: width * 0.035),
              child: SvgPicture.asset(
                IconsPath.dropdownArrow,
                colorFilter:
                    const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheet {
  static void showBottomSheet({
    required double width,
    required double height,
    required double buttonWidth,
    required double buttonsBottomHight,
    required String buttonText,
    required BuildContext context,
    required Map<String, dynamic> selectedCategory,
    required Widget showItems,
    VoidCallback? onPressed,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // White Colors Container Sheet
        return Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 0.05),
              topRight: Radius.circular(width * 0.05),
            ),
          ),
          child: Column(
            children: [
              // Items Shown By User
              showItems,
              Padding(
                padding: EdgeInsets.only(bottom: buttonsBottomHight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel Button
                    SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppColors.violet20),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: AppColors.primaryViolet),
                        ),
                      ),
                    ),
                    // Ok Button
                    SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            AppColors.primaryViolet,
                          ),
                        ),
                        onPressed: onPressed,
                        child: Text(
                          buttonText,
                          style: TextStyle(color: AppColors.primaryLight),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
