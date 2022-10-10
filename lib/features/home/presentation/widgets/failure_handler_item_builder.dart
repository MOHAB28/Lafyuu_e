import 'package:flutter/material.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../login/presentation/widgets/custom_button.dart';

class FailureHandlerItemBuilder extends StatelessWidget {
  const FailureHandlerItemBuilder({
    Key? key,
    required this.title,
    required this.message,
    required this.onTap,
    this.icon = Icons.close_rounded,
    this.buttonTitle = AppStrings.tryAgian,
  }) : super(key: key);

  final String title;
  final String buttonTitle;
  final String message;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: ColorManager.blue,
            radius: AppSize.s30,
            child: Center(
              child: Icon(
                icon,
                color: ColorManager.white,
                size: AppSize.s25,
              ),
            ),
          ),
          const SizedBox(height: AppSize.s16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSize.s16),
          CustomButtonBuilder(
            onTap: () {
              onTap();
            },
            title: buttonTitle,
          ),
        ],
      ),
    );
  }
}
