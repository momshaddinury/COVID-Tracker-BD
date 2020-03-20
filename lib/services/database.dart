import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference covidAnalysisReportCollection =
      Firestore.instance.collection('COVIDARC');

  Future updateData(
    String fullName,
    String gender,
    int age,
    String phoneNumber,
    String isInfected,
    String profession,
    int breathCount,
    int temp,
    int interaction,
    String date,
    String isContacted,
    String location,
  ) async {
    return await covidAnalysisReportCollection.document(uid).setData({
      'a.Name': fullName,
      'b.Gender': gender,
      'c.Age': age,
      'd.Phone': phoneNumber,
      'e.Are you Patient': isInfected,
      'f.Profession': profession,
      'g.Breathing Pattern/Minute': breathCount,
      'h.Temperature': temp,
      'i.Interaction with People': interaction,
      'j.Date of First Showing Symptoms': date,
      'k.Did you come in contact with others': isContacted,
      'l.User location': location,
    });
  }
}
