import 'package:flutter/material.dart';
import 'package:ref_app/FormContainerWidget.dart';
import 'package:ref_app/home_screen.dart';
import 'package:ref_app/toolbar.dart';

enum FormType {
  LOGIN,
  SIGNUP,
}

class FormPage extends StatelessWidget {
  final FormType? formType;
  const FormPage({super.key, this.formType});

  String getFormName()  {
    switch(formType!) {
      case FormType.LOGIN:
        return "Login";
      case FormType.SIGNUP:
        return "Signup";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                visible: formType == FormType.SIGNUP,
                child: FormContainerWidget(
                  lowerPadding: 10,
                  hintText: "Username",
                  isPasswordField: false,
                ),
              ),
              FormContainerWidget(
                  lowerPadding: 10,
                  hintText: "Email",
                  isPasswordField: false
              ),
              FormContainerWidget(
                  lowerPadding: 30,
                  hintText: "Password",
                  isPasswordField: true
              ),
              GestureDetector(
                onTap: () { Navigator.pushNamed(context, "/home"); },
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
              Visibility(
                visible: formType == FormType.LOGIN,
                child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You don't have an account?"),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () { Navigator.pushNamed(context, "/signup"); },
                        child: Text(
                          "Sign Up!",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )

                    ],
                  ),
              )
        ],
        ),
      ),
    ));
  }
}
