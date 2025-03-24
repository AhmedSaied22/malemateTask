import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mealmate/core/extensions/font_styles_extensions.dart';
import 'package:mealmate/core/extensions/media_query_extensions.dart';
import 'package:mealmate/core/ui/app_colors.dart';
import 'package:mealmate/core/ui/widgets/custom_snack_bar.dart';
import 'package:mealmate/core/ui/widgets/custom_text_field.dart';
import 'package:mealmate/core/utils/app_strings.dart';
import 'package:mealmate/features/meals/data/model/meal_model.dart';
import 'package:mealmate/features/meals/presentation/manager/cubit/meal_cubit.dart';
import 'package:uuid/uuid.dart';

class AddMealForm extends StatefulWidget {
  const AddMealForm({super.key});

  @override
  State<AddMealForm> createState() => _AddMealFormState();
}

class _AddMealFormState extends State<AddMealForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _timeController = TextEditingController();

  String _imagePath = '';
  DateTime _selectedTime = DateTime.now();
  bool _showImageError = false;

  @override
  void initState() {
    super.initState();
    _timeController.text = DateFormat('HH:mm | dd/MMM').format(_selectedTime);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
          _showImageError = false;
        });
      }
    } on PlatformException catch (e) {
      _handleError('Image picker error: ${e.message}');
    }
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted || pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );

    if (!mounted || pickedTime == null) return;

    setState(() {
      _selectedTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _timeController.text = DateFormat('HH:mm | dd/MMM').format(_selectedTime);
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_imagePath.isEmpty) {
      setState(() => _showImageError = true);
      return;
    }

    final meal = Meal(
      id: const Uuid().v4(),
      name: _nameController.text,
      calories: int.parse(_caloriesController.text),
      time: _selectedTime,
      imagePath: _imagePath,
    );

    context.read<MealCubit>().addMeal(meal);
    _resetForm();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _caloriesController.clear();
    _timeController.clear();
    setState(() {
      _imagePath = '';
      _selectedTime = DateTime.now();
      _showImageError = false;
    });
  }

  void _handleError(String message) {
    CustomSnackBar.show(
      context: context,
      message: message,
      snackBarType: SnackBarType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MealCubit, MealState>(
      listener: (context, state) {
        if (state is MealAddedSuccess) {
          Navigator.pop(context);
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 30.h,
            children: [
              _buildImagePicker(),
              SizedBox(height: 1.h),
              _buildNameField(),
              _buildCaloriesField(),
              _buildTimePicker(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // separtion of concerns

  Widget _buildImagePicker() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: context.screenHeight * 0.25,
            width: context.screenWidth * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: AppColors.secondaryColor,
              border: _showImageError
                  ? Border.all(color: Colors.red, width: 2)
                  : null,
              image: _imagePath.isNotEmpty
                  ? DecorationImage(
                      image: FileImage(File(_imagePath)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _imagePath.isEmpty
                ? const Icon(
                    Icons.add_a_photo,
                    size: 50,
                  )
                : null,
          ),
        ),
        if (_showImageError)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              AppStrings.imageRequiredError,
              style: context.errorText,
            ),
          ),
      ],
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      hintText: AppStrings.mealName,
      controller: _nameController,
      icon: const Icon(Icons.fastfood, color: AppColors.primaryColor),
      validator: (value) =>
          value!.isEmpty ? AppStrings.nameRequiredError : null,
    );
  }

  Widget _buildCaloriesField() {
    return CustomTextField(
      controller: _caloriesController,
      hintText: AppStrings.calories,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      icon: const Icon(
        Icons.local_fire_department,
        color: AppColors.primaryColor,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.caloriesRequiredError;
        }
        if (int.tryParse(value) == null) {
          return AppStrings.caloriesNumberError;
        }
        return null;
      },
    );
  }

  Widget _buildTimePicker() {
    return CustomTextField(
      hintText: AppStrings.mealTime,
      controller: _timeController,
      readOnly: true,
      icon: const Icon(Icons.calendar_today),
      onTap: _selectDateTime,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        AppStrings.addMeal.toUpperCase(),
        style: context.bodyLarge.copyWith(color: Colors.white),
      ),
    );
  }
}
