import 'package:flutter/material.dart';
import 'package:project/core/sharedpreferences_helper.dart';
import 'package:project/screens/Homescreen.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernamecontroller = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: usernamecontroller,
            decoration: InputDecoration(labelText: "username"),
          ),
          ElevatedButton(
            onPressed: () async {
              await CashHelper.saveUsername(usernamecontroller.text);
              await CashHelper.setLogin(true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homescreen()),
              );
            },
            child: Text("login"),
          ),
        ],
      ),
    );
  }
}
