import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
            height: MediaQuery.of(context).size.height,
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 6 * 1),
                        Image.asset("assets/ic2.JPG"),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 6 * 1),
                        Text(
                          ' Welcome To Keepsafe ',
                          style: TextStyle(
                              fontSize: 29,
                              color: kwhite,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'A safe place for your privet photos.',
                          style: TextStyle(
                              fontSize: 19,
                              color: kgray,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 55),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SocialLoginButton(
                            fontSize: 17,

                            height: 40,
                            buttonType: SocialLoginButtonType.facebook,
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 55,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              );
                              final LoginResult result =
                                  await FacebookAuth.instance.login(
                                permissions: ['email'],
                                loginBehavior: LoginBehavior.webOnly,
                              );

                              if (result.status == LoginStatus.success) {
                                // Login Success
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .get()
                                    .then(
                                  (QuerySnapshot querySnapshot) {
                                    for (var doc in querySnapshot.docs) {
                                      FacebookAuth.instance
                                          .getUserData()
                                          .then((value) async {
                                        print(value['email']);

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
                                      print(doc['email']);
                                    }
                                  },
                                );

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
                            fontSize: 17,
                            height: 40,
                            buttonType: SocialLoginButtonType.google,
                            onPressed: () async {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return const Center(
                              //       child: CupertinoActivityIndicator(
                              //         radius: 55,
                              //         color: Colors.red,
                              //       ),
                              //     );
                              //   },
                              // );
                              signInWithGoogle(context: context);
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();

                              Navigator.push(
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
                              height: 40,
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

Future<User?> signInWithGoogle({required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    print(user);
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
    } catch (e) {
      // handle the error here
    }
  }

  return user;
}
