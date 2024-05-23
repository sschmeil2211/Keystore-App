// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:keystore/utils/styles.dart';
import 'package:keystore/widgets/seed/seed.dart';

class NewSeed extends StatelessWidget {
  final String hint;
  final List<dynamic> randomWords;

  const NewSeed({
    required this.randomWords,
    required this.hint,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: List.generate(6, (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(2, (j) => randomWords is List<String>
                    ? WordBox(word: this.randomWords[2*i+j])
                    : WordInput(
                        hint: 'Word ${2*i+j}',
                        controller: this.randomWords[2*i+j]
                      )
                ),
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              this.hint,
              style: CustomTextStyles.w400White(18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}