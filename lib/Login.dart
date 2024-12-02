import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ref_app/FormPage.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState()  {
    Future.delayed(
      Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FormPage(formType: FormType.LOGIN)), (route) => false);
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
