import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference covidAnalysisReportCollection =
      Firestore.instance.collection('COVIDARC');

  Future updateData(
    String fullName,
    int age,
    String gender,
    String profession,
    String phoneNumber,
    String isContacted,
    List<DateTime> date,
    String breathCount,
    String fever,
    List<dynamic> symptoms,
    String location,
    List<dynamic> riskGroup,
    /*String isInfected,
    int temp,
    int interaction,*/
  ) async {
    return await covidAnalysisReportCollection.document(uid).setData({
      'a.Name': fullName,
      'b.Age': age,
      'c.Gender': gender,
      'd.Profession': profession,
      'e.Phone': phoneNumber,
      'f.Did you come in contact with others': isContacted,
      'g.Date of First Showing Symptoms': date,
      'h.Breathing Pattern/Minute': breathCount,
      'i.Temperature': fever,
      'j.Symptoms': symptoms,
      'k.Risk Group': riskGroup,
      'l.User location': location,
    });
  }
}
