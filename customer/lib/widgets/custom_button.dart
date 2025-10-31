import 'package:flutter/material.dart';
import 'package:kicksy/appTheme/app_color.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;
  final Widget child;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        backgroundColor: AppColor.primaryColor,
        minimumSize: const Size(double.infinity, 45),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.blue)
          : child,
    );
  }
}
