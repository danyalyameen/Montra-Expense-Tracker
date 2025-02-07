import 'dart:io';

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/User%20Picture/user_picture_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:stacked/stacked.dart';

class UserPictureView extends StackedView<UserPictureViewModel> {
  const UserPictureView({super.key});

  final String title = "Complete Profile";
  final String continueText = "Continue";

  @override
  Widget builder(
      BuildContext context, UserPictureViewModel viewModel, Widget? child) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.light40,
      appBar: blackAppBar(
          title: title,
          width: width,
          height: height,
          leading: const Spacer(),
          backgroundColor: AppColors.light40),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User Image
          _UserImage(
            width: width,
            height: height,
          ),
          // For Spacing
          SizedBox(
            height: height * 0.04,
          ),
          // Button
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.06,
                right: width * 0.06,
                top: height * 0.4,
                bottom: height * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.35,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: WidgetStatePropertyAll(
                        BorderSide(
                          color: AppColors.primaryViolet,
                          width: width * 0.002,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        viewModel.navigationService.replaceWithSetupPinView(),
                    child: Text(
                      "Not Now",
                      style: TextStyle(
                        color: AppColors.primaryViolet,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.35,
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.primaryViolet),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.06),
                        ),
                      ),
                    ),
                    onPressed: () =>
                        viewModel.navigationService.replaceWithSetupPinView(),
                    child: Text(
                      continueText,
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  UserPictureViewModel viewModelBuilder(BuildContext context) =>
      UserPictureViewModel();
}

// ignore: must_be_immutable
class _UserImage extends ViewModelWidget<UserPictureViewModel> {
  final double width, height;
  _UserImage({required this.width, required this.height});

  File? img;

  @override
  Widget build(BuildContext context, UserPictureViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(width),
        onTap: () async {
          // Show Bottom Sheet for pick Image
          img = await ShowBottomSheetForImportImages.bottomSheet(
            context: context,
            width: width,
            height: height,
            iconKey: 'Icon',
            titleKey: 'Title',
          );
          viewModel.updateImage(img);
        },
        child: SizedBox(
          width: width * 0.5,
          height: width * 0.5,
          child: Stack(
            children: [
              // Circle Background
              Center(
                child: CircleAvatar(
                  radius: width * 0.3,
                  backgroundImage: img == null ? null : FileImage(img!),
                  child: img == null
                      ? Padding(
                          padding: EdgeInsets.only(top: height * 0.037),
                          child: ClipOval(
                            child: Icon(
                              Icons.person,
                              size: width * 0.5,
                              color: AppColors.grey,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
              // Edit Icon
              Positioned(
                bottom: height * 0.005,
                right: width * 0.02,
                child: Container(
                  width: width * 0.07,
                  height: width * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    color: AppColors.primaryViolet,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: width * 0.05,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
