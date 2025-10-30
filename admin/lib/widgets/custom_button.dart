import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool? isLoading;
  final Widget child;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading,
    this.backgroundColor = const Color(0xFF43A047),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isLoading ?? false) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        child: (isLoading ?? false)
            ? const CircularProgressIndicator(color: Colors.blue)
            : child,
      ),
    );
  }
}
