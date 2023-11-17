import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/fetch.dart';
import 'package:newsapp/models/prov_regis.dart';
import 'package:newsapp/page/home_page.dart';
import 'package:newsapp/page/login/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        FutureProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges().first,
          initialData: null, // Provide initial data for the future
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<User?>(
          builder: (context, user, _) {
            if (user == null) {
              return LoginPage();
            } else {
              return HomePage();
            }
          },
        ),
      ),
    );
  }
}
