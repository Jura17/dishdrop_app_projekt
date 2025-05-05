import 'dart:io';
import 'package:app_settings/app_settings.dart';

import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
import 'package:dishdrop_app_projekt/ui/widgets/file_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/network_title_img.dart';
import 'package:dishdrop_app_projekt/ui/widgets/recipe_form_screen_widgets/empty_image_picker_button.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    try {
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
    } catch (e) {
      if (e is PlatformException) {
        showCustomDialog(Platform.isIOS);
      }
    }
  }

  void showCustomDialog(bool isIos) {
    if (isIos) {
      showCupertinoDialog(context: context, builder: (context) => alertDialog());
    } else {
      showDialog(context: context, builder: (context) => alertDialog());
    }
  }

  Widget alertDialog() {
    return AlertDialog(
      title: Text('Fehlende Berechtigungen'),
      content: Text('Aktuell hast du nicht alle Berechtigungen gegeben, die diese App braucht.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            AppSettings.openAppSettings(type: AppSettingsType.location);
          },
          child: Text('Einstellungen öffnen'),
        ),
      ],
    );
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
