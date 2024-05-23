// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/providers/controllers_provider.dart';

import 'package:keystore/utils/styles.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NewPasswordInputs extends StatelessWidget {
  const NewPasswordInputs({super.key});

  @override
  Widget build(BuildContext context) {
    ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);
    return Form(
      child: Column(
        children: [
          CustomInput(
            inputName: 'New Password',
            hint: 'Enter a New Password',
            icon: FontAwesomeIcons.lock,
            controller: controllersProvider.password,
          ),
          CustomInput(
            inputName: 'Confirm Password',
            hint: 'Enter your new password again',
            icon: FontAwesomeIcons.lock,
            controller: controllersProvider.passwordToVerify,
          ),
        ],
      ),
    );
  }
}