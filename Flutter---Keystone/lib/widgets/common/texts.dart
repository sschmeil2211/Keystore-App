// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

import 'package:keystore/utils/styles.dart';

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({
    required this.title,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: CustomTextStyles.screenTitle,
    );
  }
}