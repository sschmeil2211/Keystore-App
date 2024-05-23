// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:keystore/models/models.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/services/auth_service.dart';

import 'package:keystore/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool isSignInView = true;

  @override
  Widget build(BuildContext context) {
    ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);
    return CustomBackground(
      title: isSignInView ? 'Sign In' : 'Sign Up',
      child: Column(
        children: [
          SignForm(
            isSignInView: isSignInView,
            controllersProvider: controllersProvider,
          ),
          if(isSignInView)
            CustomTextButton(
              label: 'Forgot Password?',
              onPressed: () => Navigator.of(context).pushNamed('emailToVerifyScreen'),
            ),
          const RememberCheck(),
          LargeButton(
            label: isSignInView ? 'SIGN IN' : 'SIGN UP',
            onPressed: () async {
              String? message = isSignInView
                  ? await AuthService().signInWithEmailAndPassword(controllersProvider.email.text, controllersProvider.password.text)
                  : await AuthService().signUpWithEmailAndPassword(controllersProvider.email.text, controllersProvider.password.text);
              if(!context.mounted || message != null) return;
              Navigator.of(context).pushNamed('pinScreen', arguments: isSignInView ? PinScreenType.validate : PinScreenType.create);
            },
          ),
          const GoogleSign(),
          SignButtonText(
            text: isSignInView ? 'Dont have an Account?' : 'If you have an account',
            signLabel: isSignInView ? 'Sign Up' : 'Sign In',
            onPressed: () => setState(() => isSignInView = !isSignInView),
          )
        ],
      ),
    );
  }
}