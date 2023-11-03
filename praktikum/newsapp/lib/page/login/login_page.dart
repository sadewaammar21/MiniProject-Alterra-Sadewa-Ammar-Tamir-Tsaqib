import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/page/home_page.dart';
import 'package:newsapp/page/register/resgister_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool showSpinner = false;
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  void checkCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 207, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Masukkan Email Anda",
                            icon: Icon(
                              Icons.mark_email_read,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            fillColor: Colors.white),
                        onChanged: (values) {
                          email = values;
                        },
                        validator: (values) {
                          if (values!.isEmpty) {
                            return "please enter your email";
                          }
                          final isEmailValidation =
                              EmailValidator.validate(values);
                          if (!isEmailValidation) {
                            return "please enter a valid email";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Masukkan Password Anda",
                            icon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            fillColor: Colors.white),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (values) {
                          if (values!.isEmpty) {
                            return 'enter your password';
                          }
                        },
                        obscureText: _obscureText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        await _auth
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .then((value) {
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false);
                        });
                        print("Succesfully Login");
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Register here.',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
