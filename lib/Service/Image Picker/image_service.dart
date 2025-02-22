import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService {
  SupabaseStorageClient storage = Supabase.instance.client.storage;
  ImagePicker imagePicker = ImagePicker();
  File? _image;
  File? get image => _image;

  Future<File?> pickImage({required bool pickFromCamera}) async {
    XFile? imageFile = await imagePicker.pickImage(
      source: pickFromCamera ? ImageSource.camera : ImageSource.gallery,
    );
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

  Future<void> uploadImage(
      {required bool userPicture,
      required String imageUploadName,
      required File? imageFile}) async {
    String bucketName = "Users";
    String userFolderName = AuthService().getUser()!.uid;
    String imageFolderName = userPicture ? "User Image" : "Transaction Images";
    String imagePath = "$userFolderName/$imageFolderName/$imageUploadName";
    if (imageFile != null) {
      File image = File(imageFile.path);
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

  String getImage({
    required bool userPicture,
    required String imageName,
  }) {
    String bucketName = "Users";
    String userFolderName = AuthService().getUser()!.uid;
    String imageFolderName = userPicture ? "User Image" : "Transaction Images";
    String imagePath = "$userFolderName/$imageFolderName/$imageName";
    String url = storage.from(bucketName).getPublicUrl(imagePath);
    String strictUrl = "$url?t=${DateTime.now().millisecondsSinceEpoch}";
    return strictUrl;
  }

  Future<void> deleteImage({
    required bool userPicture,
    required String imageName,
  }) async {
    String bucketName = "Users";
    String userFolderName = AuthService().getUser()!.uid;
    String imageFolderName = userPicture ? "User Image" : "Transaction Images";
    String imagePath = "$userFolderName/$imageFolderName/$imageName";
    await storage.from(bucketName).remove([imagePath]);
  }
}
