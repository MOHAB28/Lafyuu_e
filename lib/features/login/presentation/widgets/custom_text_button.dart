import 'package:flutter/material.dart';

class CustomTextButtonForAuth extends StatelessWidget {
  const CustomTextButtonForAuth({
    Key? key,
    required String title1,
    required String title2,
    required VoidCallback onTap,
  })  : _title1 = title1,
        _title2 = title2,
        _onTap = onTap,
        super(key: key);

  final String _title1;
  final String _title2;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: RichText(
        text: TextSpan(
          text: _title1,
          style: Theme.of(context).textTheme.displaySmall,
          children: [
            TextSpan(
              text: _title2,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
