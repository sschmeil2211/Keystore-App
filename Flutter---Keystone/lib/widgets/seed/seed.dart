// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:keystore/utils/styles.dart';

class WordBox extends StatelessWidget {
  final String word;

  const WordBox({
    required this.word,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 50,
      decoration: BoxDecoration(
          color: const Color(0xFF1B2C57),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(
          this.word,
          style: CustomTextStyles.w400White(18),
        ),
      ),
    );
  }
}

class WordInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const WordInput({
    required this.hint,
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: const Color(0xFF1B2C57),
        elevation: 5,
        child: TextField(
          style: CustomTextStyles.w400White(14),
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            hintText: hint,
            hintStyle: CustomTextStyles.hint
          ),
        ),
      ),
    );
  }
}