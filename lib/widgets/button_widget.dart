import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Widget child;

  const CustomFilledButton({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = 50,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56),
          ),
        ),
        child: child,
      ),
    );
  }
}
