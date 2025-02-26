import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Service/Image%20Picker/image_service.dart';

class FileInserter extends StatefulWidget {
  const FileInserter({super.key});

  @override
  State<FileInserter> createState() => _FileInserterState();
}

class _FileInserterState extends State<FileInserter> {
  // Variables
  final String hintText = "Add attachment";
  final String iconKey = "Icon";
  final String titleKey = "Title";
  File? img;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: img == null ? width * 0.05 : width * 0.07),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image is null then show file inserter ui otherwise image
          img == null
              ? InkWell(
                  onTap: () async {
                    img = await ShowBottomSheetForImportImages.bottomSheet(
                      context: context,
                      width: width,
                      height: height,
                    );
                    setState(() {});
                  },
                  // Border From DottedBorder Package
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(width * 0.03),
                    color: AppColors.light20,
                    strokeCap: StrokeCap.round,
                    strokeWidth: width * 0.006,
                    dashPattern: [width * 0.02, width * 0.02],
                    child: SizedBox(
                      width: width * 0.88,
                      height: height * 0.065,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon
                            SvgPicture.asset(
                              IconsPath.attachment,
                              width: width * 0.03,
                              height: height * 0.03,
                              colorFilter: ColorFilter.mode(
                                AppColors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                            // For Spacing
                            SizedBox(
                              width: width * 0.02,
                            ),
                            // Text
                            Text(
                              hintText,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.045,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                // Image with Cross to unselect or delete the image
              : SizedBox(
                  width: width * 0.8,
                  height: height * 0.1,
                  child: Stack(
                    children: [
                      // Image
                      Positioned(
                        top: height * 0.005,
                        left: width * 0.02,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          child: Image.file(
                            img!,
                            width: width * 0.3,
                          ),
                        ),
                      ),
                      // Cross or delete Icon
                      Positioned(
                        left: 0,
                        top: 0,
                        child: InkWell(
                          onTap: () {
                            img = null;
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: width * 0.03,
                            backgroundColor: AppColors.light20,
                            child: SvgPicture.asset(
                              IconsPath.close,
                              colorFilter: ColorFilter.mode(
                                AppColors.primaryBlack,
                                BlendMode.srcIn,
                              ),
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
}

// Bottom Sheet For Import Images
class ShowBottomSheetForImportImages {
  ImagePicker imagePicker = ImagePicker();
  static Future<File?> bottomSheet({
    required BuildContext context,
    required double width,
    required double height,
  }) async {
    // Variables
    File? image;
    ImageService imageService = locator<ImageService>();
    Completer<File?> completer = Completer<File?>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          showDragHandle: false,
          dragHandleColor: AppColors.violet40,
          dragHandleSize: Size(width * 0.2, height * 0.005),
          backgroundColor: AppColors.primaryLight,
          constraints:
              BoxConstraints(minHeight: height * 0.25, minWidth: width),
          onClosing: () {},
          builder: (context) {
            return SizedBox(
              width: width,
              height: height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera Option
                  ImagePickerWidget(
                    title: "Camera",
                    icon: IconsPath.camera,
                    onPressed: () async {
                      image =
                          await imageService.pickImage(pickFromCamera: true);
                      completer.complete(image);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                  ),
                  // Gallery Option
                  ImagePickerWidget(
                    title: "Gallery",
                    icon: IconsPath.gallery,
                    onPressed: () async {
                      image =
                          await imageService.pickImage(pickFromCamera: false);
                      completer.complete(image);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    return completer.future;
  }
}

// UI of Camera and Gallery
class ImagePickerWidget extends StatelessWidget {
  final String title, icon;
  final VoidCallback? onPressed;
  const ImagePickerWidget(
      {super.key, required this.title, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Get Screen Size of a Device
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width * 0.26,
        height: height * 0.1,
        margin: EdgeInsets.only(
          bottom: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: AppColors.violet20,
          borderRadius: BorderRadius.circular(
            width * 0.04,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              // Icon
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.01,
                ),
                child: SvgPicture.asset(
                  icon,
                  width: width * 0.1,
                  height: width * 0.1,
                  colorFilter: ColorFilter.mode(
                      AppColors.primaryViolet, BlendMode.srcIn),
                ),
              ),
              // For Spacing
              SizedBox(
                height: height * 0.005,
              ),
              // Text
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryViolet,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
