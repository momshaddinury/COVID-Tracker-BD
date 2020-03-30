import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfreportingapp/model/users.dart';

FirebaseUser userUID;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
