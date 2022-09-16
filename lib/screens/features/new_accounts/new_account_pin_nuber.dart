import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/screens/features/new_accounts/pin_key_pad.dart';

import '../../../utils/helper_methods.dart';

import 're_enter_pin_number.dart';
import 'componets/text.dart';

class NewAccountPin extends StatefulWidget {
  const NewAccountPin({Key? key}) : super(key: key);

  @override
  State<NewAccountPin> createState() => _NewAccountPinState();
}

class _NewAccountPinState extends State<NewAccountPin> {
  final TextEditingController controler_pin = TextEditingController();
  bool backspacecolorchange = false;
  String key = 'Your 32 bit key.................';
  String ff = 'f';
  final Directory _directory = Directory(
      '/storage/emulated/0/Android/data/com.example.safe_encrypt/files');
  String newFolder = '';

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
                      const TextWidget(text: "Create a PIN to lock your vault"),
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
                              onPressed: () {
                                setState(() {});

                                //   if (controler_pin.text == key) {
                                //     main();
                                //     print('okkkkkk');
                                //   } else {
                                //     print('qqqqqqqqqqqqqqqqqqqq');
                                //   }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReEnterPinNumber(
                                          controler_pin_new: controler_pin),
                                    ));
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

  Future<bool> createFolder(String folderName) async {
    Directory? directory;
    folderName = folderName;
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

          newPath = "$newPath/${DateTime.now().millisecond}newaccount";
          newPath = "$newPath/Main Album";

          // new directory

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
