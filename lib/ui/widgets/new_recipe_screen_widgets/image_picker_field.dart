import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ImagePickerField extends StatelessWidget {
  const ImagePickerField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: implement image picker here
      onTap: () {},
      child: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.dishDropBlack),
          ),
          child: Icon(
            Icons.camera_alt_outlined,
            size: 50,
            color: AppColors.dishDropBlack,
          ),
        ),
      ),
    );
  }
}
