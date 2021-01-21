import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class profile extends StatelessWidget {
  Widget textfield({@required String hintText}){
    return Material(
      elevation: 4,
      shadowColor: Colors.blue,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
          child: TextField(
          decoration: InputDecoration(
          hintText : hintText,
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white30,
          filled: true,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(80.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 400,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textfield(
                      hintText:'Username',
                    ),
                    textfield(
                      hintText:'Email',
                    ),
                    textfield(
                      hintText:'Password',
                    ),
                    textfield(
                      hintText:'Confirm Password',
                    ),
                    Container(
                      height : 55,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.black54,
                        child: Center(
                          child: Text("Update", style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,  
                          ),
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/acap.png'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 300, left: 100),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 200, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path,paint);
  }
  @override 
  bool shouldRepaint(CustomPainter oldDelegate)=> false;
}

