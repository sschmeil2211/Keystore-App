// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/foundation.dart';

import 'package:keystore/models/models.dart';
import 'package:keystore/services/api_handler.dart';


class SeedProvider with ChangeNotifier {
  final ApiHandler _apiHandler = ApiHandler();
  final String _apiPath = 'Seed';

  bool _loaded = false;
  Seed? _seed;

/*SeedProvider(){
    init();
  }

  Future<void> init() async {
    _user = await getUserById();
    if(_user == null) return;
    _loaded = true;
    notifyListeners();
  }*/

  Future<void> addSeed(Seed seed) async => await _apiHandler.createData(seed.toJson(), _apiPath);

  Future<bool> validateSeed(String email, String seed) async => await _apiHandler.validateData(_apiPath, 'email', email, seed);

  bool get loaded => _loaded;
  Seed? get seed => _seed;
}