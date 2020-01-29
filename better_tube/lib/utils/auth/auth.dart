import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<bool> signInWithGoogle();
  Future<FirebaseUser> currentUser();
  Future<bool> signOut();
  FirebaseUser get user;
  String get accessToken;
}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseUser _user;
  String _accessToken;

  FirebaseUser get user => _user;
  String get accessToken => _accessToken;

  @override
  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
        'email',
        'profile',
        'openid',
        'https://www.googleapis.com/auth/youtube.readonly',
        ],
      );
      GoogleSignInAccount account = await googleSignIn.signIn();

      if(account == null )
        return false;

      AuthResult res = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken, 
      ));

      if(res.user == null)
        return false;

      _user = res.user;
      _accessToken = (await account.authentication).accessToken;

      print("User logged in with Google.");
      return true;
    } catch (e) {
      print("Error logging with Google.");
      return false;
    }
  }

  @override
  Future<FirebaseUser> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    if(user != null)
      _user = user;
    return user;
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Error logging out.");
      return false;
    }
    print("User logged out.");
    return true;
  }
}