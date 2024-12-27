import 'package:flutter/material.dart';
import 'firebase_auth_services.dart';

class HomeScreen extends StatelessWidget {
  final FireBaseAuthService _auth = FireBaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (Route<
                  dynamic> route) => false);
          },
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
                child: Text(
                  "Signout",
                  style:
                  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
          ),
        )
      );
  }
}
