// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/screens/features/gallery/gallery_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pin_key_pad.dart';

class UserPIn extends StatefulWidget {
  UserPIn({
    Key? key,
  }) : super(
          key: key,
        );

  List documents = [];
  bool owner = false;
  bool isLoading = true;
  bool clearicon = false;

  @override
  State<UserPIn> createState() => _UserPInState();
}

class _UserPInState extends State<UserPIn> {
  final TextEditingController controler_re_enter_pin = TextEditingController();
  bool backspacecolorchange = true;
  bool bActive = false;
  bool newpin_nuber = true;
  String usern = '';
  String pas = '';
  String data = '';

  bool confirm_pin = true;
  String name = '';
  bool ownerlogin = true;
  bool isLoading = true;

  late SharedPreferences preferences;
  @override
  void initState() {
    // getData();

    // TODO: implement initState
    super.initState();
  }

// Obtain shared preferences.

  @override
  Widget build(BuildContext context) {
    // @override
    // savebool() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setBool('ownerlogin', ownerlogin);
    //   print(ownerlogin);
    // }

    return Scaffold(
      backgroundColor: confirm_pin ? kdarkblue : kred,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //     icon: Icon(
                //       Icons.arrow_back,
                //       color: kwhite,
                //     ),
                //     onPressed: () {
                //       Navigator.pop(context);
                //     }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      confirm_pin
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 10,
                              child: Image.asset(
                                'assets/ic2.JPG',
                                fit: BoxFit.fill,
                              ),
                            )
                          : const Text(''),
                      Text(
                        confirm_pin ? "" : " Pin Number is wrong Try again",
                        style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(color: kwhite, fontSize: 60),
                          controller: controler_re_enter_pin,
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.backspace_rounded, size: 30, color: backspacecolorchange ? Colors.white60 : kwhite),
                              onPressed: () {
                                controler_re_enter_pin.text = controler_re_enter_pin.text.substring(0, controler_re_enter_pin.text.length - 1);
                                setState(() {
                                  bActive = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PinKeyPad(
                              keypad: '1',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}1';
                                });
                              }),
                          PinKeyPad(
                              keypad: '2',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}2';
                                });
                              }),
                          PinKeyPad(
                              keypad: '3',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}3';
                                });
                              }),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PinKeyPad(
                              keypad: '4',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}4';
                                });
                              }),
                          PinKeyPad(
                              keypad: '5',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}5';
                                });
                              }),
                          PinKeyPad(
                              keypad: '6',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}6';
                                });
                              }),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PinKeyPad(
                              keypad: '7',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}7';
                                });
                              }),
                          PinKeyPad(
                              keypad: '8',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}8';
                                });
                              }),
                          PinKeyPad(
                              keypad: '9',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}9';
                                });
                              }),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            data,
                            style: const TextStyle(color: Colors.white, fontSize: 45, fontWeight: FontWeight.w600),
                          ),
                          PinKeyPad(
                              keypad: '0',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;
                                  bActive = true;
                                  controler_re_enter_pin.text = '${controler_re_enter_pin.text}0';
                                });
                              }),
                          const SizedBox(
                            width: 42,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () async {
                              if (controler_re_enter_pin.text.isNotEmpty) {
                                String path =
                                    "/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${controler_re_enter_pin.text}";
                                bool directoryExists = await Directory(path).exists();
                                bool fileExists = await File(path).exists();
                                if (directoryExists || fileExists) {
                                  // ignore: use_build_context_synchronously
                                  // savebool();
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GalleryHome(pinNumber: controler_re_enter_pin.text),
                                      ));
                                } else {
                                  setState(() {
                                    confirm_pin = false;
                                  });
                                }
                              }

                              // confirm_pin
                              //     ? showDialog(
                              //         context: context,
                              //         builder: (context) {
                              //           return const Center(
                              //             child: CupertinoActivityIndicator(
                              //               radius: 55,
                              //               color: Colors.red,
                              //             ),
                              //           );
                              //         },
                              //       )
                              //     : null;

                              // await FirebaseFirestore.instance
                              //     .collection('users')
                              //     .get()
                              //     .then((QuerySnapshot querySnapshot) {
                              //   for (var doc in querySnapshot.docs) {
                              //     String pinNum = doc['pin'].toString();
                              //     if (pinNum == controler_re_enter_pin.text) {
                              //       print(confirm_pin);
                              //       print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
                              //       FacebookAuth.instance
                              //           .getUserData()
                              //           .then((value) async {
                              //         if (value['id'] == doc['uid']) {
                              //           print(value['id']);
                              //           print(doc['uid'].toString());

                              //           // savebool();

                              //           //loading widget goes here

                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     const GalleryHome(),
                              //               ));
                              //         }
                              //       });

                              //       if (pinNum ==
                              //           controler_re_enter_pin.text) {
                              //         final user =
                              //             FirebaseAuth.instance.currentUser!;
                              //         if (user.uid == doc['uid'].toString()) {
                              //           // savebool();

                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     const GalleryHome(),
                              //               ));
                              //         }

                              //         print(controler_re_enter_pin.text);
                              //       }
                              //     } else {
                              //       setState(() {
                              //         confirm_pin = false;
                              //       });

                              //       // } else {
                              //       //   setState(() {
                              //       //     confirm_pin = false;
                              //       //   });
                              //       // }
                              //     }
                              //   }
                              // });
                            },

                            //   await FirebaseFirestore.instance
                            //       .collection('users')
                            //       .get()
                            //       .then((QuerySnapshot querySnapshot) {
                            //     for (var doc in querySnapshot.docs) {
                            //       String pinNum = doc['pin'].toString();
                            //       if (pinNum == controler_re_enter_pin.text) {
                            //         print(controler_re_enter_pin.text);
                            //         print(pinNum);
                            //         if (user.uid == doc['uid']) {
                            //           savebool();

                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     const GalleryHome(),
                            //               ));
                            //         }
                            //         print(controler_re_enter_pin.text);
                            //       } else {
                            //         setState(() {
                            //           confirm_pin = false;
                            //         });
                            //       }
                            //     }
                            //   });

                            // },

                            //    FacebookAuth.instance
                            //   .getUserData()
                            //   .then((value) async {
                            // print(value['email']);

                            // // Logger().w(value['email']);
                            // // if (isfromSignup) {
                            // //   await checkEmail(context, value['email']);
                            // // } else {
                            // //   await loginWithEmail(context, value['email']);
                            // // }
                            //   };
                            child: Container(
                              alignment: Alignment.center,
                              width: 105,
                              height: 105,
                              child: const Icon(
                                Icons.check_circle,
                                color: Colors.white60,
                                size: 45,
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // loaddata() async {
  //   await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
  //     for (var doc in querySnapshot.docs) {
  //       String pinNum = doc['pin'].toString();
  //       if (pinNum == controler_re_enter_pin.text) {
  //         if (pinNum == controler_re_enter_pin.text) {
  //           FacebookAuth.instance.getUserData().then((value) async {
  //             if (value['id'].toString() == doc['uid'].toString()) {
  //               // Navigator.push(
  //               //     context,
  //               //     MaterialPageRoute(
  //               //       builder: (context) => const GalleryHome(),
  //               //     ));
  //             }
  //           });
  //         }
  //         if (pinNum == controler_re_enter_pin.text) {
  //           final user = FirebaseAuth.instance.currentUser!;
  //           if (user.uid == doc['uid'].toString()) {
  //             // savebool();
  //             nave() async {
  //               // await Navigator.push(
  //               //     context,
  //               //     MaterialPageRoute(
  //               //       builder: (context) => const GalleryHome(),
  //               //     ));
  //             }
  //           }

  //           print(controler_re_enter_pin.text);
  //         }
  //       } else {
  //         setState(() {
  //           confirm_pin = false;
  //         });
  //       }
  //     }
  //   });
  // }

//

// CollectionReference _collectionRef =
//     FirebaseFirestore.instance.collection('users');

// Future<void> getData() async {
//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await _collectionRef.get();

//   // Get data from docs and convert map to List
//   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

//   print(allData);
// }

// Future getDocs() async {
//   List doc = ['pin'];
//   QuerySnapshot querySnapshot =
//       await FirebaseFirestore.instance.collection("users").get();
//   for (int i = 0; i < querySnapshot.docs.length; i++) {
//     var a = querySnapshot.docs[i];
//     print(a.data);
//     print(doc);
//   }
// }
}
