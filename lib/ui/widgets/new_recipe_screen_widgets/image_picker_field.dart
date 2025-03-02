import 'dart:io';

import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  const ImagePickerField({
    super.key,
    required this.updateImagesFunc,
  });

  final Function updateImagesFunc;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  String? imagePath;

  Future<void> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        imagePath = selectedImage.path;
        imagePath == null
            ? widget.updateImagesFunc("titleImg", "")
            : widget.updateImagesFunc("titleImg", imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          pickImage();
        },
        child: Center(
          child: Stack(
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
                    child: imagePath == null
                        ? Icon(
                            Icons.camera_alt_outlined,
                            size: 50,
                            color: AppColors.dishDropBlack,
                          )
                        : Image.file(File(imagePath!), fit: BoxFit.cover),
                  ),
                ),
              ),
              EmptyImagePickerButton(emptyImagePickerFunction: emptyImagePicker)
            ],
          ),
        ),
      ),
    );
  }

  void emptyImagePicker() {
    setState(() {
      imagePath = null;
      widget.updateImagesFunc("titleImg", "");
    });
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
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.8 * 255).toInt()),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 35,
          ),
        ),
      ),
    );
  }
}
