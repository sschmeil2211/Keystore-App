
// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/providers/controllers_provider.dart';
import 'package:keystore/utils/styles.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignForm extends StatelessWidget {
  final bool isSignInView;
  final ControllersProvider controllersProvider;

  const SignForm({
    required this.isSignInView,
    required this.controllersProvider,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          if(!this.isSignInView)
            CustomInput(
              controller: this.controllersProvider.username,
              inputName: 'Username',
              hint: 'Enter your Username',
              icon: FontAwesomeIcons.solidUser,
            ),
          CustomInput(
            controller: this.controllersProvider.email,
            inputName: 'Email',
            hint: 'Enter your Email',
            icon: FontAwesomeIcons.solidEnvelope,
          ),
          CustomInput(
            controller: this.controllersProvider.password,
            inputName: 'Password',
            hint: 'Enter your Password',
            icon: FontAwesomeIcons.lock,
            passwordInput: true,
          ),
        ],
      ),
    );
  }
}

class RememberCheck extends StatefulWidget {
  const RememberCheck({super.key});

  @override
  State<RememberCheck> createState() => _RememberCheckState();
}

class _RememberCheckState extends State<RememberCheck> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            activeColor: const Color(0xFFF58428),
            onChanged: (value) => setState(() => isChecked = !isChecked)
          ),
          Text(
            'Remember me',
            style: CustomTextStyles.w900White(12),
          )
        ],
      ),
    );
  }
}

class GoogleSign extends StatelessWidget {
  const GoogleSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: Column(
        children: [
          Text(
            '- OR -\n\nSign in with\n',
            textAlign: TextAlign.center,
            style: CustomTextStyles.w600White(12),
          ),
          MaterialButton(
              shape: const CircleBorder(),
              color: const Color(0xFFF58428),
              height: 50,
              child: const Icon(
                FontAwesomeIcons.google,
                color: Color(0xFFFFFFFF),
              ),
              onPressed: (){}
          )
        ],
      ),
    );
  }
}

class SignButtonText extends StatelessWidget {
  final String text;
  final String signLabel;
  final Function() onPressed;

  const SignButtonText({
    required this.text,
    required this.signLabel,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          this.text,
          style: CustomTextStyles.w600White(12),
        ),
        CustomTextButton(
          label: this.signLabel,
          onPressed: this.onPressed,
        )
      ],
    );
  }
}

