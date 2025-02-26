import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Edit%20Profile/Views/edit_profile_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_file_inserter.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class EditProfileView extends StackedView<EditProfileViewModel> {
  final String name;
  const EditProfileView({required this.name, super.key});

  // Variables
  final String appBarTitle = "Edit Profile";
  final String nameHintText = "Enter Name";
  final String continueButtonText = "Continue";

  @override
  void onViewModelReady(EditProfileViewModel viewModel) {
    viewModel.nameController.text = name;
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => false;

  @override
  Widget builder(
      BuildContext context, EditProfileViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      resizeToAvoidBottomInset: false,
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
      ),
      body: Column(
        children: [
          // For Spacing
          SizedBox(height: height * 0.06),
          // User Image
          _UserImage(width: width, height: height),
          // For Spacing
          SizedBox(height: height * 0.08),
          // Text Fields
          Form(
            key: viewModel.formKey,
            child: CustomTextFormField(
              width: width,
              height: height,
              hintText: nameHintText,
              controller: viewModel.nameController,
              validator: (value) {
                return viewModel.validateName(value);
              },
            ),
          ),
          // For Spacing
          SizedBox(height: height * 0.04),
          // Continue Button
          ValueListenableBuilder(
              valueListenable: viewModel.showLoading,
              builder: (context, value, child) {
                return CustomElevatedButton(
                  width: width,
                  height: height,
                  backgroundColor: viewModel.showLoading.value
                      ? AppColors.violet20
                      : AppColors.primaryViolet,
                  onPressed: () => viewModel.continueButtonFunction(),
                  child: viewModel.showLoading.value
                      ? SpinKitThreeBounce(
                          color: AppColors.primaryViolet,
                          size: width * 0.06,
                        )
                      : Text(
                          continueButtonText,
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              })
        ],
      ),
    );
  }

  @override
  EditProfileViewModel viewModelBuilder(BuildContext context) =>
      EditProfileViewModel();

  @override
  void onDispose(EditProfileViewModel viewModel) {
    viewModel.nameController.dispose();
    super.onDispose(viewModel);
  }
}

class _UserImage extends ViewModelWidget<EditProfileViewModel> {
  final double width, height;
  const _UserImage({required this.width, required this.height});

  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
    return UnconstrainedBox(
      child: InkWell(
        borderRadius: BorderRadius.circular(width),
        onTap: () async {
          // Show Bottom Sheet for pick Image
          viewModel.image = await ShowBottomSheetForImportImages.bottomSheet(
            context: context,
            width: width,
            height: height,
          );
          viewModel.imageError.value = false;
          viewModel.notifyListeners();
        },
        child: SizedBox(
          width: width * 0.4,
          height: width * 0.4,
          child: Stack(
            children: [
              FutureBuilder(
                future: precacheImage(
                    NetworkImage(viewModel.imageService
                        .getImage(imageName: "user", userPicture: true)),
                    context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: width * 0.37,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Make Outline Transparent
                        Container(
                          width: width * 0.38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryViolet,
                          ),
                        ),
                        // White Background
                        Container(
                          width: width * 0.34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryLight,
                          ),
                        ),
                        // user Image
                        ValueListenableBuilder(
                          valueListenable: viewModel.imageError,
                          builder: (context, value, child) {
                            return Center(
                              child: CircleAvatar(
                                radius: width * 0.16,
                                backgroundImage: viewModel.image == null
                                    ? NetworkImage(
                                        viewModel.imageService.getImage(
                                            imageName: "user",
                                            userPicture: true),
                                      )
                                    : FileImage(viewModel.image!),
                                backgroundColor: value
                                    ? AppColors.light60
                                    : Colors.transparent,
                                onBackgroundImageError:
                                    (exception, stackTrace) {
                                  viewModel.imageError.value = true;
                                },
                                child: value
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: height * 0.024),
                                        child: ClipOval(
                                          child: Icon(
                                            Icons.person,
                                            size: width * 0.32,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
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
