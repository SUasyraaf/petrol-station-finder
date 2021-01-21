import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/services/auth.dart';
import 'package:flutter_project/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';


TextEditingController emailController = new TextEditingController();
TextEditingController pwdController = new TextEditingController();

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn ({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email ='';
  String password ='';
  String error ='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Sign In to PS Finder'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  controller: emailController,
                decoration: textInputDecoration.copyWith(hintText:'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(()=> email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  controller: pwdController,
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter an password 6+ chars long' : null,
                onChanged: (val){
                  setState(()=> password = val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async {
                  save();
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    setState(() {
                      pwdController.text="";
                      emailController.text="";
                    });
                    if (result == null){
                      setState(()=> error = 'Could not sign in with those credentials');
                    }
                  }
                },
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize:14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
save() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  localStorage.setString('email', emailController.text.toString());
  localStorage.setString('password', pwdController.text.toString());

  final fb = FirebaseDatabase.instance.reference().child("Users");

  fb.once().then((DataSnapshot snapshot){
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key,values) {
      if( emailController.text.toString()==values["email"])
        {
          localStorage.setString('name', values["name"]);
          localStorage.setString('contact', values["contact"]);
        }
    });
  });
}
