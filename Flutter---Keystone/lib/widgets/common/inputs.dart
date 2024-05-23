// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/utils/styles.dart';

class CustomInput extends StatefulWidget {
  final bool passwordInput;
  final String inputName;
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const CustomInput({
    this.passwordInput = false,
    required this.icon,
    required this.hint,
    required this.inputName,
    required this.controller,
    super.key
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, top: 25, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.inputName,
                style: CustomTextStyles.w400White(16),
              ),
              if(widget.passwordInput)
                InkWell(
                  onTap: () => setState(() => isObscured = !isObscured),
                  child: Icon(
                    isObscured ? FontAwesomeIcons.eyeLowVision : FontAwesomeIcons.eye,
                    color: const Color(0xFFF58428),
                  ),
                )
            ],
          ),
        ),
        CustomTextField(
          icon: widget.icon,
          hint: widget.hint,
          controller: widget.controller,
          obscureText: widget.passwordInput ? isObscured : widget.passwordInput,
        )
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const CustomTextField({
    required this.obscureText,
    required this.hint,
    required this.icon,
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1B2C57),
      elevation: 5,
      child: TextField(
        obscureText: this.obscureText,
        controller: this.controller,
        style: CustomTextStyles.w400White(14),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              this.icon,
              color: const Color(0xFF9D9D9D),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          hintText: this.hint,
          hintStyle: CustomTextStyles.hint
        ),
      ),
    );
  }
}
