import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:safe_encrypt/utils/helper_methods.dart';
import '../../../../../services/icon.dart';
import '../pin_key_pad.dart';

class ReEnterPin extends StatefulWidget {
  const ReEnterPin({Key? key, required this.controler_pin}) : super(key: key);
  final TextEditingController controler_pin;

  @override
  State<ReEnterPin> createState() => _ReEnterPinState();
}

class _ReEnterPinState extends State<ReEnterPin> {
  final TextEditingController controler_re_enter_pin = TextEditingController();
  final Directory directory = Directory(
      '/storage/emulated/0/Android/data/com.example.safe_encrypt/files');
  bool backspacecolorchange = true;

  bool newpin_nuber = true;
  String login = 'fb';
  String gloging = 'gmail';

  Future register() async {
    if (controler_re_enter_pin.text == widget.controler_pin.text) {
      FacebookAuth.instance.getUserData().then((value) async {
        final pinNumber = controler_re_enter_pin.text;

        var url =
            Uri.http('192.168.1.160', '/flutter/register.php', {'q': '{http}'});
        var response = await http.post(url, body: {
          "status": login,
          "pin": pinNumber,
          "name": value['name'].toString(),
          "email": value['email'].toString(),
          "uid": value['id'].toString(),
        });
        var data = jsonDecode(response.body);
      });
    }
    if (controler_re_enter_pin.text == widget.controler_pin.text) {
      final user = FirebaseAuth.instance.currentUser!;

      print(user.displayName);
      print(user.email);
      final pinNumber = controler_re_enter_pin.text;
      final username = user.displayName;
      String fb;
      var url =
          Uri.http('192.168.1.160', '/flutter/register.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "pin": controler_re_enter_pin.text,
        "name": username.toString(),
        "email": user.email.toString(),
        "uid": user.uid.toString(),
        "status": gloging,
      });
      // readUsers();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SafeArea(
        child: SizedBox(
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          newpin_nuber
                              ? "Re Enter Pin Number."
                              : " Pin Number is wrong Try again",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 6 * 0.25),

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
                                icon: Icon(Icons.backspace_rounded,
                                    color: backspacecolorchange
                                        ? Colors.white60
                                        : kwhite),
                                onPressed: () {
                                  controler_re_enter_pin.text =
                                      controler_re_enter_pin.text.substring(
                                          0,
                                          controler_re_enter_pin.text.length -
                                              1);
                                },
                              ),
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

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}1';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '2',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}2';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '3',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}3';
                                  });
                                }),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinKeyPad(
                                keypad: '4',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}4';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '5',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}5';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '6',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}6';
                                  });
                                }),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PinKeyPad(
                                keypad: '7',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}7';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '8',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}8';
                                  });
                                }),
                            PinKeyPad(
                                keypad: '9',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}9';
                                  });
                                }),
                          ],
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
                            const SizedBox(),
                            PinKeyPad(
                                keypad: '0',
                                click: () {
                                  setState(() {
                                    backspacecolorchange = false;

                                    controler_re_enter_pin.text =
                                        '${controler_re_enter_pin.text}0';
                                  });
                                }),
                            const SizedBox(
                              width: 65,
                            ),
                            IconButton(
                              onPressed: () async {
                                createFolder(controler_re_enter_pin.text);
                                register();
                                if (controler_re_enter_pin.text ==
                                    widget.controler_pin.text) {
                                  FacebookAuth.instance
                                      .getUserData()
                                      .then((value) async {
                                    final pinNumber =
                                        controler_re_enter_pin.text;

                                    createuser(
                                      status: login,
                                      pin: pinNumber,
                                      name: value['name'].toString(),
                                      email: value['email'].toString(),
                                      uid: value['id'].toString(),
                                    );

                                  

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AppIcon(),
                                        ));

                                    // readUsers();
                                  });
                                }
                                if (controler_re_enter_pin.text ==
                                    widget.controler_pin.text) {
                                  final user =
                                      FirebaseAuth.instance.currentUser!;

                                  print(user.displayName);
                                  print(user.email);
                                  final pinNumber = controler_re_enter_pin.text;
                                  final username = user.displayName;
                                  String fb;
                                  createuser(
                                    pin: pinNumber,
                                    name: username.toString(),
                                    email: user.email.toString(),
                                    uid: user.uid.toString(),
                                    status: gloging,
                                  );
                                  // readUsers();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AppIcon(),
                                      ));
                                } else {
                                  setState(() {
                                    newpin_nuber = false;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.white60,
                                size: 45,
                              ),
                            ),
                            const SizedBox(
                              width: 34,
                            )
                          ],
                        ),

                        // StreamBuilder<List<User>>(
                        //     stream: readUsers(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasError) {
                        //         return const Text('ggggggggggg');
                        //       } else if (snapshot.hasData) {
                        //         final users = snapshot.data!;
                        //         return const Text('hhhh');
                        //         ListView(children: users.map(buildUser).toList());
                        //       } else {
                        //         return const Text('jjjjjjjjjjjjj');
                        //       }
                        //     })
                      ]),
                ),
              ),
            ],
          ),
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
// Widget buildUser(User user) => Column(
//       children: [
//         Text(user.email),
//         Text(user.id),
//         Text(user.name),
//         Text(user.pin),
//         Text(user.uid),
//       ],
//     );

Future createuser({
  required String pin,
  required String name,
  required String email,
  required String uid,
  required String status,
}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  final json = {
    'id': docUser.id,
    'pin': pin,
    'name': name,
    'email': email,
    'uid': uid,
    'status': status,
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

//   Stream<List<User>> readUsers() => FirebaseFirestore.instance
//       .collection('users')
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
// }

// class User {
//   String id;
//   final String pin;
//   final String name;
//   final String email;
//   final String uid;

//   User({
//     this.id = '',
//     required this.pin,
//     required this.name,
//     required this.email,
//     required this.uid,
//   });
//   Map<String, dynamic> tojson() => {
//         'id': id,
//         'pin': pin,
//         'name': name,
//         'email': email,
//         'uid': uid,
//       };
//   static User fromJson(Map<String, dynamic> json) => User(
//         email: json['id'],
//         name: json['name'],
//         pin: json['pin'],
//         uid: json['uid'],
//       );
// }

// class extEditingController extends ChangeNotifier {
//   TextEditingController controler_pin = TextEditingController();

//   TextEditingController get getcontroler_pin => controler_pin;
//   setcontroler() {
//     controler_pin.text;
//     notifyListeners();
//   }
// }
