import 'package:firebase_auth/firebase_auth.dart';

class EmailServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<LogEmail> createUser({String email, String pass}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return LogEmail(user: result.user);
    } catch (e) {
      return LogEmail(message: e.toString());
    }
  }

  static Future<LogEmail> signIn({String email, String pass}) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return LogEmail(user: result.user);
    } catch (e) {
      return LogEmail(message: e.toString());
    }
  }

  static void signOut() {
    _auth.signOut();
  }
}

class LogEmail {
  final User user;
  final String message;

  LogEmail({this.user, this.message});
}
