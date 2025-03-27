import 'dart:io';

import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/network_title_img.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  ImagePickerField({
    super.key,
    required this.updateImagesFunc,
    required this.emptyImgPickerFunc,
    required this.imagePath,
    // required this.showError,
  });

  final Function updateImagesFunc;
  final Function emptyImgPickerFunc;
  String? imagePath;
  // bool showError;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    chooseImageType();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () async {
          await pickImage();
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: AppColors.dishDropBlack),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.dishDropBlack),
                        ),
                        child: imageWidget,
                      ),
                    ),
                  ),
                  if (widget.imagePath != null && widget.imagePath!.isNotEmpty)
                    EmptyImagePickerButton(emptyImagePickerFunction: widget.emptyImgPickerFunc)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        widget.imagePath = selectedImage.path;
        if (widget.imagePath == null) {
          widget.updateImagesFunc("titleImg", "");
        } else {
          widget.updateImagesFunc("titleImg", widget.imagePath);
          // widget.showError = false;
        }
      });
    }
  }

  void chooseImageType() {
    if (widget.imagePath == null || widget.imagePath!.isEmpty) {
      imageWidget = Icon(
        Icons.camera_alt_outlined,
        size: 50,
        color: AppColors.dishDropBlack,
      );
    } else {
      if (widget.imagePath!.contains("http")) {
        imageWidget = NetworkTitleImg(imgPath: widget.imagePath!);
      } else if (widget.imagePath!.contains("assets/images/")) {
        imageWidget = Image.asset(widget.imagePath!, fit: BoxFit.cover);
      } else {
        imageWidget = FileTitleImg(imgPath: widget.imagePath!);
      }
    }
  }
}

class EmptyImagePickerButton extends StatefulWidget {
  const EmptyImagePickerButton({
    super.key,
    required this.emptyImagePickerFunction,
  });

  final Function emptyImagePickerFunction;

  @override
  State<EmptyImagePickerButton> createState() => _EmptyImagePickerButtonState();
}

class _EmptyImagePickerButtonState extends State<EmptyImagePickerButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          widget.emptyImagePickerFunction();
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.8 * 255).toInt()),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
    );
  }
}
