import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ref_app/FormContainerWidget.dart';
import 'package:ref_app/firebase_auth_services.dart';
import 'package:ref_app/Settings_Page.dart';
import 'package:ref_app/toolbar.dart';

enum FormType {
  LOGIN,
  SIGNUP,
}

class FormPage extends StatefulWidget {
  final FormType? formType;
  const FormPage({super.key, this.formType});

  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final FireBaseAuthService _auth = FireBaseAuthService();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String getFormName()  {
    switch(widget.formType!) {
      case FormType.LOGIN:
        return "Login";
      case FormType.SIGNUP:
        return "Signup";
    }
  }

  bool isLogIn() {
    return widget.formType == FormType.LOGIN;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getFormName()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getFormName(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Visibility(
                visible: !isLogIn(),
                child: FormContainerWidget(
                  lowerPadding: 10,
                  hintText: "Username",
                  isPasswordField: false,
                  controller: _userNameController,
                ),
              ),
              FormContainerWidget(
                  lowerPadding: 10,
                  hintText: "Email",
                  isPasswordField: false,
                  controller: _emailController,
              ),
              FormContainerWidget(
                  lowerPadding: 30,
                  hintText: "Password",
                  isPasswordField: true,
                  controller: _passwordController,
              ),
              GestureDetector(
                onTap: () {
                  if(isLogIn()) {
                    signIn();
                  } else  {
                    signUp();
                  }
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
                      getFormName(),
                      style:
                      TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isLogIn() ? "You don't have an account?" : "You already have an account?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      if(isLogIn()) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/signup", (Route<
                            dynamic> route) => false);
                      } else  {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (Route<
                            dynamic> route) => false);
                      }
                    },
                    child: Text(
                      isLogIn() ? "Sign Up" : "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )

                ],
              ),
        ],
        ),
      ),
    ));
  }

  void signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if(user!= null) {
      print("User successfully created");
      Navigator.pushNamedAndRemoveUntil(context, "/home",(Route<dynamic> route) => false);
    } else  {
      print("Some error happened");
    }
  }

  void signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if(user!= null) {
      Navigator.pushNamedAndRemoveUntil(context, "/home",(Route<dynamic> route) => false);
      print("User successfully logged In");
    } else  {
      print("Some error happened");
    }
  }
}
