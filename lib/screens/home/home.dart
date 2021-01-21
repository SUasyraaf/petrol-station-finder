import 'package:flutter/material.dart';
import 'package:flutter_project/screens/feedbackpage.dart';
import 'package:flutter_project/services/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_project/screens/profile.dart';
// import 'package:flutter_project/screens/map.dart';
import 'package:flutter_project/screens/mapB.dart';
import 'package:flutter_project/screens/map123.dart';
import 'package:flutter_project/screens/trafficInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  var name,contact,email;

  void getUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
   setState(() {
     name = localStorage.getString('name');
     contact = localStorage.getString('contact');
     email = localStorage.getString('email');
   });
  }

@override
void initState(){
  getUserData();
  super.initState();
}
  @override
  Widget build(BuildContext context) {

    //to get size variable
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(fontFamily: "Montserrat Regular", fontSize: 14);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[50],
      appBar: AppBar(
        title: Text('Petrol Station Finder'),
        backgroundColor: Colors.lightBlueAccent[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.logout),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),

      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/top_header.png')),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(                     //Gambar profile
                children: <Widget>[
                  Container(
                    height: 64,
                    margin : EdgeInsets.only (bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/user.png')
                        ),

                        SizedBox( height: MediaQuery.of(context).size.height*0.05),    //Gap gmbr dengan tulisan

                        Column(
                          //Text sebelah Gambar
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text('Welcome ${name} ! ', style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 17),),
                            Text('Email --> ${email}', style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 14),),
                            Text('Phone --> ${contact}', style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 14),)
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(                         //kotak2 grid menu
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      primary: false,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network('https://www.flaticon.com/svg/static/icons/svg/3555/3555898.svg', height: MediaQuery.of(context).size.height*0.09),
                              RaisedButton(
                                child: Text('Current Location',
                                    style: cardTextStyle,
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapB()));
                                },
                              ),
                            ],
                          ),
                        ),

                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network('https://www.flaticon.com/svg/static/icons/svg/3129/3129668.svg', height: MediaQuery.of(context).size.height*0.09),
                              RaisedButton(
                                child: Text('Nearby Petrol ', style: cardTextStyle ),
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MapB()));
                                },
                              ),
                            ],
                          ),
                        ),

                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network('https://www.flaticon.com/svg/static/icons/svg/2964/2964063.svg', height: MediaQuery.of(context).size.height*0.09),
                              RaisedButton(
                                child: Text('Traffic News', style: cardTextStyle),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrafficInfo()));
                                },
                              ),
                            ],
                          ),
                        ),

                        // Card(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(8)
                        //   ),
                        //   elevation: 10,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: <Widget>[
                        //       SvgPicture.network('https://www.flaticon.com/svg/static/icons/svg/2794/2794147.svg', height: MediaQuery.of(context).size.height*0.09),
                        //       RaisedButton(
                        //         child: Text('Tracking History', style: cardTextStyle),
                        //         onPressed: () {
                        //           Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network('https://www.flaticon.com/svg/static/icons/svg/2991/2991241.svg', height: MediaQuery.of(context).size.height*0.09),
                              RaisedButton(
                                child: Text('Profile', style: cardTextStyle),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                                },
                              ),
                            ],
                          ),
                        ),

                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.network('https://www.flaticon.com/svg/static/icons/svg/813/813357.svg', height: MediaQuery.of(context).size.height*0.09),
                              RaisedButton(
                                child: Text('Feedback', style: cardTextStyle),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Feedbackpage()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
