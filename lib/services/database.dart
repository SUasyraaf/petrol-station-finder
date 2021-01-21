import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  //collection reference
  final CollectionReference psfCollection = Firestore.instance.collection('psf');
  
}