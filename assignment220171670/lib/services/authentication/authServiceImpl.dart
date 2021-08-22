import './authService.dart';
import '/model/member.dart';
import '/model/googleUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/*
 This class is the concrete implementation of [AuthService].
*/
class AuthServiceImpl implements AuthService {
  @override
  Future loginMember(String idNumber, String password) async {
    try {
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future registerMember(Member member) async {
    try {
      //_extractUID
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future googleSignIn() async {
    try {
      return _signInWithGoogle();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future signOut() async {
    try {
      GoogleSignIn().signOut();
    } catch (e) {
      e.toString();
      return null;
    }
  }

  Future _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    User? user = userCredential.user;

    if (user != null) {
      return GoogleUser(
          uid: user.uid, name: user.displayName!, gmail: user.email!);
    } else {
      return null;
    }
  }
}
