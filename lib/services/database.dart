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
    String nid,
    String migrant,
    String isContacted,
    String isAnyoneInFamily,
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
    return await covidAnalysisReportCollection.document(phoneNumber).setData({
      'Name': fullName,
      'Age': age,
      'Gender': gender,
      'Profession': profession,
      'Phone': phoneNumber,
      'NID': nid,
      'Migrant': migrant,
      'Came in Contact with NRB': isContacted,
      'Anyone in  the Familu Showing Symptoms': isAnyoneInFamily,
      'Date of First Showing Symptoms': date,
      'Breathing Pattern/Minute': breathCount,
      'Temperature': fever,
      'Symptoms': symptoms,
      'Risk Group': riskGroup,
      'User location': location,
    });
  }
}
