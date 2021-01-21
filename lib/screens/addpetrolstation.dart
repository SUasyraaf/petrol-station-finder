import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/home/home.dart';

class AddPetrolStation extends StatefulWidget {
  @override
  _AddPetrolStationState createState() => _AddPetrolStationState();
}



class _AddPetrolStationState extends State<AddPetrolStation> {
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController pos = new TextEditingController();
  TextEditingController country = new TextEditingController();
  var count=0;

  void getCurrentLength(){
    final fb = FirebaseDatabase.instance.reference().child("Petrol Station Location");

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
        title: Text("New Petrol Station"),
        elevation: 0.0,
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'Adding Petrol Station Location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Petronas,Shell,Petron,BHP etc ..',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Petrol Station Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    hintText: 'Location',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: city,
                  decoration: InputDecoration(
                    hintText: 'Sungai Buloh, Damansara, Jasin etc ...',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "City",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: state,
                  decoration: InputDecoration(
                    hintText: 'Selangor, Pahang, Terengganu, Perak etc ...',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "State",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: pos,
                  decoration: InputDecoration(
                    hintText: '47000, 75120, 44300 etc ...',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Postal Code",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: TextFormField(
                  controller: country,
                  decoration: InputDecoration(
                    hintText: 'Malaysia',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Country",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            MaterialButton(
              elevation: 1.0,
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
      ),
    );
  }
  writeData() {
    final fb = FirebaseDatabase.instance.reference().child("Petrol Station Location");

    fb.child("Petrol Station " +count.toString()).set({
      'petrol station name': name.text,
      'address': address.text,
      'city': city.text,
      'state': state.text,
      'postal code': pos.text,
      'country': country.text,
    });

  }
}
