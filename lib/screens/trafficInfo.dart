import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/postingClass.dart';
import 'add_post.dart';

class TrafficInfo extends StatefulWidget {
  @override
  _TrafficInfoState createState() => _TrafficInfoState();
}

class _TrafficInfoState extends State<TrafficInfo> {
  final fb = FirebaseDatabase.instance.reference().child("Posting");
  List<Model> list = [];

  @override
  void initState() {
    super.initState();
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key, value) async {
        Model model = new Model(
          title: value['title'],
          info: value['information'],
          key: key,
        );
        setState(() {
          list.add(model);
        });
      });
    });
  }

  DeleteData(BuildContext context, String key) {
    Widget okButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          fb.child(key).remove();
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrafficInfo()));
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
    Widget UI(String title, String info, String key) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 9,
              )
            ]
          ),
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                          TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          info,
                          style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  DeleteData(context, key);
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Traffic Info"),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        color: Colors.grey[100],
        child: list.length == 0
            ? Text("Data is null")
            : new ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return UI(
                      list[index].title, list[index].info, list[index].key);
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(Icons.edit, color: Colors.white),
        backgroundColor: Colors.blue,
        tooltip: "add a post",
      ),
    );
  }
}
