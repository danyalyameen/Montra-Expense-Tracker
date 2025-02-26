import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Service/Options/option_service.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';

void addOption({
  required double width,
  required double height,
  required String title,
  required BuildContext context,
  required bool addExpense,
}) {
  // Variables
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Color selectedColor = AppColors.primaryGreen;
  bool error = false;
  bool showLoading = false;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.primaryLight,
            // Title
            title: Text(
              title,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Container(
              width: width * 0.8,
              height: height * 0.26,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
              child: Column(
                children: [
                  // Name Text Field
                  Form(
                    key: formKey,
                    child: CustomTextFormField(
                      controller: nameController,
                      width: width,
                      hintText: "Name",
                      height: height,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a name";
                        }
                        if (error) {
                          error = false;
                          return "Name Already Used";
                        }
                        return null;
                      },
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.015,
                  ),
                  // Color Picker
                  InkWell(
                    onTap: () {
                      showColorPicker(
                        context: context,
                        height: height,
                        width: width,
                        onColorChanged: (color) {
                          selectedColor = color;
                          setState(
                            () {},
                          );
                        },
                      );
                    },
                    child: Container(
                      width: width * 0.9,
                      height: height * 0.062,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.04),
                        border: Border.all(
                          color: AppColors.light60,
                          width: width * 0.004,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text
                          Text(
                            "Picked Color",
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // Picked Color
                          Container(
                            width: width * 0.15,
                            height: height * 0.03,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.04),
                              color: selectedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: AppColors.primaryRed,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // OK button
                      CustomElevatedButton(
                        width: width * 0.3,
                        height: height * 0.7,
                        borderRadius: width * 0.04,
                        backgroundColor: showLoading
                            ? AppColors.violet20
                            : AppColors.primaryViolet,
                        child: showLoading
                            ? SpinKitThreeBounce(
                                color: AppColors.primaryViolet,
                                size: width * 0.06,
                              )
                            : Text(
                                "OK",
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        onPressed: () async {
                          // Add Option
                          if (formKey.currentState!.validate()) {
                            if (selectedColor != AppColors.primaryGreen) {
                              OptionService optionService =
                                  locator<OptionService>();
                              showLoading = true;
                              setState(() {});
                              error = addExpense
                                  ? await optionService.addExpenseOption(
                                      color: selectedColor,
                                      name: nameController.text,
                                    )
                                  : await optionService.addIncomeOption(
                                      color: selectedColor,
                                      name: nameController.text,
                                    );
                              showLoading = false;
                              setState(() {});
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please Select Color",
                                backgroundColor: AppColors.primaryRed,
                                textColor: AppColors.primaryLight,
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void showColorPicker(
    {required BuildContext context,
    required double width,
    required double height,
    required Function(Color color) onColorChanged}) {
  showDialog(
    context: context,
    builder: (context) {
      return UnconstrainedBox(
        child: SizedBox(
          height: height * 0.685,
          width: width,
          child: AlertDialog(
            content: ColorPicker(
              pickerColor: AppColors.primaryGreen,
              onColorChanged: (color) => onColorChanged(color),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.primaryRed,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    width: width * 0.3,
                    height: height * 0.7,
                    text: "Ok",
                    borderRadius: width * 0.04,
                    textStyle: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
