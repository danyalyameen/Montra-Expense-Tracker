import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

// ignore: must_be_immutable
class FileInserter extends StatelessWidget {
  String hintText = "Add attachment";

  FileInserter({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {},
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(width * 0.03),
        color: AppColors.light20,
        strokeCap: StrokeCap.round,
        strokeWidth: width * 0.006,
        dashPattern: [width * 0.02, width * 0.02],
        child: SizedBox(
          width: width * 0.88,
          height: height * 0.065,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconsPath.attachment,
                  width: width * 0.03,
                  height: height * 0.03,
                  colorFilter: ColorFilter.mode(
                    AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Text(
                  hintText,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.045,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
