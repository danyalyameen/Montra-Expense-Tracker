import 'dart:io';

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class UserPictureViewModel extends ViewModel {
  final TextEditingController genderController = TextEditingController();
  File? image;

  void updateImage(File? newImage) {
    image = newImage;
    notifyListeners();
  }
}
