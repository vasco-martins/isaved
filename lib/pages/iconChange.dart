import 'package:flutter/material.dart';

class IconChange extends StatefulWidget {
  IconChange({Key key}) : super(key: key);

  _IconChangeState createState() => _IconChangeState();
}

class _IconChangeState extends State<IconChange> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          setState(() {
            this.isClicked = !this.isClicked;
          });
        },
        child: Row(
          children: <Widget>[
            Text("Click Me"),
            Icon(
              Icons.star,
              color: isClicked ? Colors.orange : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
