import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';

class Delete {
  static bool showLoading = false;
  static void showSheet({
    required BuildContext context,
    required double width,
    required double height,
    required String title,
    required String subtitle,
    VoidCallback? onPressed,
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
              BoxConstraints(maxHeight: height * 0.35, minWidth: width),
          onClosing: () {},
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.425,
                          height: height * 0.06,
                          child: CustomElevatedButton(
                            width: width,
                            height: height,
                            text: "No",
                            backgroundColor: AppColors.violet20,
                            textStyle: TextStyle(
                              color: AppColors.primaryViolet,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        SizedBox(
                          width: width * 0.425,
                          height: height * 0.06,
                          child: CustomElevatedButton(
                            width: width,
                            height: height,
                            backgroundColor: showLoading
                                ? AppColors.violet20
                                : AppColors.primaryViolet,
                            child: showLoading
                                ? SpinKitThreeBounce(
                                    color: AppColors.primaryViolet,
                                    size: width * 0.04,
                                  )
                                : Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: AppColors.primaryLight,
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            onPressed: () async {
                              showLoading = true;
                              setState(() {});
                              onPressed?.call();
                              showLoading = false;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            });
          },
        );
      },
    );
  }
}
