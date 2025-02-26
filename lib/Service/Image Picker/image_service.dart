import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService {
  // Instances
  SupabaseStorageClient storage = Supabase.instance.client.storage;
  ImagePicker imagePicker = ImagePicker();
  // Image
  File? _image;
  File? get image => _image;
  
  // Pick Image
  Future<File?> pickImage({required bool pickFromCamera}) async {
    // Open Camera or Gallery
    XFile? imageFile = await imagePicker.pickImage(
      source: pickFromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    // Store Image
    if (imageFile != null) {
      _image = File(imageFile.path);
      return _image;
    } else {
      Fluttertoast.showToast(
        msg: "No Image Selected",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColors.primaryLight,
        toastLength: Toast.LENGTH_LONG,
      );
      return null;
    }
  }
  
  // Upload Image
  Future<void> uploadImage(
      {required bool userPicture,
      required String imageUploadName,
      required File? imageFile}) async {
    // Creating Path
    String bucketName = "Users";
    String userFolderName = AuthService().getUser()!.uid;
    String imageFolderName = userPicture ? "User Image" : "Transaction Images";
    String imagePath = "$userFolderName/$imageFolderName/$imageUploadName";
    if (imageFile != null) {
      // Convert Xfile to File
      File image = File(imageFile.path);
      // Upload the Image
      await storage.from(bucketName).upload(imagePath, image);
      _image = null;
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
  
  // Get user Image
  String getImage({
    required bool userPicture,
    required String imageName,
  }) {
    // Path
    String bucketName = "Users";
    String userFolderName = AuthService().getUser()!.uid;
    String imageFolderName = userPicture ? "User Image" : "Transaction Images";
    String imagePath = "$userFolderName/$imageFolderName/$imageName";
    String url = storage.from(bucketName).getPublicUrl(imagePath);
    // Make Strict URL for instant reload
    String strictUrl = "$url?t=${DateTime.now().millisecondsSinceEpoch}";
    return strictUrl;
  }
  
  // Delete Image
  Future<void> deleteImage({
    required bool userPicture,
    required String imageName,
  }) async {
    // Path
    String bucketName = "Users";
    String userFolderName = AuthService().getUser()!.uid;
    String imageFolderName = userPicture ? "User Image" : "Transaction Images";
    String imagePath = "$userFolderName/$imageFolderName/$imageName";
    // Delete Image
    await storage.from(bucketName).remove([imagePath]);
  }
}
