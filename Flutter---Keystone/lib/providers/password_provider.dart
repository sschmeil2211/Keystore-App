// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/foundation.dart';

import 'package:keystore/models/models.dart';
import 'package:keystore/services/api_handler.dart';
import 'package:keystore/services/auth_service.dart';


class PasswordProvider with ChangeNotifier {
  final ApiHandler _apiHandler = ApiHandler();
  final String _apiPath = 'Password';

  bool _loaded = false;
  List<Password>? _passwords;

  Future<void> init(String userID) async {
    _passwords = await _apiHandler.getAllByID(userID, _apiPath, (jsonData) => Password.fromJson(jsonData));
    if(_passwords == null) return;
    _loaded = true;
    notifyListeners();
  }

  Future<void> addPassword(Password password) async => await _apiHandler.createData(password, _apiPath);

  Future<String?> getDecryptedPassword(String passwordID) async => await _apiHandler.getDecryptedText('$_apiPath/DecryptedPassword', passwordID);

  Future<void> getAllPasswords() async {
    _passwords = await _apiHandler.getAllByID(AuthService().userID, _apiPath, (jsonData) => Password.fromJson(jsonData));
  }

  bool get loaded => _loaded;
  List<Password>? get passwords => _passwords;
}