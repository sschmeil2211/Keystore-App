// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:keystore/models/models.dart';
import 'package:keystore/providers/providers.dart';
import 'package:keystore/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashScreenProvider extends ChangeNotifier {
  late bool _isLoading;

  Future<void> startAnimation() async {
    _isLoading = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    notifyListeners();
  }

  void onAnimationEnd(BuildContext context) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    PasswordProvider passwordProvider = Provider.of<PasswordProvider>(context, listen: false);
    ControllersProvider controllersProvider = Provider.of<ControllersProvider>(context, listen: false);

    await userProvider
        .init()
        .then((value) async => passwordProvider.init(AuthService().userID).then((value) => _isLoading = false));

    if(userProvider.user == null) return;
    controllersProvider.init(userProvider.user!.username, 'sebaschmeil123@gmail.com');
    if(userProvider.loaded && passwordProvider.loaded && !_isLoading) {
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, 'pinScreen', (route) => false, arguments: PinScreenType.validate);
    }
    else{
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, 'signScreen', (route) => false);
    }
  }
}