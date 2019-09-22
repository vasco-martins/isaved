import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testproject/data/models/Saved.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class User with ChangeNotifier {
  FirebaseAuth _auth;
  Firestore _firestore = Firestore.instance;

  FirebaseUser _user;

  String _dietType;
  DateTime _startDate;

  Status _status = Status.Uninitialized;
  Saved _saved;

  User();

  User.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;
  String get dietType => _dietType;
  DateTime get startDate => _startDate;
  String get dietTypeFormat =>
      _dietType[0].toUpperCase() + _dietType.substring(1).toLowerCase();

  Future<void> updateDietType(String dietType) async {
    await _firestore
        .collection('users')
        .document(_user.uid)
        .updateData({'dietType': dietType});
    notifyListeners();
  }

  Future<void> updateTime(DateTime date) async {
    await _firestore
        .collection('users')
        .document(_user.uid)
        .updateData({'start_date': date});
    notifyListeners();
  }

  Future<bool> signInAnonymously(String _currentValue) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await FirebaseAuth.instance.signInAnonymously();
      await Firestore.instance
          .collection('users')
          .document(user.uid)
          .setData({'dietType': _currentValue, 'start_date': DateTime.now()});
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e);
    }
  }

  Future<bool> signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  Future<void> _onUpdateData(DocumentSnapshot snapshot) async {
    if (snapshot.exists) {
      _dietType = snapshot.data['dietType'];
      _startDate = snapshot.data['start_date'] == null
          ? DateTime.now()
          : (snapshot.data['start_date'] as Timestamp).toDate();
      notifyListeners();
    }
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      await _firestore
          .collection('users')
          .document(firebaseUser.uid)
          .get()
          .then(_onUpdateData);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
