// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:keystore/models/models.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/services/auth_service.dart';

import 'package:word_generator/word_generator.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SeedScreen extends StatelessWidget {
  const SeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> randomWords = WordGenerator().randomNouns(12);

    return CustomBackground(
      title: 'Save your Seed',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NewSeed(
            randomWords: randomWords,
            hint: 'You must to save these words in a safe place. You’ll use it to recover your account or other data.'
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 65),
            child: LargeButton(
              label: 'CONTINUE',
              onPressed: () async {
                ControllersProvider controllers = Provider.of<ControllersProvider>(context, listen: false);
                await Provider.of<UserProvider>(context, listen: false).addUser(
                  User(
                    id: AuthService().userID,
                    email: controllers.email.text,
                    username: controllers.username.text,
                    pin: controllers.verifiedPin
                  )
                );
                Provider.of<SeedProvider>(context, listen: false).addSeed(
                  Seed(
                    userId: AuthService().userID,
                    seed: randomWords.join('')
                  )
                );
                if(!context.mounted) return;
                Navigator.of(context).pushNamed('homeScreen');
              }
            ),
          )
        ],
      ),
    );
  }
}

