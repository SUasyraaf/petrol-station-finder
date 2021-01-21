import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_project/screens/home/home.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class Feedbackpage extends StatefulWidget {
  @override
  _FeedbackpageState createState() => _FeedbackpageState();
}

class _FeedbackpageState extends State<Feedbackpage> {

  TextEditingController feedbackuser = new TextEditingController();
  double rating =0.0;
  var count=0;

  void getCurrentLength(){
    final fb = FirebaseDatabase.instance.reference().child("Feedback");

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

    return Scaffold(
        appBar: AppBar(
          title: Text("Feedback"),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 100),
                    child: Text(
                      "LOVED IT!",
                      style: TextStyle(
                        letterSpacing: 1.4,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SmoothStarRating(
                    onRated: (v) {
                      this.rating = v;
                    },
                    color: Colors.blue,
                    borderColor: Colors.black26,
                    allowHalfRating: false,
                    size: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    color: Colors.grey[200],
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Have a nice journey",
                          style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              color: Colors.black,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: TextFormField(
                      controller: feedbackuser,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Tell us what you like ...',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  MaterialButton(
                    elevation: 1.0,
                    minWidth: MediaQuery.of(context).size.width - 50,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                      writeData();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }

  writeData() {
    final fb = FirebaseDatabase.instance.reference().child("Feedback");

    fb.child("Feedback " +count.toString()).set({
      'feedback': feedbackuser.text,
      'star' : rating,
    });

  }
}
