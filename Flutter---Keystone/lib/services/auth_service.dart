// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _authInstance = auth.FirebaseAuth.instance;

  //singleton
  static final AuthService _instance = AuthService._internal();
  AuthService._internal();
  factory AuthService() => _instance;

  // Registro con correo electrónico y contraseña
  Future<String?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _authInstance.createUserWithEmailAndPassword(email: email, password: password);
      await signInWithEmailAndPassword(email, password);
      return null;
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    } catch(e){
      return e.toString();
    }
  }

  // Inicio de sesión con correo electrónico y contraseña
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _authInstance.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    } catch(e) {
      return e.toString();
    }
  }

  // Cerrar sesión
  Future<String?> signOut() async {
    try{
      await _authInstance.signOut();
      return null;
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    } catch(e) {
      return e.toString();
    }
  }

  Future<String?> recoveryPassword(String email) async {
    try{
      await _authInstance.sendPasswordResetEmail(email: email);
      return null;
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    } catch(e) {
      return e.toString();
    }
  }

  // Obtener el usuario actual
  auth.User? get currentUser => _authInstance.currentUser;
  String get userID => _authInstance.currentUser?.uid ?? '';
}