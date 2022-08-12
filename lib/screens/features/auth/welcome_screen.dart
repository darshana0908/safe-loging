import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';

import 'components/pin_number/first_pin_number.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
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
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 25, color: kwhite, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Log in with your Keepsafe account email', style: TextStyle(fontSize: 17, color: Colors.white60, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      label: const Text(
                        'Email',
                        style: TextStyle(fontSize: 17, color: Colors.white30, fontWeight: FontWeight.w500),
                      ),
                      fillColor: kwhite),
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PinNumber()),
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
    );
  }
}
