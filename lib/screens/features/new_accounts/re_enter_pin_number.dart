import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_encrypt/constants/colors.dart';

import '../../../utils/helper_methods.dart';
import '../auth/components/pin_key_pad.dart';
import '../gallery/gallery_home.dart';
import 'componets/text.dart';
import 'new_account_gallery_home.dart';

class ReEnterPinNumber extends StatefulWidget {
  const ReEnterPinNumber({Key? key, required this.controler_pin_new})
      : super(key: key);
  final TextEditingController controler_pin_new;
  @override
  State<ReEnterPinNumber> createState() => _ReEnterPinNumberState();
}

class _ReEnterPinNumberState extends State<ReEnterPinNumber> {
  final TextEditingController controler_pin = TextEditingController();
  bool backspacecolorchange = false;
  // final user = FirebaseAuth.instance.currentUser!;

  final Directory _directory = Directory(
      '/storage/emulated/0/Android/data/com.example.safe_encrypt/files');
  String newFolder = '';
  bool confirmpin = true;
  @override
  void dispose() {
    controler_pin.dispose();

    super.dispose();
  }

  @override
  void initState() {
    print(widget.controler_pin_new.text);
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
                      TextWidget(
                          text: confirmpin
                              ? "Re Enter Pin Numberhhh."
                              : " Wrong pin number"),
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(color: kwhite, fontSize: 60),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PinKeyPad(
                              keypad: '1',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}1';
                                });
                              }),
                          PinKeyPad(
                              keypad: '2',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}2';
                                });
                              }),
                          PinKeyPad(
                              keypad: '3',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}3';
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PinKeyPad(
                              keypad: '4',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}4';
                                });
                              }),
                          PinKeyPad(
                              keypad: '5',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}5';
                                });
                              }),
                          PinKeyPad(
                              keypad: '6',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}6';
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PinKeyPad(
                              keypad: '7',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}7';
                                });
                              }),
                          PinKeyPad(
                              keypad: '8',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}8';
                                });
                              }),
                          PinKeyPad(
                              keypad: '9',
                              click: () {
                                setState(() {
                                  backspacecolorchange = false;

                                  controler_pin.text = '${controler_pin.text}9';
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w600),
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
                            width: 65,
                          ),
                          IconButton(
                            onPressed: () async {
                              // print(controler_pin.text);
                              if (widget.controler_pin_new.text ==
                                  controler_pin.text) {
                                createFolder(controler_pin.text);
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewAccountGalleryHome(
                                          controler_pin: controler_pin.text,
                                        ),
                                      ));
                              } else {
                                confirmpin = false;
                              }

                              // if (controler_pin.text ==
                              //     widget.controler_pin_new.text) {
                              //   FacebookAuth.instance
                              //       .getUserData()
                              //       .then((value) async {
                              //     final pinNumber = controler_pin.text;
                              //     final username = value['name'];
                              //     final useremail = value['email'];
                              //     final userpasward = value['id'];
                              //     await createFolder(
                              //         widget.controler_pin_new.text);
                              //     createuser(
                              //       foldername: controler_pin.text,
                              //       pin: pinNumber,
                              //       name: value['name'].toString(),
                              //       email: value['email'].toString(),
                              //       uid: value['id'].toString(),
                              //     );
                              //     // readUsers();

                              //     await Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               NewAccountGalleryHome(
                              //             controler_pin: controler_pin.text,
                              //           ),
                              //         ));
                              //   });
                              //   {
                              //     setState(() {});
                              //   }
                              // }

                              // if (controler_pin.text ==
                              //     widget.controler_pin_new.text) {
                              //   final user =
                              //       FirebaseAuth.instance.currentUser!;
                              //   final pinNumber = controler_pin.text;

                              //   final username = user.displayName;
                              //   final useremail = user.email;
                              //   final userpasward = user.uid;
                              //   await createFolder(
                              //       widget.controler_pin_new.text);
                              //   createuser(
                              //     pin: pinNumber,
                              //     name: username.toString(),
                              //     email: user.email.toString(),
                              //     uid: user.uid.toString(),
                              //     foldername: controler_pin.text,
                              //   );
                              //   // readUsers();

                              //   await Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               NewAccountGalleryHome(
                              //                 controler_pin:
                              //                     controler_pin.text,
                              //               )));
                              // } else {
                              //   setState(() {});
                              // }
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: kwhite,
                              size: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 34,
                          ),
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

  Future<bool> createFolder(String folderName) async {
    Directory? directory;

    try {
      // checks if android
      if (Platform.isAndroid) {
        // request permission
        if (await requestPermission(Permission.storage)) {
          // getting the phone directory
          directory = await getExternalStorageDirectory();
          log(directory!.path);

          // creating the folder path
          String newPath = '';
          List<String> folders = directory.path.split("/");

          for (int i = 1; i < folders.length; i++) {
            String folder = folders[i];
            newPath += "/$folder";
          }

          newPath =
              "$newPath/safe/app/new/$folderName/Main Album"; // new directory

          directory = Directory(newPath);
          log(directory.path);
        } else {
          return false;
        }
      } else {
        // if iOS
        if (await requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      // creating the directory
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}

Future createuser({
  required String pin,
  required String name,
  required String email,
  required String uid,
  required String foldername,
}) async {
  final docUser = FirebaseFirestore.instance.collection('newusers').doc();
  final json = {
    'id': docUser.id,
    'pin': pin,
    'name': name,
    'email': email,
    'uid': uid,
    'foldername': foldername,
  };

  await docUser.set(json);
}
