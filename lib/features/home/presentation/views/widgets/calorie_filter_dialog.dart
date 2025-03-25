import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/core/ui/app_styles_fonts.dart';

class CalorieFilterDialog extends StatefulWidget {
  final int initialMin;
  final int initialMax;
  final ValueChanged<RangeValues> onFilterApplied;

  const CalorieFilterDialog({
    super.key,
    required this.initialMin,
    required this.initialMax,
    required this.onFilterApplied,
  });

  @override
  State<CalorieFilterDialog> createState() => _CalorieFilterDialogState();
}

class _CalorieFilterDialogState extends State<CalorieFilterDialog> {
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    _currentRange = RangeValues(
      widget.initialMin.toDouble(),
      widget.initialMax.toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Filter by Calories',
        style: context.bodyLarge.copyWith(
          color: AppColors.secondaryTextColor,
          fontWeight: AppFonts.weights.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_currentRange.start.round()} kcal',
                    style:
                        context.caption.copyWith(fontWeight: FontWeight.bold)),
                Text('${_currentRange.end.round()} kcal',
                    style:
                        context.caption.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          RangeSlider(
            values: _currentRange,
            min: 25,
            max: 10000,
            divisions: 100,
            onChanged: (values) => setState(() => _currentRange = values),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
          ),
          onPressed: () {
            widget.onFilterApplied(_currentRange);
            Navigator.pop(context);
          },
          child: Text(
            'Apply',
            style: context.caption.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
