import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/data/models/User.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _currentValue = "VEGAN";

  @override
  void initState() {
    super.initState();
  }

  _signInAnonymously() async {
    await Provider.of<User>(context).signInAnonymously(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Choose your diet type",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomRadioButton(
                buttonColor: Colors.white,
                customShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                buttonLables: [
                  "Vegan",
                  "Vegetarian",
                  "Carnivore",
                ],
                buttonValues: [
                  "Vegan",
                  "Vegetarian",
                  "Carnivore",
                ],
                radioButtonValue: (value) {
                  setState(() {
                    this._currentValue = value;
                  });
                },
                selectedColor: Colors.orange.shade400,
                enableShape: true,
                elevation: 0,
              ),
            ),
            Container(
              height: 50,
            ),
            RaisedButton(
              onPressed: _signInAnonymously,
              child: Text("Save", style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              color: Colors.green.shade300,
              elevation: 0.2,
            )
          ],
        ),
      ),
    );
  }
}
