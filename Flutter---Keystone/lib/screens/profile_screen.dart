// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/utils/styles.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool verifiedSeed = false;
    ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);

    return CustomBackground(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(FontAwesomeIcons.chevronLeft, color: Color(0xFFFFFFFF))
      ),
      title: 'My Profile',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomInput(
                controller: controllersProvider.username,
                inputName: 'Username',
                hint: 'Enter your Username',
                icon: FontAwesomeIcons.solidUser,
              ),
              CustomInput(
                controller: controllersProvider.email,
                inputName: 'Email',
                hint: 'Enter your Email',
                icon: FontAwesomeIcons.solidEnvelope,
              ),
            ],
          ),
          buttons()
        ],
      ),
    );
  }

  Widget buttons() => Column(
    children: [
      LargeButton(
        label: 'SAVE',
        onPressed: (){}
      ),
      deleteAccountButton()
    ],
  );

  Widget deleteAccountButton() => Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 65),
    child: MaterialButton(
      minWidth: double.infinity,
      height: 45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Color(0xFFF58428),
          width: 3
        )
      ),
      color: const Color(0xFFFFFFFF),
      onPressed: (){},
      child: Text(
        'DELETE ACCOUNT',
        style: CustomTextStyles.alternateLargeButton,
      )
    ),
  );
}