import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register ({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final fb = FirebaseDatabase.instance;
  final FirebaseAuth _auth= FirebaseAuth.instance;
  
  // text field state
  String name;
  String email;
  String username;
  String contact;
  String password;

  @override
  Widget build(BuildContext context) {
    final ref=fb.reference().child("Users");
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Sign Up to PS Finder'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),


      body: Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Image.asset('assets/images/logo.jpg',
                height:100,
                width:100,
                ),
              ],
            ),

            TextFormField(
              onChanged: (val){
                 name = val;
              },
              decoration: new InputDecoration(
                hintText: 'Name',
                labelText: 'Enter your name',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                icon: new Icon(Icons.person),
              ),
            ),

            TextFormField(
              onChanged: (val){
                email = val;
              },
              decoration: new InputDecoration(
                hintText: 'Email',
                labelText: 'Enter your email',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                icon: new Icon(Icons.email),
              ),
            ),

            TextFormField(
              onChanged: (val){
                username = val;
              },
              decoration: new InputDecoration(
                hintText: 'User Name',
                labelText: 'Enter your username',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                icon: new Icon(Icons.person_search),
              ),
            ),

            TextFormField(
              onChanged: (val){
                contact = val;
              },
              decoration: new InputDecoration(
                hintText: 'Contact',
                labelText: 'Enter your contact',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                icon: new Icon(Icons.quick_contacts_dialer),
              ),
            ),

            TextFormField(
              onChanged: (val){
                password = val;
              },
              decoration: new InputDecoration(
                hintText: 'password',
                labelText: 'Enter you password',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                icon: new Icon(Icons.lock),
              ),
            ),

            Container (
              height: 50.0,
              width: 210.0,
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: RaisedButton(
                onPressed:() async {
                  print("Registration successful");
                  AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
                  if(result!=null){
                    FirebaseUser user  = await FirebaseAuth.instance.currentUser();
                    ref.child(user.uid).set({
                        "name": name,
                        "email": email,
                        "username": username,
                        "contact": contact,
                        "password": password,
                    }
                    ).then ((value) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('email', email);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    });
                  } 
                },
                child: new Text (
                  'Register',
                  style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ),

    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      onPressed: () {

      },
    ),
    );
  }
}