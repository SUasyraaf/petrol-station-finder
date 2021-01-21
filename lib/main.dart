import 'package:flutter/material.dart';
import 'package:flutter_project/screens/wrapper.dart';
import 'package:flutter_project/services/auth.dart';
import 'package:flutter_project/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}
SharedPreferences localStorage;

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
