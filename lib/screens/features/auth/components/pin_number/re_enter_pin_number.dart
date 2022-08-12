import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/screens/features/auth/components/pin_number/user_pin.dart';

import '../pin_key_pad.dart';

class ReEnterPin extends StatefulWidget {
  const ReEnterPin({Key? key, required this.controler_pin}) : super(key: key);
  final TextEditingController controler_pin;

  @override
  State<ReEnterPin> createState() => _ReEnterPinState();
}

class _ReEnterPinState extends State<ReEnterPin> {
  final TextEditingController controler_re_enter_pin = TextEditingController();
  bool backspacecolorchange = false;
  final user = FirebaseAuth.instance.currentUser!;
  bool newpin_nuber = true;

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
                        newpin_nuber
                            ? "Re Enter Pin Number."
                            : " Pin Number is wrong Try again",
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
                          const Text(
                            '',
                            style: TextStyle(
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
                            onPressed: () async {
                              if (controler_re_enter_pin.text ==
                                  widget.controler_pin.text) {
                                final pinNumber = controler_re_enter_pin.text;
                                final username = user.displayName;
                                final useremail = user.email;
                                final userpasward = user.uid;
                                createuser(
                                  pin: pinNumber,
                                  name: username.toString(),
                                  email: user.email.toString(),
                                  uid: user.uid.toString(),
                                );
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserPIn(
                                          controler_pin:
                                              controler_re_enter_pin),
                                    ));
                              } else {
                                setState(() {
                                  newpin_nuber = false;
                                });
                              }
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

  Future createuser({
    required String pin,
    required String name,
    required String email,
    required String uid,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final json = {
      'pin': pin,
      'name': name,
      'email': email,
      'uid': uid,
    };

    await docUser.set(json);
  }
}
