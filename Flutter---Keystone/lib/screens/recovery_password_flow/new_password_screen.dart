// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/services/auth_service.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return CustomBackground(
      title: 'Recover Password',
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(FontAwesomeIcons.chevronLeft, color: Color(0xFFFFFFFF))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const NewPasswordInputs(),
          Padding(
            padding: const EdgeInsets.only(bottom: 65),
            child: LargeButton(
              label: 'CONTINUE',
              onPressed: () async {
                String email = Provider.of<ControllersProvider>(context, listen: false).email.text;
                String? message = await AuthService().recoveryPassword(email);
                if(message != null) return;
                if(!context.mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil('signIn', (route) => false);
              }
            ),
          )
        ],
      ),
    );
  }
}