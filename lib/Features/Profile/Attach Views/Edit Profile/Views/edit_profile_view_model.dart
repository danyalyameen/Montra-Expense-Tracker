import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class EditProfileViewModel extends ViewModel {
  // Final Fields
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Non Final Variables
  ValueNotifier<bool> showLoading = ValueNotifier(false);
  ValueNotifier<bool> imageError = ValueNotifier(false);
  File? image;

  // Validation Functions
  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Name";
    }
    return null;
  }

  // Continue Button Logic
  void continueButtonFunction() async {
    if (formKey.currentState!.validate()) {
      try {
        showLoading.value = true;
        if (image != null) {
          await imageService.deleteImage(userPicture: true, imageName: "user");
          imageService.uploadImage(
              userPicture: true, imageFile: image, imageUploadName: "user");
        }
        await firestore.doc(auth.getUser()!.uid).update(
              PersonData(
                      name: nameController.text, imageUploaded: image != null)
                  .receive(),
            );
        showLoading.value = false;
        Fluttertoast.showToast(
          msg: "Profile Updated Successfully",
          backgroundColor: AppColors.grey,
          textColor: AppColors.light60,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
        );
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
