// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class FacebooksignnProvider extends ChangeNotifier {
//   final facebookSignIn = FacebookLogin();
//   FacebookUserProfile? _user;

//   FacebookUserProfile get user => _user!;
//   Future FacebookLogin() async {
//     final facebookUser = await FacebookAuthProvider.FACEBOOK_SIGN_IN_METHOD;
//     if (facebookUser == null) return;
    

//     // print(_user!.email);
//     // print(_user!.displayName);

//     final googleAuth = await facebookUser.;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     await FirebaseAuth.instance.signInWithCredential(credential);

//     notifyListeners();
//   }
// }
