import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/User%20Picture/Views/user_picture_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:stacked/stacked.dart';

class UserPictureView extends StackedView<UserPictureViewModel> {
  const UserPictureView({super.key});

  // Variables
  final String title = "Complete Profile";

  @override
  Widget builder(
      BuildContext context, UserPictureViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.light40,
      appBar: blackAppBar(
        title: title,
        width: width,
        height: height,
        leading: const SizedBox(),
        backgroundColor: AppColors.light40,
      ),
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
          // Buttons
          _Buttons(
            width: width,
            height: height,
          )
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

  // Variables
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
          );
          viewModel.updateImage(img);
        },
        child: SizedBox(
          width: width * 0.555,
          height: width * 0.555,
          child: Stack(
            children: [
              // Background Violet
              Center(
                child: Container(
                  width: width * 0.555,
                  height: width * 0.555,
                  decoration: BoxDecoration(
                    color: AppColors.primaryViolet,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Background Light
              Center(
                child: Container(
                  width: width * 0.53,
                  height: width * 0.53,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Circle Background
              Center(
                child: CircleAvatar(
                  radius: width * 0.25,
                  backgroundImage: viewModel.image != null
                      ? FileImage(viewModel.image!)
                      : null,
                  backgroundColor: viewModel.image != null
                      ? Colors.transparent
                      : AppColors.light20,
                  child: viewModel.image == null
                      ? Padding(
                          padding: EdgeInsets.only(top: height * 0.038),
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

class _Buttons extends ViewModelWidget<UserPictureViewModel> {
  final double width, height;
  const _Buttons({
    required this.width,
    required this.height,
  });

  // Variables
  final String notNowButtonText = "Not Now";
  final String continueText = "Continue";

  @override
  Widget build(BuildContext context, UserPictureViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.06,
          right: width * 0.06,
          top: height * 0.4,
          bottom: height * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Not Now Button
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
              onPressed: () => viewModel.notNowButtonFunction(),
              child: viewModel.showLoadingForNotNow
                  ? SpinKitThreeBounce(
                      color: AppColors.primaryViolet,
                      size: width * 0.06,
                    )
                  : Text(
                      notNowButtonText,
                      style: TextStyle(
                        color: AppColors.primaryViolet,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          // Continue Button
          SizedBox(
            width: width * 0.35,
            height: height * 0.05,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(viewModel.showLoading
                    ? AppColors.violet20
                    : AppColors.primaryViolet),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.06),
                  ),
                ),
              ),
              onPressed: () => viewModel.continueButtonFunction(),
              child: viewModel.showLoading
                  ? SpinKitThreeBounce(
                      color: AppColors.primaryViolet,
                      size: width * 0.06,
                    )
                  : Text(
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
    );
  }
}
