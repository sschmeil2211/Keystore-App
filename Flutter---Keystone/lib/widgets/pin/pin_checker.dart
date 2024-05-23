// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:keystore/widgets/common/buttons.dart';

class PinNumbers extends StatelessWidget {
  final List<String> enteredNumbers;

  const PinNumbers({
    required this.enteredNumbers,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 6; i++)
          SizedBox(
            width: 30,
            child: Center(
              child: Container(
                width: i < this.enteredNumbers.length ? 20 : 15,
                height: i < this.enteredNumbers.length ? 20 : 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < this.enteredNumbers.length ? const Color(0xFFF58428) : const Color(0xFF9D9D9D),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final Function() onDeletePressed;

  const CustomKeyboard({
    required this.onKeyPressed,
    required this.onDeletePressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int j = 1; j <= 3; j++)
                numberButton((i * 3) + j),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 40,
              width: 100,
            ),
            numberButton(0),
            KeyboardButton(
              onPressed: this.onDeletePressed,
              content: '⌫'
            )
          ],
        ),
      ],
    );
  }

  Widget numberButton(int number){
    return KeyboardButton(
      onPressed: () => this.onKeyPressed(number.toString()),
      content: number.toString()
    );
  }
}

