import 'package:flutter/material.dart';
import 'package:ref_app/FormContainerWidget.dart';
import 'package:ref_app/MatchDatabaseParser.dart';

class createFussballDEGamePage extends StatefulWidget {

  @override
  State<createFussballDEGamePage> createState() => _createFussballDEGamePage_State();
}

class _createFussballDEGamePage_State extends State<createFussballDEGamePage> {

  TextEditingController _linkFieldController = TextEditingController();
  final List<String> _roles = ['Referee', 'Assistant', 'Spectator'];
  String _selectedRole = 'Referee';
  @override
  void dispose() {
    _linkFieldController.dispose();
    super.dispose();
  }

  Widget createDropDownButton() {
    return DropdownButton<String>(
      value: _selectedRole,
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue!;
        });
      },
      items: _roles.map<DropdownMenuItem<String>>((String role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role),
        );
      }).toList(),
    );
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    createDropDownButton()
              ]
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 300,
                child:
                  FormContainerWidget(
                    lowerPadding: 10,
                    hintText: "Fussball.de Match Url",
                    isPasswordField: false,
                    controller: _linkFieldController,
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
                  child: Text("Cancel"),
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: ()  {
                    new FussballDeParser(_linkFieldController.text, _selectedRole);
                    print(_linkFieldController);
                  },
                  child: Text("Submit"),
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
