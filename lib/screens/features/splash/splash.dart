import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_encrypt/screens/features/permission/permission_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../auth/components/pin_number/user_pin.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  // Obtain shared preferences.

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  late SharedPreferences preferences;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        loadbool();
      },
    );
  }

  loadbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var ownerlogin = prefs.getBool('ownerlogin');
      if (ownerlogin == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserPIn()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PermissionScreen()),
        );
      }
    });
  }

  final prefs = SharedPreferences.getInstance();
  TextEditingController controler_pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/splash_girl.svg',
              width: 200,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
