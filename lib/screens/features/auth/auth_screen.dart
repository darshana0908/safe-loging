import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/screens/features/auth/components/pin_number/first_pin_number.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../../providers/google_sign_provider.dart';
import '../gallery/gallery_home.dart';
import 'google_signin_helper.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreen createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: kwhite,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),
                        SvgPicture.asset(
                          'assets/pramisson_1.svg',
                          color: Colors.limeAccent,
                          width: 150,
                        ),
                        const SizedBox(height: 100),
                        Text(
                          ' Welcome To Keepsafe ',
                          style: TextStyle(fontSize: 25, color: kwhite),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'A safe place for your privet photos.',
                          style: TextStyle(fontSize: 17, color: kgray),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 55),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SocialLoginButton(
                            buttonType: SocialLoginButtonType.facebook,
                            onPressed: () async {
                              final LoginResult result =
                                  await FacebookAuth.instance.login(
                                permissions: ['email'],
                                loginBehavior: LoginBehavior.webOnly,
                              );

                              if (result.status == LoginStatus.success) {
                                // Login Success

                                FacebookAuth.instance
                                    .getUserData()
                                    .then((value) async {
                                  print(value['email']);
                                  print(value['']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FirstPinNumber()),
                                  );

                                  // Logger().w(value['email']);
                                  // if (isfromSignup) {
                                  //   await checkEmail(context, value['email']);
                                  // } else {
                                  //   await loginWithEmail(context, value['email']);
                                  // }
                                });

                                // isLoadingFb = false;
                              } else if (result.status ==
                                  LoginStatus.operationInProgress) {
                                // Login Process Ongoing
                              } else if (result.status == LoginStatus.failed) {
                                // Login Failed
                                // isLoadingFb = false;

                                // DialogBoxes.showSnackBarDialog(context, 'Login failed !', color: kRed);
                              } else if (result.status ==
                                  LoginStatus.cancelled) {
                                // Login Cancelled
                                // isLoadingFb = false;

                                // DialogBoxes.showSnackBarDialog(context, 'Login Cancelled !', color: kRed);
                              }
                            },
                            // onPressed: () {
                            //   signInWithFacebook();
                            // },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SocialLoginButton(
                            buttonType: SocialLoginButtonType.google,
                            onPressed: () async {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GmailLogin()));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              color: kblue,
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'NEW? SIGN UP HERE',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: kwhite,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const NewSignupPage()),
                              // );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GalleryHome(
                                          isFake: true,
                                        )),
                              );
                            },
                          ),
                        ),
                        // const SizedBox(height: 25),
                        // TextButton(
                        //   child: const Text('LOG IN'),
                        //   onPressed: () {},
                        // )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> signInWithGoogle(
  //   void Function(String errorMessage) errorCallback,
  // ) async {
  //   try {
  //     var googleSignIn;
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser!.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth!.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //   } on PlatformException catch (e) {
  //     if (e.code == GoogleSignIn.kNetworkError) {
  //       String errorMessage =
  //           "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
  //       errorCallback(errorMessage);
  //     } else {
  //       String errorMessage = "Something went wrong.";
  //       errorCallback(errorMessage);
  //     }
  //   }
  // }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance
  //       .login(permissions: ['email', 'public_profile']);

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //   final userData = await FacebookAuth.instance.getUserData();
  //   userEmail = userData['email'];
  //   print(userEmail);

  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow

    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    print(loginResult);
    print('ggggggggggggggggggggggggggg');
    // Once signed in, return the UserCredential

    return FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .whenComplete(() {
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        btnOkText: 'Continue',
        title: 'Succes',
        desc: 'Welcom to keepsafe',
        btnOkOnPress: () {
          isFake:
          false;
          debugPrint('Continue');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FirstPinNumber()),
          );
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    });
  }
}
