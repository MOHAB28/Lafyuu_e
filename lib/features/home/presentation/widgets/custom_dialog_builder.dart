import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CustomDialogBuilder extends StatelessWidget {
  const CustomDialogBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: ColorManager.white,
      elevation: 0.3,
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: SizedBox(
          height: AppSize.s30,
          width: AppSize.s30,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
