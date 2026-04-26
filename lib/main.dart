import 'package:flutter/material.dart';
import 'package:project/core/sharedpreferences_helper.dart';
import 'package:project/screens/Homescreen.dart';
import 'package:project/screens/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.startDb();
  checkIslogged();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Islogged ? Homescreen() : Loginscreen(),
    );
  }
}

bool Islogged = false;

checkIslogged() {
  bool islogin = CashHelper.getIsLogin() ?? false;
  if (islogin) {
    Islogged = true;
  } else {
    Islogged = false;
  }
}
