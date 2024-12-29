import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

// ignore: must_be_immutable
class FileInserter extends StatelessWidget {
  FileInserter({super.key});

  String hintText = "Add attachment";
  String iconKey = "Icon";
  String titleKey = "Title";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        ShowBottomSheetForImportImages.bottomSheet(
          context: context,
          width: width,
          height: height,
          iconKey: iconKey,
          titleKey: titleKey,
        );
      },
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

class ShowBottomSheetForImportImages {
  static void bottomSheet({
    required BuildContext context,
    required double width,
    required double height,
    required String iconKey,
    required String titleKey,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          showDragHandle: true,
          dragHandleColor: AppColors.violet40,
          dragHandleSize: Size(width * 0.2, height * 0.005),
          backgroundColor: AppColors.primaryLight,
          constraints:
              BoxConstraints(minHeight: height * 0.25, minWidth: width),
          onClosing: () {},
          builder: (context) {
            return SizedBox(
              width: width,
              height: height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) {
                    return Container(
                      width: width * 0.3,
                      height: height * 0.1,
                      margin: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.violet20,
                        borderRadius: BorderRadius.circular(
                          width * 0.02,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.01,
                              ),
                              child: SvgPicture.asset(
                                Database.attachmentData[index][iconKey],
                                width: width * 0.1,
                                height: width * 0.1,
                                colorFilter: ColorFilter.mode(
                                    AppColors.primaryViolet, BlendMode.srcIn),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              Database.attachmentData[index][titleKey],
                              style: TextStyle(
                                color: AppColors.primaryViolet,
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
