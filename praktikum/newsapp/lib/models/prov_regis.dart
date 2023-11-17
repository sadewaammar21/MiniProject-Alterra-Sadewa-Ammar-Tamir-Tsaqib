import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/page/home_page.dart';

class RegistrationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showSpinner = false;

  bool get showSpinner => _showSpinner;

  void setSpinnerVisibility(bool value) {
    _showSpinner = value;
    notifyListeners();
  }

  Future<void> registerUser(
      String email, String password, BuildContext context) async {
    setSpinnerVisibility(true);
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      setSpinnerVisibility(false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      print(e);
      setSpinnerVisibility(false);
      // Handle and show error messages or other appropriate UI here
    }
  }
}
