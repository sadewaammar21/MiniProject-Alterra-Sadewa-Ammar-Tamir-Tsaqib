import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/fetch.dart';
import 'package:newsapp/page/home_page.dart';
import 'package:newsapp/page/login/login_page.dart';
import 'package:newsapp/page/register/resgister_page.dart';
import 'package:newsapp/page/search_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/Home': (context) => HomePage(),
          '/search': (context) => SearchPage()
        },
      ),
    );
  }
}
