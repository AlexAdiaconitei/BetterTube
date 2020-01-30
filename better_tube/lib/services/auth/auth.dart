import 'package:better_tube/services/api_service.dart';
import 'package:better_tube/services/database/database.dart';
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

      _accessToken = (await account.authentication).accessToken;

      AuthResult res = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: _accessToken, 
        )
      );

      if(res.user == null)
        return false;

      _user = res.user;

      /* Check if the user is new. */
      if(res.additionalUserInfo.isNewUser) {
        List<String> channelsID;
        try{
          channelsID = await APIService.instance
          .fetchSubscriptionsChannelsID(_accessToken);
        } catch (e) {
          channelsID = new List<String>();
        }

        await DatabaseService(uid: user.uid).updateUserData(
          _accessToken, 
          {},
          channelsID
        );

        // Sample data
        //
        // await DatabaseService(uid: user.uid).updateUserData(
        //   _accessToken, 
        //   {'Aviation': ['UC88tlMjiS7kf8uhPWyBTn_A'], 'Education':['UCyM-2pRapEv6V2q7UNO9icg']},
        //   ['UC88tlMjiS7kf8uhPWyBTn_A', 'UCyM-2pRapEv6V2q7UNO9icg']
        // );
      } else {
        await DatabaseService(uid: user.uid).updateUserAccessToken(_accessToken);
      }

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