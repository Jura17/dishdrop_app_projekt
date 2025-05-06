import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmptyImagePickerButton extends StatelessWidget {
  const EmptyImagePickerButton({
    super.key,
  });

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
