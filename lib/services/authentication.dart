import 'package:covidtrackerbd/model/patientDataModel.dart';
import 'package:covidtrackerbd/model/users.dart';
import 'package:covidtrackerbd/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser userUID;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  PatientDataModel model;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Stream to listen to Auth Change:
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      userUID = result.user;
      print("userUID: ${userUID.uid}");
      return _userFromFirebaseUser(userUID);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateDB() async {
//    print("updateDB");
//    print(model.fullName);
//    print(model.age);
//    print(model.phoneNumber);
//    print(model.profession);
//    print(model.breathCount);
//    print(model.temp);
//    print(model.interaction);
    // create a new document for the user with uid
    await DatabaseService(uid: userUID.uid).updateData(
        fullName,
        age,
        gender,
        profession,
        phoneNumber,
        isContacted,
        date,
        breathCount,
        fever,
        symptoms,
        location,
        riskGroup);
  }

  // sign in with email and password

  // register with email and password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
