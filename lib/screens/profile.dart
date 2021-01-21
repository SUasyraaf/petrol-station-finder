import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_project/screens/authenticate/register%20Backup.dart';
import 'package:flutter_project/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../models/modelClass.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final fb = FirebaseDatabase.instance.reference().child("Users");
  var name, contact, email,username,password,key;

  List<Model> list = List();

  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      contact = localStorage.getString('contact');
      email = localStorage.getString('email');
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      print(data);
      list.clear();
      data.forEach((key, value) async {
        if (email == value["email"]) {
          setState(() {
            name= value['name'];
            email=value['email'];
            username= value['username'];
            contact=value['contact'];
            password= value['password'];
            key= key;
          });
          Model model = new Model(
            name: value['name'],
            email: value['email'],
            username: value['username'],
            contact: value['contact'],
            password: value['password'],
            key: key,
          );
          list.add(model);
        }
      });
      setState(() {});
    });
  }

  Future<String> createDialog(BuildContext context) {
    TextEditingController ed = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text("Update Username"),
              ],
            ),
            content: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: username,
              ),
              controller: ed,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(ed.text.toString());
                },
                child: Text("submit"),
              )
            ],
          );
        });
  }

  DeleteData(BuildContext context, String key) {
    Widget okButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          fb.child(key).remove();
          Navigator.of(context).pop();
        });
      },
    );

    Widget no = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete Data"),
      content: Text("Do you want to delete?"),
      actions: [
        okButton,
        no,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget UI(String name, String email, String username, String contact, String password, String key) {
      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onLongPress: (){
              createDialog(context).then((value){
                if(value != null){
                  Map<String, Object> createDoc = new HashMap();
                  createDoc['username'] = value;
                  fb.child(key).update(createDoc);
                }
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));

                setState(() {
                  // localStorage.setString('name',value);
                });
              });
            },

            child: Container(
              height: MediaQuery.of(context).size.height*0.2,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Name : "),
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Email : "),
                        Text(
                          email,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Username : "),
                        Text(
                          username,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Contact : "),
                        Text(
                          contact,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Password : "),
                        Text(
                          password,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile View"),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        height: MediaQuery.of(context).size.height*1,
        color: Colors.grey[100],
        child: list.length == 0
            ? Text("Data is null")
            :  UI(list[0].name, list[0].email, list[0].username, list[0].contact, list[0].password, list[0].key)

      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await _firebaseAuth.signOut().then((_) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new Register()));
    });
  }
}
