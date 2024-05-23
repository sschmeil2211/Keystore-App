// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

import 'package:keystore/widgets/widgets.dart';

class CustomBackground extends StatelessWidget {
  final Widget? floatingButton;
  final Widget? leading;
  final double? leadingWidth;
  final String title;
  final Widget child;

  const CustomBackground({
    this.leading,
    this.floatingButton,
    this.leadingWidth,
    this.title = '',
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF101B38),
        toolbarHeight: 120,
        centerTitle: true,
        leading: this.leading,
        leadingWidth: this.leadingWidth,
        title: TitleText(title: this.title),
      ),
      floatingActionButton: this.floatingButton,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.8],
            colors: [
              Color(0xFF101B38),
              Color(0xFF06031C),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: this.child
          ),
        ),
      ),
    );
  }
}
