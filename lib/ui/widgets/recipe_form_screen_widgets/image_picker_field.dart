import 'dart:io';

import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/network_title_img.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ImagePickerField extends StatefulWidget {
  const ImagePickerField({
    super.key,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  late Widget imageWidget;
  late RecipeFormProvider recipeFormProvider;

  @override
  Widget build(BuildContext context) {
    recipeFormProvider = context.watch<RecipeFormProvider>();
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
                  if (recipeFormProvider.imagePath != null && recipeFormProvider.imagePath!.isNotEmpty)
                    EmptyImagePickerButton()
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
      recipeFormProvider.imagePath = (await saveImagePermanently(selectedImage)).path;

      setState(() {
        if (recipeFormProvider.imagePath == null) {
          recipeFormProvider.updateImage("titleImg", "");
        } else {
          recipeFormProvider.updateImage("titleImg", recipeFormProvider.imagePath!);
        }
      });
    }
  }

  Future<File> saveImagePermanently(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = image.name; // Keep original name
    final imagePath = File('${directory.path}/$name');
    return File(image.path).copy(imagePath.path);
  }

  void chooseImageType() {
    if (recipeFormProvider.imagePath == null || recipeFormProvider.imagePath!.isEmpty) {
      imageWidget = Icon(
        Icons.camera_alt_outlined,
        size: 50,
        color: AppColors.dishDropBlack,
      );
    } else {
      if (recipeFormProvider.imagePath!.contains("http")) {
        imageWidget = NetworkTitleImg(imgPath: recipeFormProvider.imagePath!);
      } else if (recipeFormProvider.imagePath!.contains("assets/images/")) {
        imageWidget = Image.asset(recipeFormProvider.imagePath!, fit: BoxFit.cover);
      } else {
        imageWidget = FileTitleImg(imgPath: recipeFormProvider.imagePath!);
      }
    }
  }
}

class EmptyImagePickerButton extends StatefulWidget {
  const EmptyImagePickerButton({
    super.key,
  });

  @override
  State<EmptyImagePickerButton> createState() => _EmptyImagePickerButtonState();
}

class _EmptyImagePickerButtonState extends State<EmptyImagePickerButton> {
  @override
  Widget build(BuildContext context) {
    final recipeFormProvider = context.read<RecipeFormProvider>();

    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          recipeFormProvider.emptyImagePicker();
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
