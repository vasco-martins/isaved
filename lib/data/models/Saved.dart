import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/data/models/User.dart';
import 'package:testproject/utils/service_locator.dart';

class Saved with ChangeNotifier {
  DateTime startDate;
  int _days;
  Firestore _firestore;
  final User user;

  double _water;
  double _animals;
  double _land;

  int get days => _days;
  double get land => _land;
  double get water => _water;
  double get animals => _animals;

  Saved.instance(this.user) : _firestore = Firestore.instance {
    _firestore
        .collection('users')
        .document(user.user.uid)
        .snapshots()
        .listen(_onCalc);
  }

  double calcWaterSaved() {
    switch (user.dietType.toLowerCase()) {
      case 'vegan':
        return _days * 41639.0;
      case 'vegetarian':
        return _days * 6750.0;
      case 'carnivore':
        return 0;
    }
  }

  double calcAnimalsSaved() {
    switch (user.dietType.toLowerCase()) {
      case 'vegan':
        return _days.toDouble();
      case 'vegetarian':
        return _days * 0.75;
      case 'carnivore':
        return 0;
    }
  }

  double calcLandSaved() {
    switch (user.dietType.toLowerCase()) {
      case 'vegan':
        return _days * 30.0;
      case 'vegetarian':
        return _days * 22.5;
      case 'carnivore':
        return 0;
    }
  }

  void _onCalc(DocumentSnapshot snapshot) async {
    if (!snapshot.exists) {
      startDate = DateTime.now();
      _days = 0;
    } else {
      startDate = (snapshot.data['start_date'] as Timestamp).toDate();
      _days = DateTime.now().difference(startDate).inDays;
    }
    _animals = calcAnimalsSaved();
    _land = calcLandSaved();
    _water = calcWaterSaved();
    print(_animals);

    notifyListeners();
  }
}
