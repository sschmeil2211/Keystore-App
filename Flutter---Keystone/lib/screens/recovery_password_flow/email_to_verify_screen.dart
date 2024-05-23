// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/services/auth_service.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EmailToVerifyScreen extends StatelessWidget {
  const EmailToVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);
    return CustomBackground(
      title: 'Insert your Email',
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(FontAwesomeIcons.chevronLeft, color: Color(0xFFFFFFFF))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomInput(
            controller: controllersProvider.email,
            inputName: 'Email',
            hint: 'Enter your Email',
            icon: FontAwesomeIcons.solidEnvelope,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 65),
            child: LargeButton(
              label: 'CONTINUE',
              onPressed: () => Navigator.of(context).pushNamed('verifySeedScreen')
            ),
          )
        ],
      ),
    );
  }
}