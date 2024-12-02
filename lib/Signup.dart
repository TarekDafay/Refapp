import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ref_app/FormPage.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  @override
  void initState()  {
    Future.delayed(
        Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FormPage(formType: FormType.SIGNUP)), (route) => false);
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Welcome to the REFAPP",
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }
}
