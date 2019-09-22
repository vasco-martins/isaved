import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/data/models/Saved.dart';
import 'package:testproject/data/models/User.dart';
import 'package:testproject/pages/home.dart';
import 'package:testproject/pages/settings.dart';
import 'package:testproject/utils/service_locator.dart';

class Landing extends StatelessWidget {
  const Landing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<User>(
            builder: (_) => locator.get<User>(),
          ),
        ],
        child: Consumer<User>(
          builder: (context, user, widget) {
            return getRoute(user.status);
          },
        ));
  }

  Widget getRoute(Status status) {
    print(status.toString());
    switch (status) {
      case Status.Uninitialized:
        return CircularProgressIndicator();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Settings();
      case Status.Authenticated:
        return Home();
      default:
        return CircularProgressIndicator();
    }
  }
}
