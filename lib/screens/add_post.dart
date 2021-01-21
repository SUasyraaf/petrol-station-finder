import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_project/screens/trafficInfo.dart';


class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {


  TextEditingController title = new TextEditingController();
  TextEditingController info = new TextEditingController();
  var count=0;

  void getCurrentLength(){
    final fb = FirebaseDatabase.instance.reference().child("Posting");

    fb.once().then((DataSnapshot dataSnapShot) {
      setState(() {
        count= dataSnapShot.value.length;
      });
    });
  }

 @override
  void initState() {
   getCurrentLength();
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        elevation: 0.0,
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'POST TITLE',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    // hintText: 'Post Title',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Post Title",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'INFORMATION',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: info,
                  maxLines: 4,
                  decoration: InputDecoration(
                    // hintText: 'Post Title',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Post Information",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              color: Colors.blue,
              child: Text("Create", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrafficInfo()));
                writeData();
              },
            ),
          ],
        ),
      ),
    );
  }

  writeData() {
    final fb = FirebaseDatabase.instance.reference().child("Posting");

       fb.child("Posting " +count.toString()).set({
        'title': title.text,
        'information': info.text,
      });

  }
}