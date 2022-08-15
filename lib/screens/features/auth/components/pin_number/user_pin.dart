import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/screens/features/gallery/gallery_home.dart';

import '../pin_key_pad.dart';

class UserPIn extends StatefulWidget {
  UserPIn({Key? key, required this.controler_pin}) : super(key: key);
  final TextEditingController controler_pin;

  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('users');
  List documents = [];

  @override
  State<UserPIn> createState() => _UserPInState();
}

class _UserPInState extends State<UserPIn> {
  final TextEditingController controler_re_enter_pin = TextEditingController();
  bool backspacecolorchange = false;
  final user = FirebaseAuth.instance.currentUser!;
  bool newpin_nuber = true;
  String usern = '';
  String pas = '';
  String data = '';

  bool pin = true;
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

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
                      pin ? const Text('') : const Text("ffffff"),
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        style: TextStyle(color: kwhite, fontSize: 35),
                        controller: controler_re_enter_pin,
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.backspace_rounded,
                              color: backspacecolorchange ? kgray : kwhite,
                            ),
                            onPressed: () {
                              controler_re_enter_pin.text =
                                  controler_re_enter_pin.text.substring(0,
                                      controler_re_enter_pin.text.length - 1);
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

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '1';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '2',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '2';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '3',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '3';
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

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '4';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '5',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '5';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '6',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '6';
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

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '7';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '8',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '8';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '9',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        controler_re_enter_pin.text + '9';
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
                          Text(
                            data,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 190,
                          ),
                          PinKeyPad(
                              keypad: '0',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_re_enter_pin.text =
                                      controler_re_enter_pin.text + '0';
                                });
                              }),
                          const SizedBox(
                            width: 115,
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                for (var doc in querySnapshot.docs) {
                                  if (doc['pin'] ==
                                      controler_re_enter_pin.text) {
                                    if (user.uid == doc['uid']) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const GalleryHome(),
                                          ));
                                      print(doc['uid']);
                                    }
                                    print(controler_re_enter_pin.text);
                                  } else {
                                    print('fff');
                                    print(pin);
                                  }
                                }
                              });
                              // getDocs();
                              // FirebaseFirestore.instance
                              //     .collection('users')
                              //     .where('uid', isEqualTo: user.uid)
                              //     .snapshots()
                              //     .listen((data) => {
                              //           print(user.email),
                              //           print(controler_re_enter_pin.text)
                              //         });
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => GetUserName(data),
                              //     ));
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: kwhite,
                              size: 50,
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

  // Future createuser({
  //   required String pin,
  //   required String name,
  //   required String email,
  //   required String uid,
  // }) async {
  //   final docUser = FirebaseFirestore.instance.collection('users').doc();
  //   final json = {
  //     'pin': pin,
  //     'name': name,
  //     'email': email,
  //     'uid': uid,
  //   };

  //   await docUser.set(json);
  // }
}

final _fireStore = FirebaseFirestore.instance;

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('users');

Future<void> getData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  querySnapshot.docs
      .map((doc) => print(doc["name"])
          // ListTile(
          //     title: Text(doc["name"]), subtitle: Text(doc["amount"].toString()))
          )
      .toList();
  print(allData);
  allData.length;
}

Future getDocs() async {
  List doc = ['name', 'pin'];
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("users").get();
  for (int i = 0; i < querySnapshot.docs.length; i++) {
    var a = querySnapshot.docs[i];
    print(a.data);
    print(doc[1]);
  }
}
