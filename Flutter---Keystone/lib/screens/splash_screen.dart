// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:keystore/models/models.dart';
import 'package:keystore/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'package:lottie/lottie.dart';

import 'package:keystore/providers/providers.dart';
import 'package:keystore/widgets/common/background.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build( BuildContext context ){
    return CustomBackground(
      child: Center(
        child: Builder(
          builder: (context){
            SplashScreenProvider splashScreenController = Provider.of<SplashScreenProvider>(context, listen: false);

            splashScreenController.startAnimation();
            splashScreenController.onAnimationEnd(context);

            return Lottie.asset('assets/loading.json');
          },
        ),
      )
    );
  }
}