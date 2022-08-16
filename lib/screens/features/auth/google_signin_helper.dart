import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class GmailLogin extends StatefulWidget {
  const GmailLogin({Key? key}) : super(key: key);

  @override
  State<GmailLogin> createState() => _GmailLoginState();
}

class _GmailLoginState extends State<GmailLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const UserProfile();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      // ),
    ));
  }
}

// class New extends StatefulWidget {
//   const New({Key? key}) : super(key: key);

//   @override
//   State<New> createState() => _NewState();
// }

// class _NewState extends State<New> {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return Scaffold(
//       body:
//           Column(children: [Text(user.uid), Text(user.displayName.toString())]),
//     );
//   }
// }
