import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/core/ui/app_styles_fonts.dart';
import 'package:mealmate/core/utils/app_strings.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';
import 'package:mealmate/features/meals/presentation/manager/meal%20cubit/meal_cubit.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.mealModel});
  final Meal mealModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 12.w,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: mealModel.imagePath.isNotEmpty
                    ? FileImage(File(mealModel.imagePath))
                    : null,
                child: mealModel.imagePath.isEmpty
                    ? const Icon(Icons.add_a_photo, size: 50)
                    : null,
              ),
              MealItemDetailColumn(
                meal: mealModel,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    AppStrings.areYouSure,
                    style:
                        context.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                  ),
                  content: Text(
                    AppStrings.deleteMealConfirmation,
                    style: context.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(AppStrings.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<MealCubit>().deleteMeal(mealModel.id);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        AppStrings.delete,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}

class MealItemDetailColumn extends StatelessWidget {
  const MealItemDetailColumn({
    super.key,
    required this.meal,
  });
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('HH:mm | dd/MMM').format(meal.time);
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          meal.name,
          style: AppFonts.style(
            context: context,
            size: AppFonts.sizes.s18,
            weight: AppFonts.weights.normal,
            color: AppColors.secondaryTextColor,
          ),
        ),
        Row(
          spacing: 12,
          children: [
            Text('${meal.calories} kcal', style: context.caption),
            const Text('•'),
            Text(
              formattedDate,
              style: context.caption,
            ),
          ],
        ),
      ],
    );
  }
}
