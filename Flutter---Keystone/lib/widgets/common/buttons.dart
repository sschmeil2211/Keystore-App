// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:keystore/utils/styles.dart';

class LargeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const LargeButton({
    required this.label,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: const Color(0xFFF58428),
      onPressed: this.onPressed,
      child: Text(
        this.label,
        style: CustomTextStyles.w600White(20),
      )
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const CustomTextButton({
    required this.label,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: this.onPressed,
        child: Text(
          this.label,
          style: CustomTextStyles.textButton,
        )
      ),
    );
  }
}

class KeyboardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String content;

  const KeyboardButton({
    required this.onPressed,
    required this.content,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0xFFF58428),
      height: 40,
      minWidth: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: this.onPressed,
      child: Text(
        this.content,
        style: CustomTextStyles.w400White(22),
      ),
    );
  }
}
