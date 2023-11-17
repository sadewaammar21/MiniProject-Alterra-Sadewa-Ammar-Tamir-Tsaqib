import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/prov_regis.dart';
import 'package:newsapp/page/home_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 207, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Registrasi",
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
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          hintText: "Masukkan Email Anda",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          email = value;
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.password_outlined,
                            color: Colors.black,
                          ),
                          hintText: "Masukkan Password Anda",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (values) {
                          if (values!.isEmpty) {
                            return "please enter your password";
                          }
                        },
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
                      await registrationProvider.registerUser(
                          email, password, context);
                    }
                  },
                  child: Text(
                    "Registrasi",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
