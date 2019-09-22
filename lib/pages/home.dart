import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:testproject/data/models/Saved.dart';
import 'package:testproject/data/models/User.dart';
import 'package:testproject/utils/service_locator.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user;
  Saved saved;
  Map calcData;

  @override
  void initState() {
    super.initState();
  }

  Future selectDate() async {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2000, 3, 5),
        maxTime: DateTime.now(),
        onChanged: (date) {}, onConfirm: (date) async {
      await user.updateTime(date);
    }, currentTime: DateTime.now(), locale: LocaleType.pt);
  }

  @override
  Widget build(BuildContext context) {
    user = locator.get<User>();
    if (user != null) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeader(context),
            Container(
              height: 50,
            ),
            buildJustByBeing(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ChangeNotifierProvider(
                builder: (_) => Saved.instance(user),
                child: Consumer<Saved>(
                  builder: (context, saved, widget) {
                    if (saved.animals != null) {
                      return Column(
                        children: <Widget>[
                          buildList(
                              Ionicons.getIconData("md-water"),
                              saved.water.toStringAsFixed(2) +
                                  " litters of watter"),
                          buildList(
                            MaterialIcons.getIconData("pets"),
                            saved.animals.toStringAsFixed(2) + " animals",
                          ),
                          buildList(MaterialIcons.getIconData("landscape"),
                              saved.land.toStringAsFixed(2) + " sqm of forest"),
                          Text(
                            "Just in " + saved.days.toString() + " days",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      );
                    } else {
                      return Text("loading...");
                    }
                  },
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    await user.updateTime(DateTime.now());
                  },
                  child: Text("Start Counting Now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  color: Colors.purple.shade300,
                  elevation: 0.2,
                ),
                RaisedButton(
                  onPressed: () {
                    selectDate();
                  },
                  child: Text("Choose Date",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  color: Colors.orange,
                  elevation: 0.2,
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {
                Provider.of<User>(context).signOut();
              },
              child: Text("Change Diet",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              color: Colors.black,
              elevation: 0.2,
            ),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Container buildHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken)),
      ),
      child: Center(
        child: Text(
          user.dietTypeFormat,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 42,
          ),
        ),
      ),
    );
  }

  RichText buildJustByBeing() {
    return RichText(
      text: TextSpan(
          text: "By being ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
          children: <TextSpan>[
            TextSpan(
              text: user.dietType.toLowerCase(),
              style: TextStyle(color: Colors.green),
            ),
            TextSpan(
              text: ' you',
            ),
            TextSpan(
              text: ' saved',
              style: TextStyle(color: Colors.green),
            ),
          ]),
    );
  }

  ListTile buildList(IconData icon, String message) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
        size: 40.0,
      ),
      title: Text(
        message,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
