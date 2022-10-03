import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/screens/features/new_accounts/pin_key_pad.dart';

import '../gallery/gallery_home.dart';

class NewAccountLoging extends StatefulWidget {
  const NewAccountLoging({Key? key}) : super(key: key);

  @override
  State<NewAccountLoging> createState() => _NewAccountLogingState();
}

class _NewAccountLogingState extends State<NewAccountLoging> {
  final TextEditingController controler_pin = TextEditingController();

  bool backspacecolorchange = false;

  String ff = 'f';
  bool confirm_pin = true;
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('newusers');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SafeArea(
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
              padding: const EdgeInsets.all(40.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        confirm_pin
                            ? "Please confirm your pin to \n continue."
                            : "wrong pin Try Again",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        style: TextStyle(color: kwhite, fontSize: 35),
                        controller: controler_pin,
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.backspace_rounded,
                              color: backspacecolorchange ? kgray : kwhite,
                            ),
                            onPressed: () {
                              controler_pin.text = controler_pin.text
                                  .substring(0, controler_pin.text.length - 1);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinKeyPad(
                                keypad: '1',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}1';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '2',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}2';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '3',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}3';
                                  });
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinKeyPad(
                                keypad: '4',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}4';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '5',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}5';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '6',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}6';
                                  });
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinKeyPad(
                                keypad: '7',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}7';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '8',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}8';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '9',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_pin.text =
                                        '${controler_pin.text}9';
                                  });
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 173,
                          ),
                          PinKeyPad(
                              keypad: '0',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}0';
                                });
                              }),
                          const SizedBox(
                            width: 85,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                color: Colors.brown),
                            width: 65,
                            height: 65,
                            child: IconButton(
                              onPressed: () async {
                                String path =
                                    "/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${controler_pin.text}";
                                bool directoryExists =
                                    await Directory(path).exists();
                                bool fileExists = await File(path).exists();
                                if (directoryExists || fileExists) {
                                  // ignore: use_build_context_synchronously
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GalleryHome(
                                          pinnumber: controler_pin.text,
                                        ),
                                      ));
                                } else {
                                  setState(() {
                                    confirm_pin = false;
                                  });
                                }

                                // await FirebaseFirestore.instance
                                //     .collection('newusers')
                                //     .get()
                                //     .then((QuerySnapshot querySnapshot) {
                                //   for (var doc in querySnapshot.docs) {
                                //     String pinNum =
                                //         doc['foldername'].toString();

                                //     FacebookAuth.instance
                                //         .getUserData()
                                //         .then((value) async {
                                //       if (value['id'].toString() ==
                                //           doc['uid'].toString()) {
                                //         if (controler_pin.text == pinNum) {
                                //           await Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     NewAccountGalleryHome(
                                //                   controler_pin:
                                //                       controler_pin.text,
                                //                 ),
                                //               ));
                                //         }
                                //       }
                                //     });

                                //     final user =
                                //         FirebaseAuth.instance.currentUser!;
                                //     if (user.uid == doc['uid'].toString()) {
                                //       if (user.email ==
                                //           doc['email'].toString()) {
                                //         if (controler_pin.text == pinNum) {
                                //           Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     NewAccountGalleryHome(
                                //                   controler_pin:
                                //                       controler_pin.text,
                                //                 ),
                                //               ));
                                //         }
                                //       }
                                //     } else {
                                //       setState(() {
                                //         confirm_pin = false;
                                //       });
                                //     }
                                //   }
                                // });

                                // print(controler_pin.text);
                                // await FirebaseFirestore.instance
                                //     .collection('newusers')
                                //     .get()
                                //     .then((QuerySnapshot querySnapshot) {
                                //   for (var doc in querySnapshot.docs) {
                                //     String foldername =
                                //         doc['foldername'].toString();

                                //     String umail = doc['email'].toString();
                                //     if (foldername == controler_pin.text) {
                                //       if (foldername == controler_pin.text) {
                                //         FacebookAuth.instance
                                //             .getUserData()
                                //             .then((value) async {
                                //           String userid =
                                //               value['id'].toString();
                                //           if (userid == doc['uid']) {
                                //             Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       NewAccountGalleryHome(
                                //                     controler_pin:
                                //                         controler_pin.text,
                                //                   ),
                                //                 ));
                                //           }
                                //         });
                                //       }
                                //       if (foldername == controler_pin.text) {
                                //         final user =
                                //             FirebaseAuth.instance.currentUser!;
                                //         if (user.uid == doc['uid']) {
                                //           print(user.uid);
                                //           Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     NewAccountGalleryHome(
                                //                   controler_pin:
                                //                       controler_pin.text,
                                //                 ),
                                //               ));
                                //         }

                                //         print(controler_pin.text);
                                //       }
                                //     } else {
                                //       confirm_pin = false;
                                //     }
                                //   }
                                // });
                              },
                              icon: Icon(
                                Icons.check_circle,
                                color: kwhite,
                                size: 50,
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loaddata() async {}

  Future createuser({
    required String pin,
    required String name,
    required String email,
    required String uid,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('newusers').doc();
    final json = {
      'id': docUser.id,
      'pin': pin,
      'name': name,
      'email': email,
      'uid': uid,
    };
    // final user = User(
    //   id: docUser.id,
    //   pin: pin,
    //   name: name,
    //   email: email,
    //   uid: uid,
    // );
    await docUser.set(json);
  }

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('newusers');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("newusers").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
    }
  }
}
