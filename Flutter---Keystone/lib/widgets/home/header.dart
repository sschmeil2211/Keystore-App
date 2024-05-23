import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keystore/services/auth_service.dart';
import 'package:keystore/utils/styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('profileScreen'),
                  padding: const EdgeInsets.all(15),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFF58428))
                  ),
                  icon: const Icon(FontAwesomeIcons.solidUser, color: Color(0xFFFFFFFF))
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                    'Welcome, Sschmeil22',
                    style: CustomTextStyles.w400White(16)
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              if(!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(context, 'signScreen', (route) => false);
            },
            icon: const Icon(FontAwesomeIcons.arrowRightFromBracket, size: 20, color: Color(0xFFF58428))
          )
        ],
      )
    );
  }
}