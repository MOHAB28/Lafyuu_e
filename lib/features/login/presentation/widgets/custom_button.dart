import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CustomButtonBuilder extends StatelessWidget {
  const CustomButtonBuilder({
    Key? key,
    required String title,
    required VoidCallback onTap,
    this.blurRadius = 12.0,
  })  : _title = title,
        _onTap = onTap,
        super(key: key);
  final double blurRadius;
  final String _title;
  final VoidCallback _onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: Container(
        height: AppSize.s57,
        decoration: BoxDecoration(
          color: ColorManager.blue,
          borderRadius: BorderRadius.circular(AppSize.s5),
          boxShadow:  [
            BoxShadow(
              color: ColorManager.blue,
              spreadRadius: 0.1,
              blurRadius: blurRadius,
              offset: const Offset(4, 4)
            )
          ],
        ),
        child: Center(
          child: Text(
            _title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
