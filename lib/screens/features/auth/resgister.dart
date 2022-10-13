import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/screens/features/auth/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameControler = TextEditingController();
  final emailControler = TextEditingController();
  bool enterEmail = false;
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
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const Text(
                  "Add email an in case your forget.",
                  style: TextStyle(color: Colors.white60, fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    controller: nameControler,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'name',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                        label: Text('Name', style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    controller: emailControler,
                    validator: (value) {
                      var result = EmailValidator.validate(value.toString());
                      return result ? null : "Please enter a valid email";
                    },
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Example@.com ',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                        label: Text('Email', style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    color: kliteblue,
                    child: const Text(
                      'Finish',
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () async {
                    if (nameControler.text.isNotEmpty &&
                        emailControler.text.isNotEmpty &&
                        emailControler.text.contains('@') &&
                        emailControler.text.contains('.')) {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      await sharedPreferences.setString('email-${emailControler.text}${nameControler.text}', emailControler.text);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(email: emailControler.text, name: nameControler.text),
                          ));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Container(
                            alignment: Alignment.center,
                            height: 110,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Enter valid email and name',
                                  style: TextStyle(
                                    color: kred,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 100,
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(fontSize: 25, color: Colors.blue),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
