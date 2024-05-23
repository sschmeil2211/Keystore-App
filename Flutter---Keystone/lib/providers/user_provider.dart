// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/foundation.dart';

import 'package:keystore/models/models.dart';
import 'package:keystore/services/api_handler.dart';
import 'package:keystore/services/auth_service.dart';


class UserProvider with ChangeNotifier {
  final ApiHandler _apiHandler = ApiHandler();
  final String _apiPath = 'User';

  bool _loaded = false;
  User? _user;

  Future<void> init() async {
    if(AuthService().currentUser == null) return;
    _user = await _apiHandler.getById(AuthService().userID, _apiPath, (jsonData) => User.fromJson(jsonData));
    if(_user == null) return;
    _loaded = true;
    notifyListeners();
  }

  Future<void> addUser(User user) async => await _apiHandler.createData(user.toJson(), _apiPath);

  Future<bool> validatePin(String pin) async => await _apiHandler.validateData(_apiPath, 'id', AuthService().userID, pin);

  bool get loaded => _loaded;
  User? get user => _user;
}