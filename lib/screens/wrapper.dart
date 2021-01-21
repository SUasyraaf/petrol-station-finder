import "package:flutter/material.dart";
import 'package:flutter_project/screens/authenticate/authenticate.dart';
import 'package:flutter_project/screens/authenticate/register%20Backup.dart';
import 'package:flutter_project/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    }else{
      Future<void> main() async {
        WidgetsFlutterBinding.ensureInitialized();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var email = prefs.getString('email');
        runApp(MaterialApp(home: email == null ? Register() : Home()));
      }
      return Home();
    }
  }
}
