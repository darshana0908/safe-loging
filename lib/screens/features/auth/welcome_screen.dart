import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/pin_number/first_pin_number.dart';

class WelcomeScreen extends StatefulWidget {
  final String email;
  final String name;
  const WelcomeScreen({Key? key, required this.email, required this.name}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    getmail();
    super.initState();
  }

  String? getemail;

  getmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getemail = sharedPreferences.getString('email-${widget.email}${widget.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SingleChildScrollView(
        child: SafeArea(
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
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Text(
                    'Welcome back!',
                    style: TextStyle(fontSize: 25, color: kwhite, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Log in with your Keepsafe account email',
                      style: TextStyle(fontSize: 21, color: Colors.white60, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    getemail.toString(),
                    style: TextStyle(color: kwhite, fontSize: 19),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FirstPinNumber()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: kblue,
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'NEXT',
                        style: TextStyle(fontSize: 17, color: kwhite, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
