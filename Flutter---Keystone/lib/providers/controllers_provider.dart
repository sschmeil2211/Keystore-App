import 'package:flutter/cupertino.dart';

class ControllersProvider extends ChangeNotifier{
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordToVerify = TextEditingController();
  final TextEditingController _newPlatformPassword = TextEditingController();
  final TextEditingController _newPlatform = TextEditingController();
  String _pin = '';
  String _verifiedPin = '';
  bool _isLoaded = false;

  void init(String username, String email){
    if(_isLoaded) return;
    _username.text = username;
    _email.text = email;
    _isLoaded = true;
    notifyListeners();
  }

  TextEditingController get username => _username;
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  TextEditingController get passwordToVerify => _passwordToVerify;
  TextEditingController get newPlatformPassword => _newPlatformPassword;
  TextEditingController get newPlatform => _newPlatform;
  String get pin => _pin;
  String get verifiedPin => _verifiedPin;
  bool get isLoaded => _isLoaded;

  set verifiedPin(String value) {
    _verifiedPin = value;
    notifyListeners();
  }

  set pin(String value) {
    _pin = value;
    notifyListeners();
  }

  set password(TextEditingController value) {
    _password.text = value.text;
    notifyListeners();
  }

  set passwordToVerify(TextEditingController value) {
    _passwordToVerify.text = value.text;
    notifyListeners();
  }

  set email(TextEditingController value) {
    _email.text = value.text;
    notifyListeners();
  }

  set username(TextEditingController value) {
    _username.text = value.text;
    notifyListeners();
  }

  set newPlatformPassword(TextEditingController value) {
    _newPlatformPassword.text = value.text;
    notifyListeners();
  }

  set newPlatform(TextEditingController value) {
    _newPlatform.text = value.text;
    notifyListeners();
  }
}