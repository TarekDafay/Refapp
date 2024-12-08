import 'package:flutter/material.dart';

class createFussballDEGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Row (
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: ()  {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/home", (Route<
                        dynamic> route) => false);
                  },
                  child: Text("Cancel!"),
                ),
              )
            ]
          )
        ],
      ),
      )
    );
  }

}
