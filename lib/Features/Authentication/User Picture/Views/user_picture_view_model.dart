import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class UserPictureViewModel extends ViewModel {
  // Non Final Fields
  File? _image;
  bool _showLoading = false;
  bool _showLoadingForNotNow = false;
  // Get Non Final Fields
  File? get image => _image;
  bool get showLoading => _showLoading;
  bool get showLoadingForNotNow => _showLoadingForNotNow;
  
  // Store Selected Image in image Variables
  void updateImage(File? newImage) {
    _image = newImage;
    notifyListeners();
  }
   
  // Not Now Button Function
  void notNowButtonFunction() async {
    // Show Loading
    _showLoadingForNotNow = true;
    notifyListeners();
    // Make image uploaded false
    await firestore
        .doc(auth.getUser()!.uid)
        .update(PersonData(imageUploaded: false).receive());
    // Hide Loading
    _showLoadingForNotNow = false;
    notifyListeners();
    // Navigate to Setup Pin
    navigationService.replaceWithSetupPinView();
  }
  
  // Continue Button Function
  void continueButtonFunction() async {
    if (image != null) {
      // Show Loading
      _showLoading = true;
      notifyListeners();
      // Upload Image
      imageService.uploadImage(
        userPicture: true,
        imageUploadName: "user",
        imageFile: image,
      );
      // Make Image Uploaded True
      await firestore
          .doc(auth.getUser()!.uid)
          .update(PersonData(imageUploaded: true).receive());
      // Hide Loading
      _showLoading = false;
      notifyListeners();
      // Navigate to Setup Pin
      navigationService.replaceWithSetupPinView();
    } else {
      Fluttertoast.showToast(
        msg: "No Image Selected",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColors.primaryLight,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
